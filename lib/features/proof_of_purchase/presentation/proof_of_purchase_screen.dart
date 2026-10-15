import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/providers/providers.dart';

class ProofOfPurchaseScreen extends ConsumerStatefulWidget {
  const ProofOfPurchaseScreen({super.key});

  @override
  ConsumerState<ProofOfPurchaseScreen> createState() =>
      _ProofOfPurchaseScreenState();
}

class _ProofOfPurchaseScreenState
    extends ConsumerState<ProofOfPurchaseScreen> {
  bool? _hasProof;

  @override
  void initState() {
    super.initState();
    final state = ref.read(vehicleRegistrationProvider);
    if (state.proofOfPurchaseConfirmed) {
      _hasProof = state.hasProofOfPurchase;
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;

    return Scaffold(
      backgroundColor: c.background,
      appBar: AppBar(
        title: const Text('Comprobante de compra'),
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
                    'Comprobante de compra',
                    style: AppTypography.headlineSmall.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  AppSpacing.vGapSm,
                  Text(
                    '¿Tienes una factura o recibo formal de la compra del vehículo?',
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
                    label: 'Sí, puedo proporcionarlo cuando se venda',
                    selected: _hasProof == true,
                    onTap: () => setState(() => _hasProof = true),
                    c: c,
                  ),
                  Divider(color: c.divider),
                  _RadioOption(
                    label: 'No tengo comprobante de compra',
                    selected: _hasProof == false,
                    onTap: () => setState(() => _hasProof = false),
                    c: c,
                  ),
                  Divider(color: c.divider),
                  AppSpacing.vGapLg,
                ],
              ),
            ),
          ),
          _BottomBar(
            enabled: _hasProof != null,
            onPressed: () {
              ref
                  .read(vehicleRegistrationProvider.notifier)
                  .setHasProofOfPurchase(_hasProof!);
              ref
                  .read(vehicleRegistrationProvider.notifier)
                  .confirmProofOfPurchase();
              context.pop();
            },
            c: c,
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

class _BottomBar extends StatelessWidget {
  final bool enabled;
  final VoidCallback onPressed;
  final AdaptiveColors c;

  const _BottomBar({
    required this.enabled,
    required this.onPressed,
    required this.c,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
            onPressed: enabled ? onPressed : null,
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
    );
  }
}
