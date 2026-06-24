import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/providers/providers.dart';
import '../../../shared/widgets/widgets.dart';
import '../providers/guided_capture_provider.dart';
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeCamera();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _cameraController?.dispose();
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
        _errorMessage = 'Camera permission is required to take photos';
      });
      return;
    }

    setState(() {
      _hasPermission = true;
    });

    try {
      _cameras = await availableCameras();
      if (_cameras == null || _cameras!.isEmpty) {
        setState(() {
          _errorMessage = 'No cameras available on this device';
        });
        return;
      }

      final backCamera = _cameras!.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.back,
        orElse: () => _cameras!.first,
      );

      _cameraController = CameraController(
        backCamera,
        ResolutionPreset.high,
        enableAudio: false,
      );

      await _cameraController!.initialize();

      if (mounted) {
        setState(() {
          _isInitialized = true;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to initialize camera: $e';
      });
    }
  }

  Future<void> _takePhoto() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return;
    }

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

        await PhotoPreviewDialog.show(
          context: context,
          imagePath: savedPath,
          positionName: captureState.currentPosition.name,
          onAccept: () {
            _acceptPhoto(savedPath);
          },
          onRetake: () {
            File(savedPath).deleteSync();
          },
        );
      }
    } catch (e) {
      ref.read(guidedCaptureProvider.notifier).setCapturing(false);
      ref.read(guidedCaptureProvider.notifier).setError('Failed to take photo');
    }
  }

  void _acceptPhoto(String path) {
    final captureState = ref.read(guidedCaptureProvider);
    final positionId = captureState.currentPosition.id;

    ref.read(guidedCaptureProvider.notifier).capturePhoto(positionId, path);
    ref
        .read(vehicleRegistrationProvider.notifier)
        .addExteriorPhotoWithPath(positionId, path);

    if (!captureState.isLastPosition) {
      ref.read(guidedCaptureProvider.notifier).goToNext();
    }
  }

  void _finishCapture() {
    final captureState = ref.read(guidedCaptureProvider);
    if (captureState.completedCount >= 4) {
      ref.read(vehicleRegistrationProvider.notifier).confirmPhotos();
    }
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final captureState = ref.watch(guidedCaptureProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          if (_errorMessage != null)
            _buildErrorState()
          else if (!_hasPermission)
            _buildPermissionState()
          else if (!_isInitialized)
            _buildLoadingState()
          else
            _buildCameraPreview(captureState),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => context.pop(),
                    icon: const Icon(Icons.close, color: Colors.white),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.black.withValues(alpha: 0.5),
                    ),
                  ),
                  AppSpacing.hGapMd,
                  Expanded(
                    child: CaptureProgressIndicator(
                      totalSteps: captureState.totalPositions,
                      currentStep: captureState.currentIndex,
                      completedSteps: captureState.completedIndices,
                    ),
                  ),
                  AppSpacing.hGapMd,
                  Text(
                    '${captureState.currentIndex + 1}/${captureState.totalPositions}',
                    style: AppTypography.labelMedium.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),

          if (_isInitialized && _hasPermission)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _buildBottomControls(captureState),
            ),
        ],
      ),
    );
  }

  Widget _buildCameraPreview(GuidedCaptureState captureState) {
    return Stack(
      children: [
        Positioned.fill(
          child: CameraPreview(_cameraController!),
        ),
        Positioned.fill(
          child: CameraOverlayWidget(
            angle: captureState.currentPosition.angle,
            positionName: captureState.currentPosition.name,
            instructions: captureState.currentPosition.instructions,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomControls(GuidedCaptureState captureState) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 70,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: AppConstants.photoPositions.length,
                itemBuilder: (context, index) {
                  final position = AppConstants.photoPositions[index];
                  final isSelected = index == captureState.currentIndex;
                  final isCompleted =
                      captureState.capturedPhotos.containsKey(position.id);

                  return GestureDetector(
                    onTap: () {
                      ref
                          .read(guidedCaptureProvider.notifier)
                          .goToPosition(index);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 60,
                      margin:
                          const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primary
                            : isCompleted
                                ? AppColors.success.withValues(alpha: 0.3)
                                : Colors.white.withValues(alpha: 0.1),
                        borderRadius:
                            BorderRadius.circular(AppSpacing.radiusSm),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primary
                              : isCompleted
                                  ? AppColors.success
                                  : Colors.white.withValues(alpha: 0.3),
                          width: 2,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (isCompleted)
                            const Icon(
                              Icons.check_circle,
                              color: AppColors.success,
                              size: 20,
                            )
                          else
                            CarSilhouetteWidget(
                              angle: position.angle,
                              color: isSelected
                                  ? Colors.white
                                  : Colors.white.withValues(alpha: 0.7),
                              size: 32,
                              strokeWidth: 1.5,
                            ),
                          AppSpacing.vGapXxs,
                          Text(
                            position.name.split(' ').first,
                            style: AppTypography.caption.copyWith(
                              color: Colors.white,
                              fontSize: 9,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            AppSpacing.vGapLg,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: captureState.isFirstPosition
                      ? null
                      : () =>
                          ref.read(guidedCaptureProvider.notifier).goToPrevious(),
                  icon: const Icon(Icons.arrow_back_ios),
                  color: Colors.white,
                  disabledColor: Colors.white.withValues(alpha: 0.3),
                ),
                GestureDetector(
                  onTap: captureState.isCapturing ? null : _takePhoto,
                  child: Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4),
                    ),
                    child: Center(
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 100),
                        width: captureState.isCapturing ? 50 : 60,
                        height: captureState.isCapturing ? 50 : 60,
                        decoration: BoxDecoration(
                          color: captureState.isCapturing
                              ? AppColors.error
                              : Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                ),
                if (captureState.isLastPosition ||
                    captureState.completedCount >= 4)
                  TextButton(
                    onPressed: _finishCapture,
                    child: Text(
                      'Done',
                      style: AppTypography.labelLarge.copyWith(
                        color: AppColors.success,
                      ),
                    ),
                  )
                else
                  IconButton(
                    onPressed: captureState.isLastPosition
                        ? null
                        : () =>
                            ref.read(guidedCaptureProvider.notifier).goToNext(),
                    icon: const Icon(Icons.arrow_forward_ios),
                    color: Colors.white,
                    disabledColor: Colors.white.withValues(alpha: 0.3),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: Colors.white),
          SizedBox(height: 16),
          Text(
            'Initializing camera...',
            style: TextStyle(color: Colors.white),
          ),
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
            const Icon(
              Icons.error_outline,
              color: AppColors.error,
              size: 64,
            ),
            AppSpacing.vGapMd,
            Text(
              _errorMessage ?? 'An error occurred',
              style: const TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            AppSpacing.vGapLg,
            PrimaryButton(
              text: 'Try Again',
              onPressed: _initializeCamera,
            ),
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
            const Icon(
              Icons.camera_alt_outlined,
              color: Colors.white54,
              size: 64,
            ),
            AppSpacing.vGapMd,
            const Text(
              'Camera permission required',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            AppSpacing.vGapSm,
            const Text(
              'Please grant camera access to take photos of your vehicle',
              style: TextStyle(color: Colors.white70),
              textAlign: TextAlign.center,
            ),
            AppSpacing.vGapLg,
            PrimaryButton(
              text: 'Grant Permission',
              onPressed: () async {
                await openAppSettings();
              },
            ),
          ],
        ),
      ),
    );
  }
}
