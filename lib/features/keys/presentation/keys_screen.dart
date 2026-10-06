import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../shared/providers/providers.dart';
import '../../../shared/widgets/widgets.dart';

class KeysScreen extends ConsumerWidget {
  const KeysScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registrationState = ref.watch(vehicleRegistrationProvider);
    final selectedKeys = registrationState.numberOfKeys;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Llaves'),
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
                    title: '¿Cuántas llaves tienes?',
                    subtitle: 'Selecciona la cantidad de llaves que vienen con tu vehículo',
                  ),
                  SelectableOptionCard(
                    title: '1 Llave',
                    subtitle: 'Una llave original',
                    icon: Icons.key,
                    isSelected: selectedKeys == 1,
                    onTap: () {
                      ref.read(vehicleRegistrationProvider.notifier).setNumberOfKeys(1);
                    },
                  ),
                  AppSpacing.vGapMd,
                  SelectableOptionCard(
                    title: '2 Llaves',
                    subtitle: 'Dos llaves originales',
                    icon: Icons.key,
                    isSelected: selectedKeys == 2,
                    onTap: () {
                      ref.read(vehicleRegistrationProvider.notifier).setNumberOfKeys(2);
                    },
                  ),
                  AppSpacing.vGapMd,
                  SelectableOptionCard(
                    title: '3+ Llaves',
                    subtitle: 'Tres o más llaves originales',
                    icon: Icons.key,
                    isSelected: selectedKeys >= 3,
                    onTap: () {
                      ref.read(vehicleRegistrationProvider.notifier).setNumberOfKeys(3);
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
              onPressed: () {
                ref.read(vehicleRegistrationProvider.notifier).confirmKeys();
                context.pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}
