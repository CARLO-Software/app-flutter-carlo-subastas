import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../shared/providers/providers.dart';
import '../../../shared/widgets/widgets.dart';

class ExtraFeaturesScreen extends ConsumerWidget {
  const ExtraFeaturesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registrationState = ref.watch(vehicleRegistrationProvider);
    final selectedFeatures = registrationState.extraFeatures;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Características Extra'),
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
                    title: 'Seleccionar Características',
                    subtitle: 'Selecciona todas las características que tiene tu vehículo',
                  ),
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: AppConstants.extraFeatureOptions.map((feature) {
                      final isSelected = selectedFeatures.contains(feature);
                      return SelectableChip(
                        label: feature,
                        isSelected: isSelected,
                        onTap: () {
                          ref
                              .read(vehicleRegistrationProvider.notifier)
                              .toggleExtraFeature(feature);
                        },
                      );
                    }).toList(),
                  ),
                  AppSpacing.vGapLg,
                  if (selectedFeatures.isNotEmpty) ...[
                    FeedbackBanner(
                      type: FeedbackType.success,
                      text: '${selectedFeatures.length} característica(s) seleccionada(s)',
                    ),
                  ],
                  AppSpacing.vGapLg,
                ],
              ),
            ),
          ),
          BottomActionBar(
            child: PrimaryButton(
              text: 'Confirmar',
              onPressed: () {
                ref.read(vehicleRegistrationProvider.notifier).confirmExtraFeatures();
                context.pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}
