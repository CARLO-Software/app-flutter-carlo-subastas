import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/providers/providers.dart';

const _options = [
  {'id': 'tiene_llave', 'label': 'Tengo la llave', 'sub': null},
  {'id': 'llave_faltante', 'label': 'La llave falta', 'sub': null},
  {'id': 'tuercas_estandar', 'label': 'Mi coche tiene tuercas estándar', 'sub': 'No necesita llave'},
];

class LockingWheelNutScreen extends ConsumerStatefulWidget {
  const LockingWheelNutScreen({super.key});

  @override
  ConsumerState<LockingWheelNutScreen> createState() => _LockingWheelNutScreenState();
}

class _LockingWheelNutScreenState extends ConsumerState<LockingWheelNutScreen> {
  String? _selected;

  @override
  void initState() {
    super.initState();
    final state = ref.read(vehicleRegistrationProvider);
    if (state.lockingWheelNutConfirmed) {
      _selected = state.lockingWheelNutOption;
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;

    return Scaffold(
      backgroundColor: c.background,
      appBar: AppBar(
        backgroundColor: c.background,
        foregroundColor: c.textPrimary,
        titleTextStyle: AppTypography.titleLarge.copyWith(color: c.textPrimary),
        iconTheme: IconThemeData(color: c.textPrimary),
        title: const Text('Tuerca de seguridad'),
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
                    '¿Tienes la llave de tuerca de seguridad?',
                    style: AppTypography.titleLarge.copyWith(
                      color: c.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  AppSpacing.vGapXs,
                  Text(
                    'Es un casquillo metálico con un patrón único que se usa para quitar las ruedas. Puede estar en la guantera o bajo el piso del maletero.',
                    style: AppTypography.bodyMedium.copyWith(
                      color: c.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  AppSpacing.vGapLg,
                  Row(
                    children: [
                      Expanded(
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              color: c.surfaceVariant,
                              borderRadius: AppSpacing.borderRadiusLg,
                            ),
                            child: Center(
                              child: Icon(Icons.build_outlined, color: c.textTertiary, size: 48),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              color: c.surfaceVariant,
                              borderRadius: AppSpacing.borderRadiusLg,
                            ),
                            child: Center(
                              child: Icon(Icons.settings_outlined, color: c.textTertiary, size: 48),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  AppSpacing.vGapXxl,
                  ..._options.map((option) {
                    final id = option['id'] as String;
                    final label = option['label'] as String;
                    final sub = option['sub'];
                    final isSelected = _selected == id;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                      child: GestureDetector(
                        onTap: () => setState(() => _selected = id),
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
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: isSelected ? AppColors.primary : c.border,
                                    width: 2,
                                  ),
                                ),
                                child: isSelected
                                    ? Center(
                                        child: Container(
                                          width: 12,
                                          height: 12,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColors.primary,
                                          ),
                                        ),
                                      )
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
                  AppSpacing.vGapLg,
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: const Color(0xFFDFE6FE),
                      borderRadius: AppSpacing.borderRadiusMd,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 28,
                          height: 28,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF032384),
                          ),
                          child: const Center(
                            child: Text(
                              'i',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: Text(
                            'La llave de tuerca de seguridad es única para tu vehículo. Sin ella, no se pueden retirar las ruedas para mantenimiento.',
                            style: AppTypography.bodySmall.copyWith(
                              color: const Color(0xFF032384),
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
            color: c.background,
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _selected != null
                        ? () {
                            final notifier = ref.read(vehicleRegistrationProvider.notifier);
                            notifier.setLockingWheelNutOption(_selected!);
                            notifier.confirmLockingWheelNut();
                            context.push(AppRoutes.toolPack);
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
