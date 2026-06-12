import 'dart:io';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../models/photo_position.dart';
import 'car_silhouette_painter.dart';

class PhotoCard extends StatelessWidget {
  final String title;
  final String? imagePath;
  final VoidCallback onTap;
  final bool isRequired;
  final PhotoAngle? angle;

  const PhotoCard({
    super.key,
    required this.title,
    this.imagePath,
    required this.onTap,
    this.isRequired = true,
    this.angle,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasPhoto = imagePath != null && imagePath!.isNotEmpty;
    final bool isRealPhoto = hasPhoto && imagePath!.startsWith('/');

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 160,
        decoration: BoxDecoration(
          color: hasPhoto ? AppColors.surfaceVariant : AppColors.surface,
          borderRadius: AppSpacing.borderRadiusMd,
          border: Border.all(
            color: hasPhoto ? AppColors.success : AppColors.border,
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
                                    Icons.check_circle,
                                    size: 48,
                                    color: AppColors.success,
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
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(AppSpacing.sm),
                      decoration: BoxDecoration(
                        color: AppColors.success.withValues(alpha: 0.9),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(AppSpacing.radiusMd),
                          bottomRight: Radius.circular(AppSpacing.radiusMd),
                        ),
                      ),
                      child: Text(
                        title,
                        style: AppTypography.labelMedium.copyWith(
                          color: AppColors.textOnPrimary,
                        ),
                        textAlign: TextAlign.center,
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
