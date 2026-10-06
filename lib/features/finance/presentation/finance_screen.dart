import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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
      appBar: AppBar(
        title: const Text('Financiamiento'),
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
                    title: '¿Tiene algún financiamiento pendiente?',
                    subtitle: 'Déjanos saber si tienes algún financiamiento por liquidar',
                  ),
                  SelectableOptionCard(
                    title: 'Sí',
                    subtitle: 'Tiene financiamiento pendiente en este vehículo',
                    icon: Icons.credit_card,
                    isSelected: hasFinance == true,
                    onTap: () {
                      ref.read(vehicleRegistrationProvider.notifier).setHasFinance(true);
                    },
                  ),
                  AppSpacing.vGapMd,
                  SelectableOptionCard(
                    title: 'No',
                    subtitle: 'Este vehículo está libre de financiamiento',
                    icon: Icons.check_circle_outline,
                    isSelected: hasFinance == false,
                    onTap: () {
                      ref.read(vehicleRegistrationProvider.notifier).setHasFinance(false);
                    },
                  ),
                  AppSpacing.vGapLg,
                  const FeedbackBanner(
                    type: FeedbackType.info,
                    text: 'No te preocupes si tienes financiamiento. Podemos ayudarte a liquidarlo con los fondos de la subasta.',
                  ),
                ],
              ),
            ),
          ),
          BottomActionBar(
            child: PrimaryButton(
              text: 'Confirmar',
              onPressed: () {
                ref.read(vehicleRegistrationProvider.notifier).confirmFinance();
                context.pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}
