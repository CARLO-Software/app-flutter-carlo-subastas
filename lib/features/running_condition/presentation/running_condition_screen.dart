import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../models/models.dart';
import '../../../shared/providers/providers.dart';
import '../../../shared/widgets/widgets.dart';

class RunningConditionScreen extends ConsumerWidget {
  const RunningConditionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registrationState = ref.watch(vehicleRegistrationProvider);
    final selectedCondition = registrationState.runningCondition;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Running Condition'),
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
                    title: 'How does your vehicle run?',
                    subtitle: 'Tell us about the current running condition',
                  ),
                  SelectableOptionCard(
                    title: 'Starts and drives smoothly',
                    subtitle: 'No issues with the vehicle',
                    icon: Icons.thumb_up_outlined,
                    isSelected: selectedCondition == RunningCondition.startsAndDrivesSmoothly,
                    onTap: () {
                      ref
                          .read(vehicleRegistrationProvider.notifier)
                          .setRunningCondition(RunningCondition.startsAndDrivesSmoothly);
                    },
                  ),
                  AppSpacing.vGapMd,
                  SelectableOptionCard(
                    title: 'Starts and drives with issues',
                    subtitle: 'Some minor issues while driving',
                    icon: Icons.warning_amber_outlined,
                    isSelected: selectedCondition == RunningCondition.startsAndDrivesWithIssues,
                    onTap: () {
                      ref
                          .read(vehicleRegistrationProvider.notifier)
                          .setRunningCondition(RunningCondition.startsAndDrivesWithIssues);
                    },
                  ),
                  AppSpacing.vGapMd,
                  SelectableOptionCard(
                    title: 'Doesn\'t start',
                    subtitle: 'The vehicle is not starting',
                    icon: Icons.error_outline,
                    isSelected: selectedCondition == RunningCondition.doesNotStart,
                    onTap: () {
                      ref
                          .read(vehicleRegistrationProvider.notifier)
                          .setRunningCondition(RunningCondition.doesNotStart);
                    },
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
              text: 'Next',
              isEnabled: selectedCondition != null,
              onPressed: selectedCondition != null
                  ? () {
                      ref.read(vehicleRegistrationProvider.notifier).confirmRunningCondition();
                      context.push(AppRoutes.mechanicalIssues);
                    }
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
