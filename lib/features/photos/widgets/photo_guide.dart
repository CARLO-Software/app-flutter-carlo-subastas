import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';

class PhotoGuide extends StatelessWidget {
  final String title;
  final String description;
  final List<String> tips;
  final IconData icon;

  const PhotoGuide({
    super.key,
    required this.title,
    required this.description,
    required this.tips,
    this.icon = Icons.lightbulb_outline,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.infoLight,
        borderRadius: AppSpacing.borderRadiusMd,
        border: Border.all(color: AppColors.info.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: AppColors.info,
                size: 24,
              ),
              AppSpacing.hGapSm,
              Text(
                title,
                style: AppTypography.titleMedium.copyWith(
                  color: AppColors.info,
                ),
              ),
            ],
          ),
          AppSpacing.vGapSm,
          Text(
            description,
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          if (tips.isNotEmpty) ...[
            AppSpacing.vGapMd,
            ...tips.map((tip) => Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.check_circle_outline,
                        color: AppColors.success,
                        size: 18,
                      ),
                      AppSpacing.hGapSm,
                      Expanded(
                        child: Text(
                          tip,
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ],
      ),
    );
  }
}
