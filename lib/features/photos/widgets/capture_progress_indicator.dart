import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';

class CaptureProgressIndicator extends StatelessWidget {
  final int totalSteps;
  final int currentStep;
  final Set<int> completedSteps;

  const CaptureProgressIndicator({
    super.key,
    required this.totalSteps,
    required this.currentStep,
    required this.completedSteps,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalSteps, (index) {
        final isCompleted = completedSteps.contains(index);
        final isCurrent = index == currentStep;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: isCurrent ? 24 : 12,
            height: 12,
            decoration: BoxDecoration(
              color: isCompleted
                  ? AppColors.success
                  : isCurrent
                      ? AppColors.primary
                      : AppColors.border,
              borderRadius: BorderRadius.circular(6),
            ),
            child: isCompleted
                ? const Icon(
                    Icons.check,
                    size: 10,
                    color: Colors.white,
                  )
                : null,
          ),
        );
      }),
    );
  }
}

class CaptureProgressBar extends StatelessWidget {
  final int totalSteps;
  final int completedCount;
  final String? label;

  const CaptureProgressBar({
    super.key,
    required this.totalSteps,
    required this.completedCount,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    final progress = totalSteps > 0 ? completedCount / totalSteps : 0.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label!,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary,
                ),
              ),
              Text(
                '$completedCount/$totalSteps',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          AppSpacing.vGapSm,
        ],
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: AppColors.border,
            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.success),
            minHeight: 8,
          ),
        ),
      ],
    );
  }
}
