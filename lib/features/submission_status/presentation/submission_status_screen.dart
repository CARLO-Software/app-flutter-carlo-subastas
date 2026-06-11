import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../models/models.dart';
import '../../../shared/providers/providers.dart';
import '../../../shared/widgets/widgets.dart';

class SubmissionStatusScreen extends ConsumerWidget {
  const SubmissionStatusScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registrationState = ref.watch(vehicleRegistrationProvider);
    final vehicle = registrationState.vehicle;
    final status = registrationState.submissionStatus;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Submission Status'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go(AppRoutes.dashboard),
        ),
      ),
      body: SingleChildScrollView(
        padding: AppSpacing.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppSpacing.vGapLg,
            // Status Icon
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: _getStatusColor(status).withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _getStatusIcon(status),
                size: 56,
                color: _getStatusColor(status),
              ),
            ),
            AppSpacing.vGapLg,
            Text(
              _getStatusTitle(status),
              style: AppTypography.headlineMedium,
              textAlign: TextAlign.center,
            ),
            AppSpacing.vGapSm,
            Text(
              _getStatusDescription(status),
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            AppSpacing.vGapXl,

            // Status Badge
            StatusBadge(status: status),
            AppSpacing.vGapXl,

            // Vehicle Info Card
            if (vehicle != null) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: AppSpacing.borderRadiusLg,
                  border: Border.all(color: AppColors.cardBorder),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            color: AppColors.surfaceVariant,
                            borderRadius: AppSpacing.borderRadiusSm,
                          ),
                          child: const Icon(
                            Icons.directions_car,
                            size: 32,
                            color: AppColors.primary,
                          ),
                        ),
                        AppSpacing.hGapMd,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${vehicle.brand} ${vehicle.model}',
                                style: AppTypography.titleMedium,
                              ),
                              AppSpacing.vGapXs,
                              Text(
                                '${vehicle.year} | ${vehicle.plate}',
                                style: AppTypography.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              AppSpacing.vGapLg,
            ],

            // Status Timeline
            const SectionHeader(
              title: 'Status Timeline',
            ),
            _buildTimelineItem(
              title: 'Draft',
              subtitle: 'Vehicle information saved',
              isCompleted: true,
              isFirst: true,
            ),
            _buildTimelineItem(
              title: 'Submitted',
              subtitle: 'Submitted for review',
              isCompleted: status != SubmissionStatus.draft,
            ),
            _buildTimelineItem(
              title: 'Under Review',
              subtitle: 'Being reviewed by our team',
              isCompleted: status == SubmissionStatus.underReview ||
                  status == SubmissionStatus.approved ||
                  status == SubmissionStatus.published,
            ),
            _buildTimelineItem(
              title: 'Approved',
              subtitle: 'Ready for auction',
              isCompleted: status == SubmissionStatus.approved ||
                  status == SubmissionStatus.published,
            ),
            _buildTimelineItem(
              title: 'Published',
              subtitle: 'Live on auction',
              isCompleted: status == SubmissionStatus.published,
              isLast: true,
            ),
            AppSpacing.vGapXl,

            // Actions
            if (status == SubmissionStatus.draft)
              PrimaryButton(
                text: 'Continue Registration',
                onPressed: () => context.go(AppRoutes.dashboard),
              ),
            if (status == SubmissionStatus.submitted)
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.infoLight,
                  borderRadius: AppSpacing.borderRadiusMd,
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.info_outline,
                      color: AppColors.info,
                    ),
                    AppSpacing.hGapSm,
                    const Expanded(
                      child: Text(
                        'We\'ll notify you once your vehicle has been reviewed.',
                        style: TextStyle(color: AppColors.textSecondary),
                      ),
                    ),
                  ],
                ),
              ),
            AppSpacing.vGapMd,
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineItem({
    required String title,
    required String subtitle,
    required bool isCompleted,
    bool isFirst = false,
    bool isLast = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isCompleted ? AppColors.success : AppColors.surfaceVariant,
                border: Border.all(
                  color: isCompleted ? AppColors.success : AppColors.border,
                  width: 2,
                ),
              ),
              child: isCompleted
                  ? const Icon(
                      Icons.check,
                      size: 14,
                      color: AppColors.textOnPrimary,
                    )
                  : null,
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 40,
                color: isCompleted ? AppColors.success : AppColors.border,
              ),
          ],
        ),
        AppSpacing.hGapMd,
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(bottom: isLast ? 0 : AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.titleSmall.copyWith(
                    color: isCompleted ? AppColors.success : AppColors.textSecondary,
                  ),
                ),
                Text(
                  subtitle,
                  style: AppTypography.bodySmall,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(SubmissionStatus status) {
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

  IconData _getStatusIcon(SubmissionStatus status) {
    switch (status) {
      case SubmissionStatus.draft:
        return Icons.edit_outlined;
      case SubmissionStatus.submitted:
        return Icons.send_outlined;
      case SubmissionStatus.underReview:
        return Icons.hourglass_empty_outlined;
      case SubmissionStatus.approved:
        return Icons.check_circle_outline;
      case SubmissionStatus.rejected:
        return Icons.cancel_outlined;
      case SubmissionStatus.published:
        return Icons.public_outlined;
    }
  }

  String _getStatusTitle(SubmissionStatus status) {
    switch (status) {
      case SubmissionStatus.draft:
        return 'Registration in Progress';
      case SubmissionStatus.submitted:
        return 'Submitted Successfully';
      case SubmissionStatus.underReview:
        return 'Under Review';
      case SubmissionStatus.approved:
        return 'Approved';
      case SubmissionStatus.rejected:
        return 'Needs Attention';
      case SubmissionStatus.published:
        return 'Live on Auction';
    }
  }

  String _getStatusDescription(SubmissionStatus status) {
    switch (status) {
      case SubmissionStatus.draft:
        return 'Complete all steps to submit your vehicle for auction.';
      case SubmissionStatus.submitted:
        return 'Your vehicle has been submitted and is awaiting review.';
      case SubmissionStatus.underReview:
        return 'Our team is currently reviewing your vehicle submission.';
      case SubmissionStatus.approved:
        return 'Congratulations! Your vehicle has been approved for auction.';
      case SubmissionStatus.rejected:
        return 'Please review and update the required information.';
      case SubmissionStatus.published:
        return 'Your vehicle is now live and available for bidding.';
    }
  }
}
