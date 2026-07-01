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

class ReviewScreen extends ConsumerWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registrationState = ref.watch(vehicleRegistrationProvider);
    final vehicle = registrationState.vehicle;
    final progress = ref.watch(progressPercentageProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Review'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: AppSpacing.screenPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Progress Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    decoration: BoxDecoration(
                      color: progress == 100
                          ? AppColors.successLight
                          : AppColors.warningLight,
                      borderRadius: AppSpacing.borderRadiusLg,
                    ),
                    child: Column(
                      children: [
                        Icon(
                          progress == 100 ? Icons.check_circle : Icons.pending,
                          size: 48,
                          color: progress == 100 ? AppColors.success : AppColors.warning,
                        ),
                        AppSpacing.vGapSm,
                        Text(
                          progress == 100 ? 'Ready to Submit' : 'Almost There',
                          style: AppTypography.titleLarge.copyWith(
                            color: progress == 100 ? AppColors.success : AppColors.warning,
                          ),
                        ),
                        AppSpacing.vGapXs,
                        Text(
                          progress == 100
                              ? 'All steps completed!'
                              : '$progress% complete - finish remaining steps',
                          style: AppTypography.bodyMedium.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  AppSpacing.vGapLg,

                  // Vehicle Summary
                  if (vehicle != null) ...[
                    _buildSectionCard(
                      title: 'Vehicle Information',
                      icon: Icons.directions_car_outlined,
                      isComplete: registrationState.vehicleDetailsConfirmed,
                      children: [
                        _buildDetailRow('Vehicle', '${vehicle.brand} ${vehicle.model}'),
                        _buildDetailRow('Year', vehicle.year.toString()),
                        _buildDetailRow('Plate', vehicle.plate),
                        _buildDetailRow('Mileage', '${registrationState.mileage} km'),
                      ],
                    ),
                    AppSpacing.vGapMd,
                  ],

                  // Extra Features
                  _buildSectionCard(
                    title: 'Extra Features',
                    icon: Icons.star_outline,
                    isComplete: registrationState.extraFeaturesConfirmed,
                    children: [
                      Text(
                        registrationState.extraFeatures.isEmpty
                            ? 'No extra features selected'
                            : registrationState.extraFeatures.join(', '),
                        style: AppTypography.bodyMedium,
                      ),
                    ],
                  ),
                  AppSpacing.vGapMd,

                  // Keys
                  _buildSectionCard(
                    title: 'Keys',
                    icon: Icons.key,
                    isComplete: registrationState.keysConfirmed,
                    children: [
                      Text(
                        '${registrationState.numberOfKeys} key(s)',
                        style: AppTypography.bodyMedium,
                      ),
                    ],
                  ),
                  AppSpacing.vGapMd,

                  // Finance
                  _buildSectionCard(
                    title: 'Finance',
                    icon: Icons.credit_card,
                    isComplete: registrationState.financeConfirmed,
                    children: [
                      Text(
                        registrationState.hasFinance
                            ? 'Outstanding finance'
                            : 'No outstanding finance',
                        style: AppTypography.bodyMedium,
                      ),
                    ],
                  ),
                  AppSpacing.vGapMd,

                  // Running Condition
                  _buildSectionCard(
                    title: 'Running Condition',
                    icon: Icons.engineering_outlined,
                    isComplete: registrationState.runningConditionConfirmed,
                    children: [
                      Text(
                        _getRunningConditionText(registrationState.runningCondition),
                        style: AppTypography.bodyMedium,
                      ),
                    ],
                  ),
                  AppSpacing.vGapMd,

                  // Mechanical Issues
                  _buildSectionCard(
                    title: 'Mechanical Issues',
                    icon: Icons.build_outlined,
                    isComplete: registrationState.mechanicalIssuesConfirmed,
                    children: [
                      Text(
                        registrationState.mechanicalIssues.isEmpty
                            ? 'No mechanical issues'
                            : registrationState.mechanicalIssues.join(', '),
                        style: AppTypography.bodyMedium,
                      ),
                    ],
                  ),
                  AppSpacing.vGapMd,

                  // Exterior Photos
                  _buildSectionCard(
                    title: 'Fotos Exteriores',
                    icon: Icons.camera_alt_outlined,
                    isComplete: registrationState.photosConfirmed,
                    children: [
                      Text(
                        '${registrationState.exteriorPhotosMap.length} fotos exteriores',
                        style: AppTypography.bodyMedium,
                      ),
                    ],
                  ),
                  AppSpacing.vGapMd,

                  // Interior Photos
                  _buildSectionCard(
                    title: 'Fotos Interiores',
                    icon: Icons.chair_outlined,
                    isComplete: registrationState.interiorPhotosConfirmed,
                    children: [
                      Text(
                        '${registrationState.interiorPhotosMap.length} fotos interiores',
                        style: AppTypography.bodyMedium,
                      ),
                    ],
                  ),
                  AppSpacing.vGapMd,

                  // Condition & Damage
                  _buildSectionCard(
                    title: 'Condition & Damage',
                    icon: Icons.report_problem_outlined,
                    isComplete: registrationState.conditionDamageConfirmed,
                    children: [
                      Text(
                        registrationState.damages.isEmpty
                            ? 'No damage reported'
                            : '${registrationState.damages.length} damage item(s)',
                        style: AppTypography.bodyMedium,
                      ),
                    ],
                  ),
                  AppSpacing.vGapMd,

                  // Service History
                  _buildSectionCard(
                    title: 'Service History',
                    icon: Icons.history_outlined,
                    isComplete: registrationState.serviceHistoryConfirmed,
                    children: [
                      Text(
                        _getServiceHistoryText(registrationState.serviceHistoryType),
                        style: AppTypography.bodyMedium,
                      ),
                    ],
                  ),
                  AppSpacing.vGapLg,
                ],
              ),
            ),
          ),
          Container(
            padding: AppSpacing.screenPadding,
            decoration: BoxDecoration(
              color: AppColors.surface,
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadow,
                  blurRadius: 8,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: PrimaryButton(
              text: 'Submit For Review',
              isEnabled: progress == 100,
              onPressed: progress == 100
                  ? () {
                      ref.read(vehicleRegistrationProvider.notifier).submitForReview();
                      context.go(AppRoutes.submissionStatus);
                    }
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required bool isComplete,
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: AppSpacing.borderRadiusMd,
        border: Border.all(
          color: isComplete ? AppColors.success : AppColors.border,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: isComplete ? AppColors.success : AppColors.textSecondary,
                size: 20,
              ),
              AppSpacing.hGapSm,
              Text(
                title,
                style: AppTypography.titleSmall.copyWith(
                  color: isComplete ? AppColors.success : AppColors.textPrimary,
                ),
              ),
              const Spacer(),
              if (isComplete)
                const Icon(
                  Icons.check_circle,
                  color: AppColors.success,
                  size: 20,
                )
              else
                const Icon(
                  Icons.pending,
                  color: AppColors.textTertiary,
                  size: 20,
                ),
            ],
          ),
          AppSpacing.vGapSm,
          ...children,
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.xs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          Text(
            value,
            style: AppTypography.bodyMedium,
          ),
        ],
      ),
    );
  }

  String _getRunningConditionText(RunningCondition? condition) {
    switch (condition) {
      case RunningCondition.startsAndDrivesSmoothly:
        return 'Starts and drives smoothly';
      case RunningCondition.startsAndDrivesWithIssues:
        return 'Starts and drives with issues';
      case RunningCondition.doesNotStart:
        return 'Does not start';
      case null:
        return 'Not specified';
    }
  }

  String _getServiceHistoryText(ServiceHistoryType? type) {
    switch (type) {
      case ServiceHistoryType.full:
        return 'Full service history';
      case ServiceHistoryType.partial:
        return 'Partial service history';
      case ServiceHistoryType.none:
        return 'No service history';
      case null:
        return 'Not specified';
    }
  }
}
