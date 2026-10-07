import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/providers/providers.dart';

class VehicleInfoHubScreen extends ConsumerWidget {
  const VehicleInfoHubScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = context.colors;
    final state = ref.watch(vehicleRegistrationProvider);

    final steps = [
      _SubStep(
        title: 'Detalles del vehículo',
        subtitle: 'Marca, modelo, año, kilometraje',
        icon: Icons.directions_car_outlined,
        completed: state.vehicleDetailsConfirmed,
        route: AppRoutes.vehicleDetails,
      ),
      _SubStep(
        title: 'Características extra',
        subtitle: 'GPS, bluetooth, techo solar, etc.',
        icon: Icons.star_outline,
        completed: state.extraFeaturesConfirmed,
        route: AppRoutes.extraFeatures,
      ),
      _SubStep(
        title: 'Llaves',
        subtitle: 'Cantidad de llaves disponibles',
        icon: Icons.key_outlined,
        completed: state.keysConfirmed,
        route: AppRoutes.keys,
      ),
      _SubStep(
        title: 'Financiamiento',
        subtitle: 'Estado de deuda o financiamiento',
        icon: Icons.account_balance_outlined,
        completed: state.financeConfirmed,
        route: AppRoutes.finance,
      ),
      _SubStep(
        title: 'Condición de marcha',
        subtitle: '¿El vehículo enciende y se mueve?',
        icon: Icons.speed_outlined,
        completed: state.runningConditionConfirmed,
        route: AppRoutes.runningCondition,
      ),
      _SubStep(
        title: 'Problemas mecánicos',
        subtitle: 'Fallas o problemas conocidos',
        icon: Icons.build_outlined,
        completed: state.mechanicalIssuesConfirmed,
        route: AppRoutes.mechanicalIssues,
      ),
    ];

    final completedCount = steps.where((s) => s.completed).length;

    return Scaffold(
      backgroundColor: c.background,
      appBar: AppBar(
        title: const Text('Información del vehículo'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            color: c.surfaceVariant,
            child: Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: AppSpacing.borderRadiusFull,
                    child: LinearProgressIndicator(
                      value: completedCount / steps.length,
                      backgroundColor: c.border,
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(AppColors.success),
                      minHeight: 8,
                    ),
                  ),
                ),
                AppSpacing.hGapMd,
                Text(
                  '$completedCount/${steps.length}',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: c.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: AppSpacing.screenPadding,
              itemCount: steps.length,
              separatorBuilder: (_, __) => AppSpacing.vGapSm,
              itemBuilder: (context, index) {
                final step = steps[index];
                return GestureDetector(
                  onTap: () => context.push(step.route),
                  child: Container(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: c.card,
                      borderRadius: AppSpacing.borderRadiusMd,
                      border: Border.all(
                        color:
                            step.completed ? AppColors.success : c.cardBorder,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: step.completed
                                ? AppColors.success.withValues(alpha: 0.1)
                                : c.surfaceVariant,
                            borderRadius: AppSpacing.borderRadiusSm,
                          ),
                          child: Icon(
                            step.icon,
                            color: step.completed
                                ? AppColors.success
                                : c.textSecondary,
                            size: 22,
                          ),
                        ),
                        AppSpacing.hGapMd,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(step.title,
                                  style: AppTypography.titleSmall),
                              AppSpacing.vGapXxs,
                              Text(
                                step.subtitle,
                                style: AppTypography.bodySmall.copyWith(
                                  color: c.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        AppSpacing.hGapSm,
                        if (step.completed)
                          Container(
                            width: 28,
                            height: 28,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.success,
                            ),
                            child: const Icon(Icons.check,
                                size: 16, color: Colors.white),
                          )
                        else
                          Icon(Icons.chevron_right, color: c.textTertiary),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SubStep {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool completed;
  final String route;

  const _SubStep({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.completed,
    required this.route,
  });
}
