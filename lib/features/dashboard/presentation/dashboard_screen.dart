import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/providers/providers.dart';
import '../../../shared/widgets/widgets.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registrationState = ref.watch(vehicleRegistrationProvider);
    final vehicle = registrationState.vehicle;
    final progress = ref.watch(progressPercentageProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go(AppRoutes.vehicleLookup),
        ),
        title: Text(
          vehicle?.plate ?? 'Vehicle',
          style: AppTypography.titleLarge,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              _showMenu(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: AppSpacing.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Estimated Value Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.primaryLight],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: AppSpacing.borderRadiusLg,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Estimated Auction Value',
                    style: AppTypography.labelMedium.copyWith(
                      color: AppColors.textOnPrimary.withValues(alpha: 0.8),
                    ),
                  ),
                  AppSpacing.vGapSm,
                  Text(
                    'S/ 45,000 - S/ 52,000',
                    style: AppTypography.headlineMedium.copyWith(
                      color: AppColors.textOnPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  AppSpacing.vGapMd,
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Progress',
                              style: AppTypography.labelSmall.copyWith(
                                color: AppColors.textOnPrimary.withValues(alpha: 0.8),
                              ),
                            ),
                            AppSpacing.vGapXs,
                            ClipRRect(
                              borderRadius: AppSpacing.borderRadiusFull,
                              child: LinearProgressIndicator(
                                value: progress / 100,
                                backgroundColor:
                                    AppColors.textOnPrimary.withValues(alpha: 0.3),
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                  AppColors.textOnPrimary,
                                ),
                                minHeight: 8,
                              ),
                            ),
                          ],
                        ),
                      ),
                      AppSpacing.hGapMd,
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md,
                          vertical: AppSpacing.xs,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.textOnPrimary.withValues(alpha: 0.2),
                          borderRadius: AppSpacing.borderRadiusFull,
                        ),
                        child: Text(
                          '$progress%',
                          style: AppTypography.titleMedium.copyWith(
                            color: AppColors.textOnPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            AppSpacing.vGapLg,

            // Vehicle Summary
            if (vehicle != null) ...[
              const SectionHeader(
                title: 'Your Vehicle',
              ),
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: AppSpacing.borderRadiusMd,
                  border: Border.all(color: AppColors.cardBorder),
                ),
                child: Row(
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
                            '${vehicle.year} | ${vehicle.color} | ${vehicle.fuelType}',
                            style: AppTypography.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    StatusBadge(status: registrationState.submissionStatus),
                  ],
                ),
              ),
              AppSpacing.vGapLg,
            ],

            // Progress Cards
            const SectionHeader(
              title: 'Registration Steps',
              subtitle: 'Complete all steps to submit your vehicle',
            ),
            ProgressCard(
              title: 'Vehicle Information',
              subtitle: 'Review and confirm your vehicle details',
              icon: Icons.directions_car_outlined,
              isCompleted: registrationState.vehicleDetailsConfirmed,
              onTap: () => context.push(AppRoutes.vehicleDetails),
            ),
            AppSpacing.vGapMd,
            ProgressCard(
              title: 'Photos',
              subtitle: 'Take photos of your vehicle',
              icon: Icons.camera_alt_outlined,
              isCompleted: registrationState.photosConfirmed,
              onTap: () => context.push(AppRoutes.photoIntroduction),
            ),
            AppSpacing.vGapMd,
            ProgressCard(
              title: 'Condition & Damage',
              subtitle: 'Report any damage to your vehicle',
              icon: Icons.report_problem_outlined,
              isCompleted: registrationState.conditionDamageConfirmed,
              onTap: () => context.push(AppRoutes.conditionDamage),
            ),
            AppSpacing.vGapMd,
            ProgressCard(
              title: 'Service History',
              subtitle: 'Upload your service records',
              icon: Icons.history_outlined,
              isCompleted: registrationState.serviceHistoryConfirmed,
              onTap: () => context.push(AppRoutes.serviceHistory),
            ),
            AppSpacing.vGapXl,
            PrimaryButton(
              text: 'Add your vehicle information',
              onPressed: () => context.push(AppRoutes.vehicleDetails),
            ),
            AppSpacing.vGapMd,
          ],
        ),
      ),
    );
  }

  void _showMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppSpacing.radiusLg),
          topRight: Radius.circular(AppSpacing.radiusLg),
        ),
      ),
      builder: (context) => Container(
        padding: AppSpacing.screenPadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: AppSpacing.borderRadiusFull,
              ),
            ),
            AppSpacing.vGapLg,
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text('Dashboard'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.check_circle_outline),
              title: const Text('Review & Submit'),
              onTap: () {
                Navigator.pop(context);
                context.push(AppRoutes.review);
              },
            ),
            ListTile(
              leading: const Icon(Icons.track_changes_outlined),
              title: const Text('Submission Status'),
              onTap: () {
                Navigator.pop(context);
                context.push(AppRoutes.submissionStatus);
              },
            ),
            AppSpacing.vGapMd,
          ],
        ),
      ),
    );
  }
}
