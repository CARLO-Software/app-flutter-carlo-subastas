import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/providers/providers.dart';

const _issues = [
  {'id': 'fumado', 'label': 'Se ha fumado dentro', 'sub': null},
  {'id': 'manchas', 'label': 'Manchas o derrames leves', 'sub': null},
  {'id': 'rasgaduras', 'label': 'Rasgaduras, desgarros o quemaduras', 'sub': null},
  {'id': 'volante_danado', 'label': 'Volante dañado', 'sub': 'ej. Rozaduras leves, descascaramiento o desgaste'},
  {'id': 'accesorios_rotos', 'label': 'Accesorios rotos o faltantes', 'sub': 'ej. Ventilaciones, manijas, botones'},
  {'id': 'sin_problemas', 'label': 'Sin problemas', 'sub': 'Mi interior está en buenas condiciones'},
];

class InteriorConditionScreen extends ConsumerWidget {
  const InteriorConditionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = context.colors;
    final selected = ref.watch(vehicleRegistrationProvider.select((s) => s.interiorConditionIssues));

    return Scaffold(
      backgroundColor: c.background,
      appBar: AppBar(
        backgroundColor: c.background,
        foregroundColor: c.textPrimary,
        titleTextStyle: AppTypography.titleLarge.copyWith(color: c.textPrimary),
        iconTheme: IconThemeData(color: c.textPrimary),
        title: const Text('Condición interior'),
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
                    'Cuéntanos sobre la condición del interior',
                    style: AppTypography.titleLarge.copyWith(
                      color: c.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  AppSpacing.vGapXs,
                  Text(
                    'Selecciona todas las que apliquen, incluso si es desgaste normal para la edad del coche.',
                    style: AppTypography.bodyMedium.copyWith(
                      color: c.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  AppSpacing.vGapXxl,
                  ..._issues.map((issue) {
                    final id = issue['id'] as String;
                    final label = issue['label'] as String;
                    final sub = issue['sub'];
                    final isSelected = selected.contains(id);

                    return Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                      child: GestureDetector(
                        onTap: () {
                          ref.read(vehicleRegistrationProvider.notifier).toggleInteriorConditionIssue(id);
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(AppSpacing.md),
                          decoration: BoxDecoration(
                            color: c.surfaceVariant,
                            borderRadius: AppSpacing.borderRadiusLg,
                            border: Border.all(
                              color: isSelected ? AppColors.primary : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: isSelected ? AppColors.primary : Colors.transparent,
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                    color: isSelected ? AppColors.primary : c.border,
                                    width: 2,
                                  ),
                                ),
                                child: isSelected
                                    ? const Icon(Icons.check, size: 16, color: Colors.white)
                                    : null,
                              ),
                              const SizedBox(width: AppSpacing.md),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      label,
                                      style: AppTypography.bodyMedium.copyWith(
                                        color: c.textPrimary,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    if (sub != null) ...[
                                      const SizedBox(height: 2),
                                      Text(
                                        sub,
                                        style: AppTypography.bodySmall.copyWith(
                                          color: c.textTertiary,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
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
                    onPressed: selected.isNotEmpty
                        ? () {
                            ref.read(vehicleRegistrationProvider.notifier).confirmInteriorCondition();
                            context.push(AppRoutes.lockingWheelNut);
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: AppColors.primary.withValues(alpha: 0.3),
                      disabledForegroundColor: Colors.white,
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
