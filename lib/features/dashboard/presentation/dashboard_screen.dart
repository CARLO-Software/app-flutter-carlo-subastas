import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../models/models.dart';
import '../../../shared/providers/providers.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = context.colors;
    final state = ref.watch(vehicleRegistrationProvider);
    final vehicle = state.vehicle;
    final progress = ref.watch(dashboardProgressProvider);
    final formatter = NumberFormat('#,###', 'es_PE');

    final steps = _buildSteps(state);
    final nextStep = steps.firstWhere(
      (s) => !s.completed,
      orElse: () => steps.last,
    );

    return Scaffold(
      backgroundColor: c.background,
      body: Column(
        children: [
          // Header morado
          Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + AppSpacing.md,
              left: AppSpacing.md,
              right: AppSpacing.md,
              bottom: AppSpacing.lg,
            ),
            decoration: const BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(AppSpacing.radiusXl),
                bottomRight: Radius.circular(AppSpacing.radiusXl),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Valor estimado',
                      style: AppTypography.bodySmall.copyWith(
                        color: Colors.white.withValues(alpha: 0.8),
                      ),
                    ),
                    AppSpacing.vGapXs,
                    Text(
                      'S/ ${formatter.format(vehicle?.estimatedPrice.round() ?? 0)}',
                      style: AppTypography.headlineMedium.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      vehicle?.plate ?? '',
                      style: AppTypography.titleSmall.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    AppSpacing.vGapXs,
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.person_outline,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Body
          Expanded(
            child: SingleChildScrollView(
              padding: AppSpacing.screenPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pon tu vehículo a la venta',
                    style: AppTypography.headlineSmall,
                  ),
                  AppSpacing.vGapLg,

                  // Step cards
                  ...steps.map((step) => Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                        child: _StepCard(step: step),
                      )),

                  AppSpacing.vGapLg,

                  // Help link
                  Center(
                    child: GestureDetector(
                      onTap: () => _openHelp(),
                      child: Text(
                        '¿Necesitas ayuda?',
                        style: AppTypography.bodyMedium.copyWith(
                          color: AppColors.primary,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                  AppSpacing.vGapXl,
                ],
              ),
            ),
          ),

          // Bottom progress bar
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: c.card,
              border: Border(top: BorderSide(color: c.border)),
            ),
            child: SafeArea(
              top: false,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: AppSpacing.borderRadiusFull,
                    child: LinearProgressIndicator(
                      value: progress / 100,
                      backgroundColor: c.surfaceVariant,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                          AppColors.primary),
                      minHeight: 6,
                    ),
                  ),
                  AppSpacing.vGapMd,
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$progress% completado',
                              style: AppTypography.titleSmall,
                            ),
                            AppSpacing.vGapXxs,
                            Text(
                              'Siguiente: ${nextStep.title}',
                              style: AppTypography.caption.copyWith(
                                color: c.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => context.push(nextStep.route),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF292929),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          minimumSize: Size.zero,
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.lg,
                            vertical: AppSpacing.sm,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: AppSpacing.borderRadiusMd,
                          ),
                        ),
                        child: Text('Next Step',
                            style: AppTypography.buttonSmall
                                .copyWith(color: Colors.white)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<_DashboardStep> _buildSteps(VehicleRegistrationState state) {
    final infoCompleted = state.vehicleDetailsConfirmed &&
        state.extraFeaturesConfirmed &&
        state.keysConfirmed &&
        state.financeConfirmed &&
        state.runningConditionConfirmed &&
        state.mechanicalIssuesConfirmed;

    final photosCompleted =
        state.photosConfirmed && state.interiorPhotosConfirmed;

    return [
      _DashboardStep(
        title: 'Información del vehículo',
        description: 'Déjanos conocer las características de tu auto',
        completed: infoCompleted,
        route: AppRoutes.vehicleDetails,
      ),
      _DashboardStep(
        title: 'Fotos',
        description: photosCompleted ? 'Completado' : 'Toma fotos de tu vehículo',
        completed: photosCompleted,
        route: AppRoutes.photoIntroduction,
      ),
      _DashboardStep(
        title: 'Daño y condición',
        description: 'Reporta el estado actual de tu auto',
        completed: state.conditionDamageConfirmed,
        route: AppRoutes.conditionDamage,
      ),
      _DashboardStep(
        title: 'Historial de mantenimiento',
        description: 'Registros de servicio y mantenimiento',
        completed: state.serviceHistoryConfirmed,
        route: AppRoutes.serviceHistory,
      ),
    ];
  }

  void _openHelp() {
    // TODO: abrir https://carlo.pe con url_launcher
  }
}

class _DashboardStep {
  final String title;
  final String description;
  final bool completed;
  final String route;

  const _DashboardStep({
    required this.title,
    required this.description,
    required this.completed,
    required this.route,
  });
}

class _StepCard extends StatelessWidget {
  final _DashboardStep step;

  const _StepCard({required this.step});

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return GestureDetector(
      onTap: () => context.push(step.route),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: c.card,
          borderRadius: AppSpacing.borderRadiusMd,
          border: Border.all(
            color: step.completed ? AppColors.success : c.cardBorder,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(step.title, style: AppTypography.titleMedium),
                  AppSpacing.vGapXs,
                  Text(
                    step.description,
                    style: AppTypography.bodySmall.copyWith(
                      color: c.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            AppSpacing.hGapMd,
            if (step.completed)
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.success,
                ),
                child: const Icon(Icons.check, size: 18, color: Colors.white),
              )
            else
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF292929),
                ),
                child: const Icon(Icons.arrow_forward,
                    size: 18, color: Colors.white),
              ),
          ],
        ),
      ),
    );
  }
}
