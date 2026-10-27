import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/app_routes.dart';
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
    final selected = ref.watch(vehicleRegistrationProvider.select((s) => s.chargingCables));

    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E1E),
        foregroundColor: Colors.white,
        titleTextStyle: AppTypography.titleLarge.copyWith(color: Colors.white),
        iconTheme: const IconThemeData(color: Colors.white),
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
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  AppSpacing.vGapXs,
                  Text(
                    'Selecciona los cables que vendrán con tu coche. ¿Tienes un híbrido? Solo presiona siguiente.',
                    style: AppTypography.bodyMedium.copyWith(
                      color: Colors.white54,
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
                        selectedColor: Colors.white,
                        backgroundColor: const Color(0xFF2A2A2A),
                        checkmarkColor: Colors.black,
                        labelStyle: AppTypography.bodyMedium.copyWith(
                          color: isSelected ? Colors.black : Colors.white70,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: AppSpacing.borderRadiusXl,
                          side: BorderSide(
                            color: isSelected ? Colors.white : Colors.white24,
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
            color: const Color(0xFF1E1E1E),
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
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: AppSpacing.borderRadiusXl,
                      ),
                    ),
                    child: Text(
                      'Continuar',
                      style: AppTypography.button.copyWith(color: Colors.black),
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
