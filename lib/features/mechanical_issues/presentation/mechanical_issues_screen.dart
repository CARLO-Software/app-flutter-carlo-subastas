import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../shared/providers/providers.dart';
import '../../../shared/widgets/widgets.dart';

class MechanicalIssuesScreen extends ConsumerWidget {
  const MechanicalIssuesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registrationState = ref.watch(vehicleRegistrationProvider);
    final selectedIssues = registrationState.mechanicalIssues;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Problemas Mecánicos'),
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
                    title: '¿Algún problema mecánico?',
                    subtitle: 'Selecciona todos los que apliquen a tu vehículo',
                  ),
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: AppConstants.mechanicalIssueOptions.map((issue) {
                      final isSelected = selectedIssues.contains(issue);
                      return SelectableChip(
                        label: issue,
                        isSelected: isSelected,
                        onTap: () {
                          ref
                              .read(vehicleRegistrationProvider.notifier)
                              .toggleMechanicalIssue(issue);
                        },
                      );
                    }).toList(),
                  ),
                  AppSpacing.vGapLg,
                  if (selectedIssues.isEmpty)
                    const FeedbackBanner(
                      type: FeedbackType.success,
                      text: 'Sin problemas mecánicos reportados. Continúa si tu vehículo no tiene problemas.',
                    )
                  else
                    FeedbackBanner(
                      type: FeedbackType.warning,
                      text: '${selectedIssues.length} problema(s) reportado(s)',
                    ),
                  AppSpacing.vGapLg,
                ],
              ),
            ),
          ),
          BottomActionBar(
            child: PrimaryButton(
              text: 'Confirmar',
              onPressed: () {
                ref.read(vehicleRegistrationProvider.notifier).confirmMechanicalIssues();
                context.pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}
