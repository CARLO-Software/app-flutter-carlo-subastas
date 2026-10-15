import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/providers/providers.dart';
import '../../../shared/widgets/widgets.dart';

class LockingWheelNutScreen extends ConsumerStatefulWidget {
  const LockingWheelNutScreen({super.key});

  @override
  ConsumerState<LockingWheelNutScreen> createState() => _LockingWheelNutScreenState();
}

class _LockingWheelNutScreenState extends ConsumerState<LockingWheelNutScreen> {
  bool? _hasLockingWheelNut;

  @override
  void initState() {
    super.initState();
    final state = ref.read(vehicleRegistrationProvider);
    if (state.lockingWheelNutConfirmed) {
      _hasLockingWheelNut = state.hasLockingWheelNut;
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;

    return Scaffold(
      backgroundColor: c.background,
      appBar: AppBar(
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
              padding: AppSpacing.screenPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionHeader(
                    title: 'Tuerca de seguridad',
                    subtitle: '¿Tu vehículo tiene la llave de tuerca de seguridad para las ruedas?',
                  ),
                  _buildOption(c, true, 'Sí, tiene tuerca de seguridad'),
                  AppSpacing.vGapSm,
                  _buildOption(c, false, 'No tiene tuerca de seguridad'),
                  AppSpacing.vGapLg,
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.05),
                      borderRadius: AppSpacing.borderRadiusMd,
                      border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.info_outline, color: AppColors.primary, size: 20),
                        AppSpacing.hGapSm,
                        Expanded(
                          child: Text(
                            'La tuerca de seguridad evita el robo de ruedas. Es una pieza especial que requiere una llave única.',
                            style: AppTypography.bodySmall.copyWith(color: c.textSecondary),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          BottomActionBar(
            child: PrimaryButton(
              text: 'Confirmar',
              isEnabled: _hasLockingWheelNut != null,
              onPressed: _hasLockingWheelNut != null
                  ? () {
                      ref.read(vehicleRegistrationProvider.notifier).setHasLockingWheelNut(_hasLockingWheelNut!);
                      ref.read(vehicleRegistrationProvider.notifier).confirmLockingWheelNut();
                      context.pop();
                    }
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOption(AdaptiveColors c, bool value, String label) {
    final isSelected = _hasLockingWheelNut == value;
    return GestureDetector(
      onTap: () => setState(() => _hasLockingWheelNut = value),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: c.card,
          borderRadius: AppSpacing.borderRadiusMd,
          border: Border.all(
            color: isSelected ? AppColors.primary : c.cardBorder,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: AppTypography.titleSmall.copyWith(
                  color: isSelected ? AppColors.primary : c.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
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
          ],
        ),
      ),
    );
  }
}
