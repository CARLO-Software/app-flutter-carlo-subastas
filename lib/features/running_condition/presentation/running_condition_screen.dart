import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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
      appBar: AppBar(
        title: const Text('Condición de Funcionamiento'),
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
                    title: '¿Cómo funciona tu vehículo?',
                    subtitle: 'Cuéntanos sobre el estado actual de funcionamiento',
                  ),
                  SelectableOptionCard(
                    title: 'Enciende y funciona correctamente',
                    subtitle: 'Sin problemas con el vehículo',
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
                    title: 'Enciende y funciona con problemas',
                    subtitle: 'Algunos problemas menores al conducir',
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
                    title: 'No enciende',
                    subtitle: 'El vehículo no arranca',
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
          BottomActionBar(
            child: PrimaryButton(
              text: 'Confirmar',
              isEnabled: selectedCondition != null,
              onPressed: selectedCondition != null
                  ? () {
                      ref.read(vehicleRegistrationProvider.notifier).confirmRunningCondition();
                      context.pop();
                    }
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}

