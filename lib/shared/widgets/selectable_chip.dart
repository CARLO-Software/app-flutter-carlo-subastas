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
    final c = context.colors;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: isSelected ? c.chipSelected : c.chipUnselected,
          borderRadius: AppSpacing.borderRadiusSm,
          border: Border.all(
            color: isSelected ? c.chipSelected : c.chipBorder,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 18,
                color: isSelected ? c.textOnPrimary : c.textPrimary,
              ),
              AppSpacing.hGapSm,
            ],
            Text(
              label,
              style: AppTypography.labelLarge.copyWith(
                color: isSelected ? c.textOnPrimary : c.textPrimary,
              ),
            ),
            if (isSelected) ...[
              AppSpacing.hGapSm,
              Icon(
                Icons.check,
                size: 18,
                color: c.textOnPrimary,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
