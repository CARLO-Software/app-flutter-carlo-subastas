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
    final c = context.colors;
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
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: c.infoLight,
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
                        Expanded(
                          child: Text(
                            'No te preocupes si tienes financiamiento. Podemos ayudarte a liquidarlo con los fondos de la subasta.',
                            style: TextStyle(
                              color: c.textSecondary,
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
              color: c.surface,
              boxShadow: [
                BoxShadow(
                  color: c.shadow,
                  blurRadius: 8,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: PrimaryButton(
              text: 'Siguiente',
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
