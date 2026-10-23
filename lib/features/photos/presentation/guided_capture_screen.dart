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
import '../services/photo_validator_service.dart';
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
  PhotoValidatorService? _photoValidator;
  bool _isValidating = false;
  PhotoValidationFeedback? _validationResult;

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
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
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
        _validatePhoto(savedPath, captureState.currentPosition.name);
      }
    } catch (e) {
      ref.read(guidedCaptureProvider.notifier).setCapturing(false);
      ref.read(guidedCaptureProvider.notifier).setError('Error al tomar la foto');
    }
  }

  Future<void> _validatePhoto(String path, String subject) async {
    // ponytail: AI validation disabled temporarily, remove early return to re-enable
    return;
    _photoValidator ??= PhotoValidatorService(apiKey: AppConstants.geminiApiKey);
    setState(() { _isValidating = true; _validationResult = null; });

    final bytes = await File(path).readAsBytes();
    final result = await _photoValidator!.validate(
      imageBytes: bytes,
      expectedSubject: subject,
    );
    if (mounted) setState(() { _isValidating = false; _validationResult = result; });
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

    setState(() { _previewPath = null; _validationResult = null; _isValidating = false; });

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
    setState(() { _previewPath = null; _validationResult = null; _isValidating = false; });
  }

  void _finishCapture() {
    context.pop();
  }

  static const double _panelWidth = 90.0;
  static const Color _panelColor = Color(0xFF2A2A2A);

  @override
  Widget build(BuildContext context) {
    final captureState = ref.watch(guidedCaptureProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            return const RotateDeviceOverlay();
          }
          return _previewPath != null
              ? _buildPhotoReview(captureState)
              : _buildCameraCapture(captureState);
        },
      ),
    );
  }

  Widget _buildCameraCapture(GuidedCaptureState captureState) {
    return Stack(
      children: [
        if (_errorMessage != null)
          _buildErrorState()
        else if (!_hasPermission)
          _buildPermissionState()
        else if (!_isInitialized)
          _buildLoadingState()
        else ...[
          // Camera preview — full screen
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
          // Overlay between panels
          Positioned(
            top: 0, bottom: 0, left: _panelWidth, right: _panelWidth,
            child: IgnorePointer(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Expanded(
                    child: CameraOverlayWidget(angle: captureState.currentPosition.angle),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: AppSpacing.md),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      captureState.currentPosition.name,
                      style: AppTypography.labelMedium.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        // Left panel — Salir
        Positioned(
          top: 0, bottom: 0, left: 0,
          child: Container(
            width: _panelWidth,
            color: _panelColor,
            child: Column(
              children: [
                const SizedBox(height: AppSpacing.lg),
                GestureDetector(
                  onTap: () => context.pop(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                    child: Text('Salir', style: AppTypography.labelMedium.copyWith(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Right panel — Ejemplo + botón + contador
        Positioned(
          top: 0, bottom: 0, right: 0,
          child: Container(
            width: _panelWidth,
            color: _panelColor,
            child: Column(
              children: [
                const SizedBox(height: AppSpacing.lg),
                GestureDetector(
                  onTap: () => _showExamplePanel(
                    AppConstants.referenceForAngle(captureState.currentPosition.angle),
                    captureState.currentPosition.name,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                    child: Text('Ejemplo', style: AppTypography.labelMedium.copyWith(color: Colors.white)),
                  ),
                ),
                const Spacer(),
                if (_isInitialized && _hasPermission) ...[
                  GestureDetector(
                    onTap: captureState.isCapturing ? null : _takePhoto,
                    child: Container(
                      width: 68, height: 68,
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
                            color: captureState.isCapturing ? AppColors.error : Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    '${captureState.currentIndex + 1} de ${captureState.totalPositions}',
                    style: AppTypography.labelSmall.copyWith(color: Colors.white70),
                  ),
                ],
                const Spacer(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showExamplePanel(String asset, String title) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Cerrar ejemplo',
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 250),
      pageBuilder: (ctx, anim, secAnim) => const SizedBox.shrink(),
      transitionBuilder: (ctx, anim, secAnim, child) {
        final slideAnim = Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).animate(CurvedAnimation(parent: anim, curve: Curves.easeOutCubic));
        return SlideTransition(
          position: slideAnim,
          child: Align(
            alignment: Alignment.centerRight,
            child: Material(
              color: const Color(0xFF1A1A1A),
              child: SafeArea(
                child: SizedBox(
                  width: MediaQuery.of(ctx).size.width * 0.65,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Ejemplo',
                                style: AppTypography.titleMedium.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => Navigator.of(ctx).pop(),
                              child: const Icon(Icons.close, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                          child: ClipRRect(
                            borderRadius: AppSpacing.borderRadiusMd,
                            child: Image.asset(asset, fit: BoxFit.contain),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        child: Text(
                          'Foto de referencia',
                          style: AppTypography.bodySmall.copyWith(color: Colors.white70),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPhotoReview(GuidedCaptureState captureState) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(color: Colors.black),
        Center(
          child: InteractiveViewer(
            minScale: 1.0,
            maxScale: 5.0,
            child: Image.file(
              File(_previewPath!),
              fit: BoxFit.contain,
            ),
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
        // AI feedback banner
        if (_isValidating || (_validationResult != null && !_validationResult!.isValid))
          Positioned(
            bottom: 120, left: 0, right: 0,
            child: _isValidating
                ? const AiFeedbackBanner(message: '', isLoading: true)
                : AiFeedbackBanner(
                    message: _validationResult!.shortMessage ?? 'Foto no válida',
                    detail: _validationResult!.detail,
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
