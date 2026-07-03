import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';

class ProgressCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData icon;
  final bool isCompleted;
  final VoidCallback? onTap;

  const ProgressCard({
    super.key,
    required this.title,
    this.subtitle,
    required this.icon,
    this.isCompleted = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: c.card,
          borderRadius: AppSpacing.borderRadiusMd,
          border: Border.all(
            color: isCompleted ? AppColors.success : c.cardBorder,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: isCompleted
                    ? c.successLight
                    : c.surfaceVariant,
                borderRadius: AppSpacing.borderRadiusSm,
              ),
              child: Icon(
                icon,
                color: isCompleted ? AppColors.success : AppColors.primary,
                size: 24,
              ),
            ),
            AppSpacing.hGapMd,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTypography.titleMedium,
                  ),
                  if (subtitle != null) ...[
                    AppSpacing.vGapXs,
                    Text(
                      subtitle!,
                      style: AppTypography.bodySmall,
                    ),
                  ],
                ],
              ),
            ),
            if (isCompleted)
              Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.success,
                ),
                child: Icon(
                  Icons.check,
                  size: 16,
                  color: c.textOnPrimary,
                ),
              )
            else
              Icon(
                Icons.chevron_right,
                color: c.textTertiary,
              ),
          ],
        ),
      ),
    );
  }
}
