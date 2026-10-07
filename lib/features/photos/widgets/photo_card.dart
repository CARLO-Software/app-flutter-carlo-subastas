import 'dart:io';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/app_constants.dart';
import '../../../models/photo_position.dart';

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
    final c = context.colors;
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
                : c.border;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(minHeight: 160),
        decoration: BoxDecoration(
          color: hasPhoto ? c.surfaceVariant : c.surface,
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
                                color: c.surfaceVariant,
                                child: Center(
                                  child: Icon(
                                    Icons.broken_image,
                                    size: 48,
                                    color: c.textTertiary,
                                  ),
                                ),
                              );
                            },
                          )
                        : Container(
                            color: c.surfaceVariant,
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
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: AppSpacing.xs,
                      ),
                      decoration: BoxDecoration(
                        color: isInvalid
                            ? AppColors.error.withValues(alpha: 0.9)
                            : AppColors.primary.withValues(alpha: 0.85),
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
                              style: AppTypography.labelSmall.copyWith(
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
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
            : Stack(
                children: [
                  if (angle != null)
                    Positioned.fill(
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.sm),
                        child: Image.asset(
                          AppConstants.templateForAngle(angle!),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  if (angle == null)
                    Center(
                      child: Icon(
                        Icons.camera_alt_outlined,
                        size: 48,
                        color: c.textTertiary,
                      ),
                    ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: AppSpacing.xs,
                      ),
                      decoration: BoxDecoration(
                        color: c.surfaceVariant.withValues(alpha: 0.9),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(AppSpacing.radiusMd),
                          bottomRight: Radius.circular(AppSpacing.radiusMd),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            title,
                            style: AppTypography.labelMedium.copyWith(
                              color: c.textPrimary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          if (isRequired)
                            Text(
                              'Requerido',
                              style: AppTypography.caption.copyWith(
                                color: c.textTertiary,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
