import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/providers/providers.dart';

class PrivatePlateScreen extends ConsumerStatefulWidget {
  const PrivatePlateScreen({super.key});

  @override
  ConsumerState<PrivatePlateScreen> createState() => _PrivatePlateScreenState();
}

class _PrivatePlateScreenState extends ConsumerState<PrivatePlateScreen> {
  bool? _isPrivate;

  @override
  void initState() {
    super.initState();
    final state = ref.read(vehicleRegistrationProvider);
    if (state.privatePlateConfirmed) {
      _isPrivate = state.hasPrivatePlate;
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;

    return Scaffold(
      backgroundColor: c.background,
      appBar: AppBar(
        title: const Text('Tipo de placa'),
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
                    '¿Tu vehículo tiene placa particular?',
                    style: AppTypography.headlineSmall.copyWith(
                      fontWeight: FontWeight.w700,
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
                    label: 'Sí, tiene placa particular',
                    selected: _isPrivate == true,
                    onTap: () => setState(() => _isPrivate = true),
                    c: c,
                  ),
                  Divider(color: c.divider),
                  _RadioOption(
                    label: 'No, tiene placa estándar',
                    selected: _isPrivate == false,
                    onTap: () => setState(() => _isPrivate = false),
                    c: c,
                  ),
                  Divider(color: c.divider),
                  AppSpacing.vGapLg,
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
                  onPressed: _isPrivate != null
                      ? () {
                          ref
                              .read(vehicleRegistrationProvider.notifier)
                              .setHasPrivatePlate(_isPrivate!);
                          ref
                              .read(vehicleRegistrationProvider.notifier)
                              .confirmPrivatePlate();
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
