import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../models/models.dart';

class StatusBadge extends StatelessWidget {
  final SubmissionStatus status;

  const StatusBadge({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: _getBackgroundColor(),
        borderRadius: AppSpacing.borderRadiusSm,
      ),
      child: Text(
        _getStatusText(),
        style: AppTypography.labelSmall.copyWith(
          color: _getTextColor(),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Color _getBackgroundColor() {
    switch (status) {
      case SubmissionStatus.draft:
        return AppColors.statusDraft.withValues(alpha: 0.1);
      case SubmissionStatus.submitted:
        return AppColors.statusSubmitted.withValues(alpha: 0.1);
      case SubmissionStatus.underReview:
        return AppColors.statusUnderReview.withValues(alpha: 0.1);
      case SubmissionStatus.approved:
        return AppColors.statusApproved.withValues(alpha: 0.1);
      case SubmissionStatus.rejected:
        return AppColors.statusRejected.withValues(alpha: 0.1);
      case SubmissionStatus.published:
        return AppColors.statusPublished.withValues(alpha: 0.1);
    }
  }

  Color _getTextColor() {
    switch (status) {
      case SubmissionStatus.draft:
        return AppColors.statusDraft;
      case SubmissionStatus.submitted:
        return AppColors.statusSubmitted;
      case SubmissionStatus.underReview:
        return AppColors.statusUnderReview;
      case SubmissionStatus.approved:
        return AppColors.statusApproved;
      case SubmissionStatus.rejected:
        return AppColors.statusRejected;
      case SubmissionStatus.published:
        return AppColors.statusPublished;
    }
  }

  String _getStatusText() {
    switch (status) {
      case SubmissionStatus.draft:
        return 'Draft';
      case SubmissionStatus.submitted:
        return 'Submitted';
      case SubmissionStatus.underReview:
        return 'Under Review';
      case SubmissionStatus.approved:
        return 'Approved';
      case SubmissionStatus.rejected:
        return 'Rejected';
      case SubmissionStatus.published:
        return 'Published';
    }
  }
}
