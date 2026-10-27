import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/providers/providers.dart';

const _cables = [
  {'id': 'cable_3_pines', 'label': 'Cable doméstico de 3 pines'},
  {'id': 'cable_carga_rapida', 'label': 'Cable de carga rápida'},
];

class ChargingCablesScreen extends ConsumerWidget {
  const ChargingCablesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = context.colors;
    final selected = ref.watch(vehicleRegistrationProvider.select((s) => s.chargingCables));

    return Scaffold(
      backgroundColor: c.background,
      appBar: AppBar(
        backgroundColor: c.background,
        foregroundColor: c.textPrimary,
        titleTextStyle: AppTypography.titleLarge.copyWith(color: c.textPrimary),
        iconTheme: IconThemeData(color: c.textPrimary),
        title: const Text('Cables de carga'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '¿Incluyes cables de carga?',
                    style: AppTypography.titleLarge.copyWith(
                      color: c.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  AppSpacing.vGapXs,
                  Text(
                    'Selecciona los cables que vendrán con tu coche. ¿Tienes un híbrido? Solo presiona siguiente.',
                    style: AppTypography.bodyMedium.copyWith(
                      color: c.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  AppSpacing.vGapXxl,
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: _cables.map((cable) {
                      final id = cable['id']!;
                      final label = cable['label']!;
                      final isSelected = selected.contains(id);

                      return FilterChip(
                        label: Text(label),
                        selected: isSelected,
                        onSelected: (_) {
                          ref.read(vehicleRegistrationProvider.notifier).toggleChargingCable(id);
                        },
                        selectedColor: AppColors.primary,
                        backgroundColor: c.surfaceVariant,
                        checkmarkColor: Colors.white,
                        labelStyle: AppTypography.bodyMedium.copyWith(
                          color: isSelected ? Colors.white : c.textSecondary,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: AppSpacing.borderRadiusXl,
                          side: BorderSide(
                            color: isSelected ? AppColors.primary : c.border,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: c.background,
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      ref.read(vehicleRegistrationProvider.notifier).confirmChargingCables();
                      context.push(AppRoutes.interiorCondition);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: AppSpacing.borderRadiusXl,
                      ),
                    ),
                    child: Text(
                      'Continuar',
                      style: AppTypography.button.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
