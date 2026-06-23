import 'dart:io';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../models/photo_position.dart';
import 'car_silhouette_painter.dart';

enum PhotoValidationStatus { none, validating, valid, invalid }

class PhotoCard extends StatelessWidget {
  final String title;
  final String? imagePath;
  final VoidCallback onTap;
  final bool isRequired;
  final PhotoAngle? angle;
  final PhotoValidationStatus validationStatus;
  final String? validationFeedback;
  final VoidCallback? onRetake;

  const PhotoCard({
    super.key,
    required this.title,
    this.imagePath,
    required this.onTap,
    this.isRequired = true,
    this.angle,
    this.validationStatus = PhotoValidationStatus.none,
    this.validationFeedback,
    this.onRetake,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasPhoto = imagePath != null && imagePath!.isNotEmpty;
    final bool isRealPhoto = hasPhoto && imagePath!.startsWith('/');
    final bool isInvalid = validationStatus == PhotoValidationStatus.invalid;
    final bool isValidating = validationStatus == PhotoValidationStatus.validating;
    final bool isValid = validationStatus == PhotoValidationStatus.valid;

    final borderColor = isInvalid
        ? AppColors.error
        : isValid
            ? AppColors.success
            : hasPhoto
                ? AppColors.success
                : AppColors.border;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 160,
        decoration: BoxDecoration(
          color: hasPhoto ? AppColors.surfaceVariant : AppColors.surface,
          borderRadius: AppSpacing.borderRadiusMd,
          border: Border.all(
            color: borderColor,
            width: hasPhoto ? 2 : 1,
          ),
        ),
        child: hasPhoto
            ? Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: AppSpacing.borderRadiusMd,
                    child: isRealPhoto
                        ? Image.file(
                            File(imagePath!),
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: AppColors.surfaceVariant,
                                child: const Center(
                                  child: Icon(
                                    Icons.broken_image,
                                    size: 48,
                                    color: AppColors.textTertiary,
                                  ),
                                ),
                              );
                            },
                          )
                        : Container(
                            color: AppColors.surfaceVariant,
                            child: const Center(
                              child: Icon(
                                Icons.check_circle,
                                size: 48,
                                color: AppColors.success,
                              ),
                            ),
                          ),
                  ),
                  // Validating overlay
                  if (isValidating)
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.5),
                        borderRadius: AppSpacing.borderRadiusMd,
                      ),
                      child: const Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 28,
                              height: 28,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 3,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Validando...',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  // Bottom banner
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(AppSpacing.sm),
                      decoration: BoxDecoration(
                        color: isInvalid
                            ? AppColors.error.withValues(alpha: 0.9)
                            : AppColors.success.withValues(alpha: 0.9),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(AppSpacing.radiusMd),
                          bottomRight: Radius.circular(AppSpacing.radiusMd),
                        ),
                      ),
                      child: Row(
                        children: [
                          if (isInvalid)
                            const Padding(
                              padding: EdgeInsets.only(right: 4),
                              child: Icon(Icons.warning, color: Colors.white, size: 14),
                            ),
                          Expanded(
                            child: Text(
                              isInvalid
                                  ? (validationFeedback ?? title)
                                  : title,
                              style: AppTypography.labelMedium.copyWith(
                                color: AppColors.textOnPrimary,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Retake button (X) for invalid photos
                  if (isInvalid && onRetake != null)
                    Positioned(
                      top: 4,
                      right: 4,
                      child: GestureDetector(
                        onTap: onRetake,
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: const BoxDecoration(
                            color: AppColors.error,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: AppColors.surfaceVariant,
                      shape: BoxShape.circle,
                    ),
                    child: angle != null
                        ? Center(
                            child: CarSilhouetteWidget(
                              angle: angle!,
                              color: AppColors.textSecondary,
                              size: 48,
                              strokeWidth: 1.5,
                            ),
                          )
                        : const Icon(
                            Icons.camera_alt_outlined,
                            size: 32,
                            color: AppColors.textSecondary,
                          ),
                  ),
                  AppSpacing.vGapSm,
                  Text(
                    title,
                    style: AppTypography.labelMedium.copyWith(
                      color: AppColors.textPrimary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  if (isRequired) ...[
                    AppSpacing.vGapXs,
                    Text(
                      'Required',
                      style: AppTypography.caption.copyWith(
                        color: AppColors.textTertiary,
                      ),
                    ),
                  ],
                ],
              ),
      ),
    );
  }
}
