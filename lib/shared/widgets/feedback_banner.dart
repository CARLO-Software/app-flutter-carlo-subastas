import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';

enum FeedbackType { success, warning, info, error }

class FeedbackBanner extends StatelessWidget {
  final FeedbackType type;
  final String text;
  final IconData? icon;

  const FeedbackBanner({
    super.key,
    required this.type,
    required this.text,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final (bgColor, fgColor, defaultIcon) = switch (type) {
      FeedbackType.success => (c.successLight, AppColors.success, Icons.check_circle),
      FeedbackType.warning => (c.warningLight, AppColors.warning, Icons.warning_amber),
      FeedbackType.info => (c.infoLight, AppColors.info, Icons.info_outline),
      FeedbackType.error => (c.errorLight, AppColors.error, Icons.error_outline),
    };

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: AppSpacing.borderRadiusMd,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon ?? defaultIcon, color: fgColor, size: 20),
          AppSpacing.hGapSm,
          Expanded(
            child: Text(
              text,
              style: AppTypography.bodySmall.copyWith(
                color: c.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
