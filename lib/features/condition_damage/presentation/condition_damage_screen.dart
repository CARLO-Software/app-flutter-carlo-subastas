import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/providers/providers.dart';
import '../../../shared/widgets/widgets.dart';

class ConditionDamageScreen extends ConsumerWidget {
  const ConditionDamageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registrationState = ref.watch(vehicleRegistrationProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Condición y Daños'),
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
                    title: 'Inspección del vehículo',
                    subtitle: 'Completa cada sección para reportar el estado del vehículo',
                  ),
                  _ConditionSubItem(
                    title: 'Problemas de pintura',
                    subtitle: 'Marca rayones, descascarados, etc.',
                    icon: Icons.format_paint_outlined,
                    completed: registrationState.paintworkConfirmed,
                    onTap: () => context.push(AppRoutes.paintworkProblems),
                  ),
                  AppSpacing.vGapSm,
                  _ConditionSubItem(
                    title: 'Accesorios rotos o faltantes',
                    subtitle: 'Manijas, luces, molduras',
                    icon: Icons.broken_image_outlined,
                    completed: registrationState.brokenFittingsConfirmed,
                    onTap: () => context.push(AppRoutes.brokenFittings),
                  ),
                  AppSpacing.vGapSm,
                  _ConditionSubItem(
                    title: 'Daño en ruedas',
                    subtitle: 'Revisa el estado de cada rueda',
                    icon: Icons.tire_repair_outlined,
                    completed: registrationState.wheelDamageConfirmed,
                    onTap: () => context.push(AppRoutes.wheelDamage),
                  ),
                  AppSpacing.vGapLg,
                ],
              ),
            ),
          ),
          BottomActionBar(
            child: PrimaryButton(
              text: 'Continuar',
              onPressed: () {
                ref.read(vehicleRegistrationProvider.notifier).confirmConditionDamage();
                context.go(AppRoutes.dashboard);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ConditionSubItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool completed;
  final VoidCallback onTap;

  const _ConditionSubItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.completed,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: c.card,
          borderRadius: AppSpacing.borderRadiusMd,
          border: Border.all(
            color: completed ? AppColors.success : c.cardBorder,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: completed
                    ? AppColors.success.withValues(alpha: 0.1)
                    : c.surfaceVariant,
                borderRadius: AppSpacing.borderRadiusSm,
              ),
              child: Icon(
                icon,
                color: completed ? AppColors.success : c.textSecondary,
                size: 22,
              ),
            ),
            AppSpacing.hGapMd,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTypography.titleSmall),
                  AppSpacing.vGapXxs,
                  Text(
                    subtitle,
                    style: AppTypography.bodySmall.copyWith(color: c.textSecondary),
                  ),
                ],
              ),
            ),
            if (completed)
              Container(
                width: 28,
                height: 28,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.success,
                ),
                child: const Icon(Icons.check, size: 16, color: Colors.white),
              )
            else
              Icon(Icons.chevron_right, color: c.textTertiary),
          ],
        ),
      ),
    );
  }
}
