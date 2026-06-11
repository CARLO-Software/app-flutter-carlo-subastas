import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';

class SelectableChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final IconData? icon;

  const SelectableChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.chipSelected : AppColors.chipUnselected,
          borderRadius: AppSpacing.borderRadiusSm,
          border: Border.all(
            color: isSelected ? AppColors.chipSelected : AppColors.chipBorder,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 18,
                color: isSelected ? AppColors.textOnPrimary : AppColors.textPrimary,
              ),
              AppSpacing.hGapSm,
            ],
            Text(
              label,
              style: AppTypography.labelLarge.copyWith(
                color: isSelected ? AppColors.textOnPrimary : AppColors.textPrimary,
              ),
            ),
            if (isSelected) ...[
              AppSpacing.hGapSm,
              Icon(
                Icons.check,
                size: 18,
                color: AppColors.textOnPrimary,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
