import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../core/constants/app_constants.dart';
import '../../../models/photo_position.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/providers/providers.dart';
import '../../../shared/widgets/widgets.dart';
import '../providers/guided_capture_provider.dart';
import '../services/plate_blur_service.dart';
import '../widgets/widgets.dart';

class GuidedCaptureScreen extends ConsumerStatefulWidget {
  const GuidedCaptureScreen({super.key});

  @override
  ConsumerState<GuidedCaptureScreen> createState() =>
      _GuidedCaptureScreenState();
}

class _GuidedCaptureScreenState extends ConsumerState<GuidedCaptureScreen>
    with WidgetsBindingObserver {
  CameraController? _cameraController;
  List<CameraDescription>? _cameras;
  bool _isInitialized = false;
  bool _hasPermission = false;
  String? _errorMessage;
  final _plateBlurService = PlateBlurService();
  double _minZoom = 1.0;
  double _maxZoom = 1.0;
  double _currentZoom = 1.0;
  double _baseZoom = 1.0;
  String? _previewPath;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    _initializeCamera();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _cameraController?.dispose();
    _plateBlurService.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      _cameraController?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _initializeCamera();
    }
  }

  Future<void> _initializeCamera() async {
    final status = await Permission.camera.request();
    if (!status.isGranted) {
      setState(() {
        _hasPermission = false;
        _errorMessage = 'Se requiere permiso de cámara para tomar fotos';
      });
      return;
    }
    setState(() => _hasPermission = true);

    try {
      _cameras = await availableCameras();
      if (_cameras == null || _cameras!.isEmpty) {
        setState(() => _errorMessage = 'No hay cámaras disponibles');
        return;
      }
      final backCamera = _cameras!.firstWhere(
        (c) => c.lensDirection == CameraLensDirection.back,
        orElse: () => _cameras!.first,
      );
      _cameraController = CameraController(
        backCamera,
        ResolutionPreset.high,
        enableAudio: false,
      );
      await _cameraController!.initialize();
      _minZoom = await _cameraController!.getMinZoomLevel();
      _maxZoom = await _cameraController!.getMaxZoomLevel();
      _currentZoom = _minZoom;
      if (mounted) setState(() => _isInitialized = true);
    } catch (e) {
      setState(() => _errorMessage = 'Error al inicializar la cámara: $e');
    }
  }

  Future<void> _takePhoto() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized) return;
    final captureState = ref.read(guidedCaptureProvider);
    if (captureState.isCapturing) return;

    ref.read(guidedCaptureProvider.notifier).setCapturing(true);

    try {
      final XFile photo = await _cameraController!.takePicture();
      final directory = await getApplicationDocumentsDirectory();
      final fileName =
          'car_${captureState.currentPosition.id}_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final savedPath = '${directory.path}/$fileName';
      await File(photo.path).copy(savedPath);

      if (mounted) {
        ref.read(guidedCaptureProvider.notifier).setCapturing(false);
        setState(() => _previewPath = savedPath);
      }
    } catch (e) {
      ref.read(guidedCaptureProvider.notifier).setCapturing(false);
      ref.read(guidedCaptureProvider.notifier).setError('Error al tomar la foto');
    }
  }

  bool _shouldBlurPlate(PhotoAngle angle) {
    return angle == PhotoAngle.front ||
        angle == PhotoAngle.rear ||
        angle == PhotoAngle.frontLeftCorner ||
        angle == PhotoAngle.frontRightCorner ||
        angle == PhotoAngle.rearLeftCorner ||
        angle == PhotoAngle.rearRightCorner;
  }

  void _onAcceptPreview() {
    if (_previewPath == null) return;
    final captureState = ref.read(guidedCaptureProvider);
    final angle = captureState.currentPosition.angle;
    final positionId = captureState.currentPosition.id;
    final path = _previewPath!;

    if (_shouldBlurPlate(angle)) {
      _plateBlurService.blurPlateInFile(path);
    }

    ref.read(guidedCaptureProvider.notifier).capturePhoto(positionId, path);
    ref.read(vehicleRegistrationProvider.notifier)
        .addExteriorPhotoWithPath(positionId, path);

    setState(() => _previewPath = null);

    if (captureState.isLastPosition) {
      if (captureState.completedCount + 1 >= captureState.totalPositions) {
        _finishCapture();
      }
    } else {
      ref.read(guidedCaptureProvider.notifier).goToNext();
    }
  }

  void _onRetakePreview() {
    if (_previewPath != null) {
      File(_previewPath!).deleteSync();
    }
    setState(() => _previewPath = null);
  }

  void _finishCapture() {
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final captureState = ref.watch(guidedCaptureProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      body: _previewPath != null
          ? _buildPhotoReview(captureState)
          : Stack(
              children: [
                if (_errorMessage != null)
                  _buildErrorState()
                else if (!_hasPermission)
                  _buildPermissionState()
                else if (!_isInitialized)
                  _buildLoadingState()
                else
                  _buildCameraView(captureState),
                if (_isInitialized && _hasPermission) ...[
                  _buildTopBar(captureState),
                  _buildBottomControls(captureState),
                ],
              ],
            ),
    );
  }

  Widget _buildCameraView(GuidedCaptureState captureState) {
    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            onScaleStart: (details) => _baseZoom = _currentZoom,
            onScaleUpdate: (details) {
              final newZoom =
                  (_baseZoom * details.scale).clamp(_minZoom, _maxZoom);
              if (newZoom != _currentZoom) {
                _currentZoom = newZoom;
                _cameraController?.setZoomLevel(_currentZoom);
              }
            },
            child: CameraPreview(_cameraController!),
          ),
        ),
        Positioned.fill(
          child: IgnorePointer(
            child: CameraOverlayWidget(angle: captureState.currentPosition.angle),
          ),
        ),
      ],
    );
  }

  Widget _buildTopBar(GuidedCaptureState captureState) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withValues(alpha: 0.7),
              Colors.transparent,
            ],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => context.pop(),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.5),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.close, color: Colors.white, size: 22),
                  ),
                ),
                AppSpacing.hGapMd,
                Text(
                  captureState.currentPosition.name,
                  style: AppTypography.titleMedium.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                // Progress dots
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(captureState.totalPositions, (i) {
                    final isCompleted = captureState.capturedPhotos
                        .containsKey(AppConstants.photoPositions[i].id);
                    final isCurrent = i == captureState.currentIndex;
                    return Container(
                      width: isCurrent ? 20 : 8,
                      height: 8,
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        color: isCompleted
                            ? AppColors.success
                            : isCurrent
                                ? Colors.white
                                : Colors.white.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    );
                  }),
                ),
                AppSpacing.hGapMd,
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text(
                    '${captureState.currentIndex + 1}/${captureState.totalPositions}',
                    style: AppTypography.labelMedium.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomControls(GuidedCaptureState captureState) {
    final isCompleted = captureState.capturedPhotos
        .containsKey(captureState.currentPosition.id);

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Colors.black.withValues(alpha: 0.7),
              Colors.transparent,
            ],
          ),
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg, AppSpacing.xs, AppSpacing.lg, AppSpacing.sm,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    AppConstants.overlayInstruction(
                      captureState.currentPosition.angle,
                    ),
                    style: AppTypography.bodySmall.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 48,
                      child: captureState.isFirstPosition
                          ? null
                          : IconButton(
                              onPressed: () => ref
                                  .read(guidedCaptureProvider.notifier)
                                  .goToPrevious(),
                              icon: const Icon(Icons.arrow_back_ios,
                                  color: Colors.white, size: 20),
                            ),
                    ),
                    const SizedBox(width: 24),
                    GestureDetector(
                      onTap: captureState.isCapturing ? null : _takePhoto,
                      child: Container(
                        width: 68,
                        height: 68,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 4),
                        ),
                        child: Center(
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 100),
                            width: captureState.isCapturing ? 46 : 56,
                            height: captureState.isCapturing ? 46 : 56,
                            decoration: BoxDecoration(
                              color: captureState.isCapturing
                                  ? AppColors.error
                                  : isCompleted
                                      ? AppColors.success
                                      : Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: isCompleted && !captureState.isCapturing
                                ? const Icon(Icons.refresh,
                                    color: Colors.white, size: 22)
                                : null,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 24),
                    SizedBox(
                      width: 48,
                      child: captureState.allPhotosCompleted
                          ? IconButton(
                              onPressed: _finishCapture,
                              icon: const Icon(Icons.check_circle,
                                  color: AppColors.success, size: 30),
                            )
                          : captureState.isLastPosition
                              ? null
                              : IconButton(
                                  onPressed: () => ref
                                      .read(guidedCaptureProvider.notifier)
                                      .goToNext(),
                                  icon: const Icon(Icons.arrow_forward_ios,
                                      color: Colors.white, size: 20),
                                ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPhotoReview(GuidedCaptureState captureState) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(color: Colors.black),
        Center(
          child: Image.file(
            File(_previewPath!),
            fit: BoxFit.contain,
          ),
        ),
        // Top bar
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.7),
                  Colors.transparent,
                ],
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Row(
                  children: [
                    const Icon(Icons.photo_camera_outlined,
                        color: Colors.white, size: 22),
                    AppSpacing.hGapSm,
                    Text(
                      captureState.currentPosition.name,
                      style: AppTypography.titleMedium.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Text(
                        'Revisa tu foto',
                        style: AppTypography.labelSmall.copyWith(
                          color: Colors.white70,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        // Bottom actions
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.8),
                  Colors.transparent,
                ],
              ),
            ),
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.xl,
                  vertical: AppSpacing.md,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: _onRetakePreview,
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 2),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.refresh,
                                  color: Colors.white, size: 20),
                              const SizedBox(width: 8),
                              Text(
                                'Retomar',
                                style: AppTypography.labelLarge
                                    .copyWith(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: GestureDetector(
                        onTap: _onAcceptPreview,
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: AppColors.success,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.check,
                                  color: Colors.white, size: 20),
                              const SizedBox(width: 8),
                              Text(
                                'Usar foto',
                                style: AppTypography.labelLarge
                                    .copyWith(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: Colors.white),
          SizedBox(height: 16),
          Text('Inicializando cámara...', style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: AppColors.error, size: 64),
            AppSpacing.vGapMd,
            Text(
              _errorMessage ?? 'Ocurrió un error',
              style: const TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            AppSpacing.vGapLg,
            PrimaryButton(text: 'Intentar de Nuevo', onPressed: _initializeCamera),
          ],
        ),
      ),
    );
  }

  Widget _buildPermissionState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.camera_alt_outlined, color: Colors.white54, size: 64),
            AppSpacing.vGapMd,
            const Text(
              'Se requiere permiso de cámara',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
            ),
            AppSpacing.vGapSm,
            const Text(
              'Otorga acceso a la cámara para tomar fotos de tu vehículo',
              style: TextStyle(color: Colors.white70),
              textAlign: TextAlign.center,
            ),
            AppSpacing.vGapLg,
            PrimaryButton(
              text: 'Otorgar Permiso',
              onPressed: () async => await openAppSettings(),
            ),
          ],
        ),
      ),
    );
  }
}
