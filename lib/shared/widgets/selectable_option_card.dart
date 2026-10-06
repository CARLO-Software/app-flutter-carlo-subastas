import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';

class SelectableOptionCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool isSelected;
  final VoidCallback onTap;
  final IconData? icon;

  const SelectableOptionCard({
    super.key,
    required this.title,
    this.subtitle,
    required this.isSelected,
    required this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
        onTap();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary.withValues(alpha: 0.1) : c.surface,
          borderRadius: AppSpacing.borderRadiusMd,
          border: Border.all(
            color: isSelected ? AppColors.primary : c.border,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            if (icon != null) ...[
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primary.withValues(alpha: 0.2)
                      : c.surfaceVariant,
                  borderRadius: AppSpacing.borderRadiusSm,
                ),
                child: Icon(
                  icon,
                  color: isSelected ? AppColors.primary : c.textSecondary,
                  size: 24,
                ),
              ),
              AppSpacing.hGapMd,
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTypography.titleMedium.copyWith(
                      color: isSelected ? AppColors.primary : c.textPrimary,
                    ),
                  ),
                  if (subtitle != null) ...[
                    AppSpacing.vGapXs,
                    Text(
                      subtitle!,
                      style: AppTypography.bodySmall.copyWith(
                        color: c.textSecondary,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? AppColors.primary : Colors.transparent,
                border: Border.all(
                  color: isSelected ? AppColors.primary : c.border,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Icon(
                      Icons.check,
                      size: 16,
                      color: c.textOnPrimary,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
