import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/providers/providers.dart';

class SmokingScreen extends ConsumerStatefulWidget {
  const SmokingScreen({super.key});

  @override
  ConsumerState<SmokingScreen> createState() => _SmokingScreenState();
}

class _SmokingScreenState extends ConsumerState<SmokingScreen> {
  bool? _smoked;

  @override
  void initState() {
    super.initState();
    final state = ref.read(vehicleRegistrationProvider);
    if (state.smokingConfirmed) {
      _smoked = state.hasBeenSmokedIn;
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;

    return Scaffold(
      backgroundColor: c.background,
      appBar: AppBar(
        title: const Text('Fumador'),
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
                  AppSpacing.vGapMd,
                  Text(
                    'Fumador',
                    style: AppTypography.headlineSmall.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  AppSpacing.vGapSm,
                  Text(
                    '¿Alguien ha fumado regularmente dentro del vehículo?',
                    style: AppTypography.bodyMedium.copyWith(
                      color: c.textSecondary,
                    ),
                  ),
                  AppSpacing.vGapXs,
                  Text(
                    'Selecciona una opción',
                    style: AppTypography.bodySmall.copyWith(
                      color: c.textTertiary,
                    ),
                  ),
                  AppSpacing.vGapLg,
                  _RadioOption(
                    label: 'No se ha fumado en el vehículo',
                    selected: _smoked == false,
                    onTap: () => setState(() => _smoked = false),
                    c: c,
                  ),
                  Divider(color: c.divider),
                  _RadioOption(
                    label: 'Sí, se ha fumado en el vehículo',
                    selected: _smoked == true,
                    onTap: () => setState(() => _smoked = true),
                    c: c,
                  ),
                  Divider(color: c.divider),
                  AppSpacing.vGapLg,
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: AppColors.info.withValues(alpha: 0.1),
                      borderRadius: AppSpacing.borderRadiusMd,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.info_outline,
                            color: AppColors.info, size: 20),
                        AppSpacing.hGapSm,
                        Expanded(
                          child: Text(
                            'Esto no aplica para vapeo. Si se ha vapeado regularmente en el vehículo, selecciona "No se ha fumado".',
                            style: AppTypography.bodySmall.copyWith(
                              color: c.textSecondary,
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
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: c.card,
              border: Border(top: BorderSide(color: c.border)),
            ),
            child: SafeArea(
              top: false,
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _smoked != null
                      ? () {
                          ref
                              .read(vehicleRegistrationProvider.notifier)
                              .setHasBeenSmokedIn(_smoked!);
                          ref
                              .read(vehicleRegistrationProvider.notifier)
                              .confirmSmoking();
                          context.pop();
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: c.surfaceVariant,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: AppSpacing.borderRadiusMd,
                    ),
                  ),
                  child: Text(
                    'Confirmar',
                    style: AppTypography.button.copyWith(color: Colors.white),
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

class _RadioOption extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final AdaptiveColors c;

  const _RadioOption({
    required this.label,
    required this.selected,
    required this.onTap,
    required this.c,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
        child: Row(
          children: [
            Icon(
              selected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: selected ? AppColors.primary : c.textTertiary,
            ),
            AppSpacing.hGapMd,
            Expanded(
              child: Text(
                label,
                style: AppTypography.bodyMedium.copyWith(
                  fontWeight: selected ? FontWeight.w500 : FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
