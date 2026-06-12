import 'dart:io';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/widgets.dart';

class PhotoPreviewDialog extends StatelessWidget {
  final String imagePath;
  final String positionName;
  final VoidCallback onAccept;
  final VoidCallback onRetake;

  const PhotoPreviewDialog({
    super.key,
    required this.imagePath,
    required this.positionName,
    required this.onAccept,
    required this.onRetake,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(AppSpacing.md),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.sm),
                    decoration: BoxDecoration(
                      color: AppColors.success.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                    ),
                    child: const Icon(
                      Icons.check_circle_outline,
                      color: AppColors.success,
                      size: 24,
                    ),
                  ),
                  AppSpacing.hGapMd,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          positionName,
                          style: AppTypography.titleMedium,
                        ),
                        Text(
                          'Review your photo',
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Image preview
            ClipRRect(
              child: AspectRatio(
                aspectRatio: 4 / 3,
                child: Image.file(
                  File(imagePath),
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: AppColors.surfaceVariant,
                      child: const Center(
                        child: Icon(
                          Icons.broken_image_outlined,
                          size: 48,
                          color: AppColors.textTertiary,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            // Actions
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Row(
                children: [
                  Expanded(
                    child: SecondaryButton(
                      text: 'Retake',
                      icon: Icons.refresh,
                      onPressed: () {
                        Navigator.of(context).pop();
                        onRetake();
                      },
                    ),
                  ),
                  AppSpacing.hGapMd,
                  Expanded(
                    child: PrimaryButton(
                      text: 'Use Photo',
                      icon: Icons.check,
                      onPressed: () {
                        Navigator.of(context).pop();
                        onAccept();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Future<void> show({
    required BuildContext context,
    required String imagePath,
    required String positionName,
    required VoidCallback onAccept,
    required VoidCallback onRetake,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => PhotoPreviewDialog(
        imagePath: imagePath,
        positionName: positionName,
        onAccept: onAccept,
        onRetake: onRetake,
      ),
    );
  }
}
