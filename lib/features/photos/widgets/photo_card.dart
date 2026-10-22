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
  /// true → badge [AI] rojo (la IA detectó un problema)
  /// false → badge [Error] ámbar (fallo técnico: red, API, etc.)
  final bool isAiFeedback;
  final VoidCallback? onRetake;
  final VoidCallback? onAccept;

  const PhotoCard({
    super.key,
    required this.title,
    this.imagePath,
    required this.onTap,
    this.isRequired = true,
    this.angle,
    this.validationStatus = PhotoValidationStatus.none,
    this.validationFeedback,
    this.isAiFeedback = true,
    this.onRetake,
    this.onAccept,
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
        ? (isAiFeedback ? AppColors.error : Colors.orange)
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
                            cacheWidth: 300,
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
                  // Banner inferior: [AI] rojo para feedback de IA, [Error] ámbar para errores técnicos, título normal si es válido
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: AppSpacing.xs + 2,
                      ),
                      decoration: BoxDecoration(
                        color: isInvalid
                            ? (isAiFeedback
                                ? AppColors.error.withValues(alpha: 0.9)
                                : Colors.orange.withValues(alpha: 0.9))
                            : AppColors.primary.withValues(alpha: 0.85),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(AppSpacing.radiusMd),
                          bottomRight: Radius.circular(AppSpacing.radiusMd),
                        ),
                      ),
                      child: Row(
                        children: [
                          if (isInvalid) ...[
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.25),
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: Text(
                                isAiFeedback ? 'AI' : 'Error',
                                style: AppTypography.labelSmall.copyWith(
                                  color: Colors.white, fontWeight: FontWeight.w800, fontSize: 9,
                                ),
                              ),
                            ),
                            const SizedBox(width: 4),
                          ],
                          Expanded(
                            child: Text(
                              isInvalid
                                  ? (validationFeedback ?? title)
                                  : title,
                              style: AppTypography.labelSmall.copyWith(color: Colors.white),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (isInvalid) ...[
                    // "Está bien" button — override AI verdict
                    if (onAccept != null)
                      Positioned(
                        top: 4,
                        left: 4,
                        child: GestureDetector(
                          onTap: onAccept,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                            decoration: BoxDecoration(
                              color: AppColors.success,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.check, color: Colors.white, size: 14),
                                const SizedBox(width: 3),
                                Text(
                                  'Está bien',
                                  style: AppTypography.labelSmall.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    // Retake button (X)
                    if (onRetake != null)
                      Positioned(
                        top: 4,
                        right: 4,
                        child: GestureDetector(
                          onTap: onRetake,
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: isAiFeedback ? AppColors.error : Colors.orange,
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
