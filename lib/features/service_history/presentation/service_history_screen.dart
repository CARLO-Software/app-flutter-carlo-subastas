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

class ServiceHistoryScreen extends ConsumerWidget {
  const ServiceHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registrationState = ref.watch(vehicleRegistrationProvider);
    final selectedType = registrationState.serviceHistoryType;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Service History'),
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
                  const SectionHeader(
                    title: 'Service History',
                    subtitle: 'Tell us about your vehicle\'s service history',
                  ),
                  SelectableOptionCard(
                    title: 'Full Service History',
                    subtitle: 'All services completed on schedule',
                    icon: Icons.check_circle_outline,
                    isSelected: selectedType == ServiceHistoryType.full,
                    onTap: () {
                      ref
                          .read(vehicleRegistrationProvider.notifier)
                          .setServiceHistoryType(ServiceHistoryType.full);
                    },
                  ),
                  AppSpacing.vGapMd,
                  SelectableOptionCard(
                    title: 'Partial Service History',
                    subtitle: 'Some service records available',
                    icon: Icons.remove_circle_outline,
                    isSelected: selectedType == ServiceHistoryType.partial,
                    onTap: () {
                      ref
                          .read(vehicleRegistrationProvider.notifier)
                          .setServiceHistoryType(ServiceHistoryType.partial);
                    },
                  ),
                  AppSpacing.vGapMd,
                  SelectableOptionCard(
                    title: 'No Service History',
                    subtitle: 'No service records available',
                    icon: Icons.cancel_outlined,
                    isSelected: selectedType == ServiceHistoryType.none,
                    onTap: () {
                      ref
                          .read(vehicleRegistrationProvider.notifier)
                          .setServiceHistoryType(ServiceHistoryType.none);
                    },
                  ),
                  AppSpacing.vGapLg,

                  // Upload section (placeholder)
                  if (selectedType != null && selectedType != ServiceHistoryType.none) ...[
                    Text(
                      'Upload Documents',
                      style: AppTypography.titleMedium,
                    ),
                    AppSpacing.vGapSm,
                    Text(
                      'Upload your service records for better auction value',
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    AppSpacing.vGapMd,
                    GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Document upload will be available soon'),
                            backgroundColor: AppColors.info,
                          ),
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(AppSpacing.xl),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceVariant,
                          borderRadius: AppSpacing.borderRadiusMd,
                          border: Border.all(
                            color: AppColors.border,
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: 64,
                              height: 64,
                              decoration: BoxDecoration(
                                color: AppColors.primary.withValues(alpha: 0.1),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.upload_file_outlined,
                                size: 32,
                                color: AppColors.primary,
                              ),
                            ),
                            AppSpacing.vGapMd,
                            Text(
                              'Tap to upload documents',
                              style: AppTypography.titleSmall.copyWith(
                                color: AppColors.primary,
                              ),
                            ),
                            AppSpacing.vGapXs,
                            Text(
                              'PDF, JPG, PNG up to 10MB',
                              style: AppTypography.caption,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
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
              text: 'Continue',
              isEnabled: selectedType != null,
              onPressed: selectedType != null
                  ? () {
                      ref.read(vehicleRegistrationProvider.notifier).confirmServiceHistory();
                      context.go(AppRoutes.dashboard);
                    }
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
