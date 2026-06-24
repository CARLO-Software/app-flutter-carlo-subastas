import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/providers/providers.dart';
import '../../../shared/widgets/widgets.dart';
import '../providers/guided_capture_provider.dart';
import '../services/angle_validator_service.dart';
import '../widgets/widgets.dart';

class ExteriorPhotosScreen extends ConsumerStatefulWidget {
  const ExteriorPhotosScreen({super.key});

  @override
  ConsumerState<ExteriorPhotosScreen> createState() => _ExteriorPhotosScreenState();
}

class _ExteriorPhotosScreenState extends ConsumerState<ExteriorPhotosScreen> {
  AngleValidatorService? _validator;
  bool _isValidating = false;

  final Map<String, PhotoValidationStatus> _validationStatus = {};
  final Map<String, String> _validationFeedback = {};

  AngleValidatorService get validator {
    _validator ??= AngleValidatorService(apiKey: AppConstants.geminiApiKey);
    return _validator!;
  }

  Future<void> _validateAllPhotos() async {
    // ponytail: AI validation disabled until API quota issue resolved
    // TODO: re-enable when Gemini API key has proper quota
    const useAiValidation = true;

    if (!useAiValidation) {
      ref.read(vehicleRegistrationProvider.notifier).confirmPhotos();
      context.go(AppRoutes.dashboard);
      return;
    }

    final photos = ref.read(vehicleRegistrationProvider).exteriorPhotosMap;
    if (photos.isEmpty) return;

    setState(() => _isValidating = true);

    final photosToValidate = AppConstants.photoPositions
        .where((p) => photos.containsKey(p.id))
        .toList();

    for (var i = 0; i < photosToValidate.length; i++) {
      final position = photosToValidate[i];
      final path = photos[position.id]!;

      setState(() {
        _validationStatus[position.id] = PhotoValidationStatus.validating;
      });

      try {
        final bytes = await File(path).readAsBytes();
        final result = await validator.validateAngle(
          imageBytes: bytes,
          expectedAngle: position.angle,
        );

        if (!mounted) return;

        setState(() {
          if (result.isValid) {
            _validationStatus[position.id] = PhotoValidationStatus.valid;
            _validationFeedback.remove(position.id);
          } else {
            _validationStatus[position.id] = PhotoValidationStatus.invalid;
            _validationFeedback[position.id] = result.feedback ?? 'Ángulo incorrecto';
          }
        });
      } catch (e) {
        if (!mounted) return;
        setState(() {
          _validationStatus[position.id] = PhotoValidationStatus.valid;
        });
      }

      if (i < photosToValidate.length - 1) {
        await Future.delayed(const Duration(seconds: 2));
      }
    }

    if (!mounted) return;
    setState(() => _isValidating = false);

    final hasInvalid = _validationStatus.values.contains(PhotoValidationStatus.invalid);
    if (!hasInvalid) {
      ref.read(vehicleRegistrationProvider.notifier).confirmPhotos();
      context.go(AppRoutes.dashboard);
    }
  }

  void _retakePhoto(String positionId) {
    ref.read(vehicleRegistrationProvider.notifier).removeExteriorPhotoByPosition(positionId);
    setState(() {
      _validationStatus.remove(positionId);
      _validationFeedback.remove(positionId);
    });

    // Navigate to capture at this position
    final index = AppConstants.photoPositions.indexWhere((p) => p.id == positionId);
    if (index >= 0) {
      final registrationState = ref.read(vehicleRegistrationProvider);
      ref.read(guidedCaptureProvider.notifier).initializeWithExistingPhotos(
        registrationState.exteriorPhotosMap,
      );
      ref.read(guidedCaptureProvider.notifier).goToPosition(index);
      context.push(AppRoutes.guidedCapture);
    }
  }

  void _startGuidedCapture() {
    final registrationState = ref.read(vehicleRegistrationProvider);
    ref.read(guidedCaptureProvider.notifier).initializeWithExistingPhotos(
      registrationState.exteriorPhotosMap,
    );
    context.push(AppRoutes.guidedCapture);
  }

  void _onPhotoCardTap(String positionId) {
    final registrationState = ref.read(vehicleRegistrationProvider);
    final hasPhoto = registrationState.exteriorPhotosMap.containsKey(positionId);

    if (hasPhoto) {
      _showRetakeDialog(positionId);
    } else {
      final index = AppConstants.photoPositions.indexWhere((p) => p.id == positionId);
      if (index >= 0) {
        ref.read(guidedCaptureProvider.notifier).goToPosition(index);
        context.push(AppRoutes.guidedCapture);
      }
    }
  }

  void _showRetakeDialog(String positionId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Photo Options'),
        content: const Text('Would you like to retake this photo?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _retakePhoto(positionId);
            },
            child: const Text('Retake'),
          ),
        ],
      ),
    );
  }

  int get _photosTakenCount {
    final state = ref.watch(vehicleRegistrationProvider);
    return state.exteriorPhotosMap.length;
  }

  @override
  Widget build(BuildContext context) {
    final registrationState = ref.watch(vehicleRegistrationProvider);
    final totalPhotos = AppConstants.photoPositions.length;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Exterior Photos'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            color: AppColors.surfaceVariant,
            child: Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: AppSpacing.borderRadiusFull,
                    child: LinearProgressIndicator(
                      value: _photosTakenCount / totalPhotos,
                      backgroundColor: AppColors.border,
                      valueColor: const AlwaysStoppedAnimation<Color>(AppColors.success),
                      minHeight: 8,
                    ),
                  ),
                ),
                AppSpacing.hGapMd,
                Text(
                  '$_photosTakenCount/$totalPhotos',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: AppSpacing.screenPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: _startGuidedCapture,
                    child: Container(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppColors.primary, Color(0xFF8B5CF6)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                          AppSpacing.hGapMd,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Start Guided Capture',
                                  style: AppTypography.titleMedium.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                AppSpacing.vGapXxs,
                                Text(
                                  'We\'ll guide you through each angle',
                                  style: AppTypography.bodySmall.copyWith(
                                    color: Colors.white.withValues(alpha: 0.9),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ),
                  AppSpacing.vGapLg,
                  const SectionHeader(
                    title: 'Photo Overview',
                    subtitle: 'Tap any photo to capture or retake',
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1,
                      crossAxisSpacing: AppSpacing.md,
                      mainAxisSpacing: AppSpacing.md,
                    ),
                    itemCount: AppConstants.photoPositions.length,
                    itemBuilder: (context, index) {
                      final position = AppConstants.photoPositions[index];
                      final photoPath = registrationState.exteriorPhotosMap[position.id];
                      return PhotoCard(
                        title: position.name,
                        imagePath: photoPath,
                        angle: position.angle,
                        onTap: () => _onPhotoCardTap(position.id),
                        validationStatus: _validationStatus[position.id] ?? PhotoValidationStatus.none,
                        validationFeedback: _validationFeedback[position.id],
                        onRetake: () => _retakePhoto(position.id),
                      );
                    },
                  ),
                  AppSpacing.vGapLg,
                ],
              ),
            ),
          ),
          Container(
            padding: AppSpacing.screenPadding,
            decoration: BoxDecoration(
              color: AppColors.surface,
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadow,
                  blurRadius: 8,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: PrimaryButton(
              text: _isValidating ? 'Validando fotos...' : 'Continuar',
              isEnabled: _photosTakenCount >= 4 && !_isValidating,
              onPressed: _photosTakenCount >= 4 && !_isValidating
                  ? _validateAllPhotos
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
