import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../models/models.dart';
import '../../../shared/providers/providers.dart';
import '../../../shared/widgets/widgets.dart';

class ReviewScreen extends ConsumerWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = context.colors;
    final registrationState = ref.watch(vehicleRegistrationProvider);
    final vehicle = registrationState.vehicle;
    final progress = ref.watch(progressPercentageProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Revisión'),
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
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    decoration: BoxDecoration(
                      color: progress == 100
                          ? c.successLight
                          : c.warningLight,
                      borderRadius: AppSpacing.borderRadiusLg,
                    ),
                    child: Column(
                      children: [
                        Icon(
                          progress == 100 ? Icons.check_circle : Icons.pending,
                          size: 48,
                          color: progress == 100 ? AppColors.success : AppColors.warning,
                        ),
                        AppSpacing.vGapSm,
                        Text(
                          progress == 100 ? 'Listo para Enviar' : 'Casi Listo',
                          style: AppTypography.titleLarge.copyWith(
                            color: progress == 100 ? AppColors.success : AppColors.warning,
                          ),
                        ),
                        AppSpacing.vGapXs,
                        Text(
                          progress == 100
                              ? '¡Todos los pasos completados!'
                              : '$progress% completado - finaliza los pasos restantes',
                          style: AppTypography.bodyMedium.copyWith(
                            color: c.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  AppSpacing.vGapLg,

                  if (vehicle != null) ...[
                    _buildSectionCard(
                      title: 'Información del Vehículo',
                      icon: Icons.directions_car_outlined,
                      isComplete: registrationState.vehicleDetailsConfirmed,
                      c: c,
                      children: [
                        _buildDetailRow('Vehículo', '${vehicle.brand} ${vehicle.model}', c),
                        _buildDetailRow('Año', vehicle.year.toString(), c),
                        _buildDetailRow('Placa', vehicle.plate, c),
                        _buildDetailRow('Kilometraje', '${registrationState.mileage} km', c),
                      ],
                    ),
                    AppSpacing.vGapMd,
                  ],

                  _buildSectionCard(
                    title: 'Características Extra',
                    icon: Icons.star_outline,
                    isComplete: registrationState.extraFeaturesConfirmed,
                    c: c,
                    children: [
                      Text(
                        registrationState.extraFeatures.isEmpty
                            ? 'Sin características extra'
                            : registrationState.extraFeatures.join(', '),
                        style: AppTypography.bodyMedium,
                      ),
                    ],
                  ),
                  AppSpacing.vGapMd,

                  _buildSectionCard(
                    title: 'Llaves',
                    icon: Icons.key,
                    isComplete: registrationState.keysConfirmed,
                    c: c,
                    children: [
                      Text(
                        '${registrationState.numberOfKeys} llave(s)',
                        style: AppTypography.bodyMedium,
                      ),
                    ],
                  ),
                  AppSpacing.vGapMd,

                  _buildSectionCard(
                    title: 'Financiamiento',
                    icon: Icons.credit_card,
                    isComplete: registrationState.financeConfirmed,
                    c: c,
                    children: [
                      Text(
                        registrationState.hasFinance
                            ? 'Tiene financiamiento pendiente'
                            : 'Sin financiamiento pendiente',
                        style: AppTypography.bodyMedium,
                      ),
                    ],
                  ),
                  AppSpacing.vGapMd,

                  _buildSectionCard(
                    title: 'Estado de Funcionamiento',
                    icon: Icons.engineering_outlined,
                    isComplete: registrationState.runningConditionConfirmed,
                    c: c,
                    children: [
                      Text(
                        _getRunningConditionText(registrationState.runningCondition),
                        style: AppTypography.bodyMedium,
                      ),
                    ],
                  ),
                  AppSpacing.vGapMd,

                  _buildSectionCard(
                    title: 'Problemas Mecánicos',
                    icon: Icons.build_outlined,
                    isComplete: registrationState.mechanicalIssuesConfirmed,
                    c: c,
                    children: [
                      Text(
                        registrationState.mechanicalIssues.isEmpty
                            ? 'Sin problemas mecánicos'
                            : registrationState.mechanicalIssues.join(', '),
                        style: AppTypography.bodyMedium,
                      ),
                    ],
                  ),
                  AppSpacing.vGapMd,

                  _buildSectionCard(
                    title: 'Fotos Exteriores',
                    icon: Icons.camera_alt_outlined,
                    isComplete: registrationState.photosConfirmed,
                    c: c,
                    children: [
                      Text(
                        '${registrationState.exteriorPhotosMap.length} fotos exteriores',
                        style: AppTypography.bodyMedium,
                      ),
                    ],
                  ),
                  AppSpacing.vGapMd,

                  _buildSectionCard(
                    title: 'Fotos Interiores',
                    icon: Icons.chair_outlined,
                    isComplete: registrationState.interiorPhotosConfirmed,
                    c: c,
                    children: [
                      Text(
                        '${registrationState.interiorPhotosMap.length} fotos interiores',
                        style: AppTypography.bodyMedium,
                      ),
                    ],
                  ),
                  AppSpacing.vGapMd,

                  _buildSectionCard(
                    title: 'Condición y Daños',
                    icon: Icons.report_problem_outlined,
                    isComplete: registrationState.conditionDamageConfirmed,
                    c: c,
                    children: [
                      Text(
                        registrationState.damages.isEmpty
                            ? 'Sin daños reportados'
                            : '${registrationState.damages.length} daño(s) reportado(s)',
                        style: AppTypography.bodyMedium,
                      ),
                    ],
                  ),
                  AppSpacing.vGapMd,

                  _buildSectionCard(
                    title: 'Historial de Servicio',
                    icon: Icons.history_outlined,
                    isComplete: registrationState.serviceHistoryConfirmed,
                    c: c,
                    children: [
                      Text(
                        _getServiceHistoryText(registrationState.serviceHistoryType),
                        style: AppTypography.bodyMedium,
                      ),
                    ],
                  ),
                  AppSpacing.vGapLg,
                ],
              ),
            ),
          ),
          Container(
            padding: AppSpacing.screenPadding,
            decoration: BoxDecoration(
              color: c.surface,
              boxShadow: [
                BoxShadow(
                  color: c.shadow,
                  blurRadius: 8,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: PrimaryButton(
              text: 'Enviar para Revisión',
              isEnabled: progress == 100,
              onPressed: progress == 100
                  ? () {
                      ref.read(vehicleRegistrationProvider.notifier).submitForReview();
                      context.go(AppRoutes.submissionStatus);
                    }
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required bool isComplete,
    required AdaptiveColors c,
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: c.card,
        borderRadius: AppSpacing.borderRadiusMd,
        border: Border.all(
          color: isComplete ? AppColors.success : c.border,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: isComplete ? AppColors.success : c.textSecondary,
                size: 20,
              ),
              AppSpacing.hGapSm,
              Text(
                title,
                style: AppTypography.titleSmall.copyWith(
                  color: isComplete ? AppColors.success : c.textPrimary,
                ),
              ),
              const Spacer(),
              if (isComplete)
                const Icon(
                  Icons.check_circle,
                  color: AppColors.success,
                  size: 20,
                )
              else
                Icon(
                  Icons.pending,
                  color: c.textTertiary,
                  size: 20,
                ),
            ],
          ),
          AppSpacing.vGapSm,
          ...children,
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, AdaptiveColors c) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.xs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTypography.bodySmall.copyWith(
              color: c.textSecondary,
            ),
          ),
          Text(
            value,
            style: AppTypography.bodyMedium,
          ),
        ],
      ),
    );
  }

  String _getRunningConditionText(RunningCondition? condition) {
    switch (condition) {
      case RunningCondition.startsAndDrivesSmoothly:
        return 'Enciende y funciona correctamente';
      case RunningCondition.startsAndDrivesWithIssues:
        return 'Enciende y funciona con problemas';
      case RunningCondition.doesNotStart:
        return 'No enciende';
      case null:
        return 'No especificado';
    }
  }

  String _getServiceHistoryText(ServiceHistoryType? type) {
    switch (type) {
      case ServiceHistoryType.full:
        return 'Historial de servicio completo';
      case ServiceHistoryType.partial:
        return 'Historial de servicio parcial';
      case ServiceHistoryType.none:
        return 'Sin historial de servicio';
      case null:
        return 'No especificado';
    }
  }
}
