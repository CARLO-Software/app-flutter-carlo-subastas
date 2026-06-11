import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../shared/providers/providers.dart';
import '../../../shared/widgets/widgets.dart';

class FinanceScreen extends ConsumerWidget {
  const FinanceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registrationState = ref.watch(vehicleRegistrationProvider);
    final hasFinance = registrationState.hasFinance;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Finance'),
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
                    title: 'Is there any outstanding finance?',
                    subtitle: 'Let us know if you have any finance to settle',
                  ),
                  SelectableOptionCard(
                    title: 'Yes',
                    subtitle: 'There is outstanding finance on this vehicle',
                    icon: Icons.credit_card,
                    isSelected: hasFinance == true,
                    onTap: () {
                      ref.read(vehicleRegistrationProvider.notifier).setHasFinance(true);
                    },
                  ),
                  AppSpacing.vGapMd,
                  SelectableOptionCard(
                    title: 'No',
                    subtitle: 'This vehicle is finance free',
                    icon: Icons.check_circle_outline,
                    isSelected: hasFinance == false,
                    onTap: () {
                      ref.read(vehicleRegistrationProvider.notifier).setHasFinance(false);
                    },
                  ),
                  AppSpacing.vGapLg,
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: AppColors.infoLight,
                      borderRadius: AppSpacing.borderRadiusMd,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.info_outline,
                          color: AppColors.info,
                          size: 20,
                        ),
                        AppSpacing.hGapSm,
                        const Expanded(
                          child: Text(
                            'Don\'t worry if you have finance. We can help settle it from the auction proceeds.',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
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
              text: 'Next',
              onPressed: () {
                ref.read(vehicleRegistrationProvider.notifier).confirmFinance();
                context.push(AppRoutes.runningCondition);
              },
            ),
          ),
        ],
      ),
    );
  }
}
