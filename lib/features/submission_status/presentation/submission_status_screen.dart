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

class SubmissionStatusScreen extends ConsumerWidget {
  const SubmissionStatusScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = context.colors;
    final registrationState = ref.watch(vehicleRegistrationProvider);
    final vehicle = registrationState.vehicle;
    final status = registrationState.submissionStatus;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Estado del Envío'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go(AppRoutes.dashboard),
        ),
      ),
      body: SingleChildScrollView(
        padding: AppSpacing.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppSpacing.vGapLg,
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: _getStatusColor(status).withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _getStatusIcon(status),
                size: 56,
                color: _getStatusColor(status),
              ),
            ),
            AppSpacing.vGapLg,
            Text(
              _getStatusTitle(status),
              style: AppTypography.headlineMedium,
              textAlign: TextAlign.center,
            ),
            AppSpacing.vGapSm,
            Text(
              _getStatusDescription(status),
              style: AppTypography.bodyMedium.copyWith(
                color: c.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            AppSpacing.vGapXl,

            StatusBadge(status: status),
            AppSpacing.vGapXl,

            if (vehicle != null) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  color: c.card,
                  borderRadius: AppSpacing.borderRadiusLg,
                  border: Border.all(color: c.cardBorder),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            color: c.surfaceVariant,
                            borderRadius: AppSpacing.borderRadiusSm,
                          ),
                          child: const Icon(
                            Icons.directions_car,
                            size: 32,
                            color: AppColors.primary,
                          ),
                        ),
                        AppSpacing.hGapMd,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${vehicle.brand} ${vehicle.model}',
                                style: AppTypography.titleMedium,
                              ),
                              AppSpacing.vGapXs,
                              Text(
                                '${vehicle.year} | ${vehicle.plate}',
                                style: AppTypography.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              AppSpacing.vGapLg,
            ],

            const SectionHeader(
              title: 'Línea de Tiempo',
            ),
            _buildTimelineItem(
              title: 'Borrador',
              subtitle: 'Información del vehículo guardada',
              isCompleted: true,
              isFirst: true,
              c: c,
            ),
            _buildTimelineItem(
              title: 'Enviado',
              subtitle: 'Enviado para revisión',
              isCompleted: status != SubmissionStatus.draft,
              c: c,
            ),
            _buildTimelineItem(
              title: 'En Revisión',
              subtitle: 'Siendo revisado por nuestro equipo',
              isCompleted: status == SubmissionStatus.underReview ||
                  status == SubmissionStatus.approved ||
                  status == SubmissionStatus.published,
              c: c,
            ),
            _buildTimelineItem(
              title: 'Aprobado',
              subtitle: 'Listo para subasta',
              isCompleted: status == SubmissionStatus.approved ||
                  status == SubmissionStatus.published,
              c: c,
            ),
            _buildTimelineItem(
              title: 'Publicado',
              subtitle: 'En subasta activa',
              isCompleted: status == SubmissionStatus.published,
              isLast: true,
              c: c,
            ),
            AppSpacing.vGapXl,

            if (status == SubmissionStatus.draft)
              PrimaryButton(
                text: 'Continuar Registro',
                onPressed: () => context.go(AppRoutes.dashboard),
              ),
            if (status == SubmissionStatus.submitted)
              const FeedbackBanner(
                type: FeedbackType.info,
                text: 'Te notificaremos cuando tu vehículo haya sido revisado.',
              ),
            AppSpacing.vGapMd,
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineItem({
    required String title,
    required String subtitle,
    required bool isCompleted,
    required AdaptiveColors c,
    bool isFirst = false,
    bool isLast = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isCompleted ? AppColors.success : c.surfaceVariant,
                border: Border.all(
                  color: isCompleted ? AppColors.success : c.border,
                  width: 2,
                ),
              ),
              child: isCompleted
                  ? Icon(
                      Icons.check,
                      size: 14,
                      color: c.textOnPrimary,
                    )
                  : null,
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 40,
                color: isCompleted ? AppColors.success : c.border,
              ),
          ],
        ),
        AppSpacing.hGapMd,
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(bottom: isLast ? 0 : AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.titleSmall.copyWith(
                    color: isCompleted ? AppColors.success : c.textSecondary,
                  ),
                ),
                Text(
                  subtitle,
                  style: AppTypography.bodySmall,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(SubmissionStatus status) {
    switch (status) {
      case SubmissionStatus.draft:
        return AppColors.statusDraft;
      case SubmissionStatus.submitted:
        return AppColors.statusSubmitted;
      case SubmissionStatus.underReview:
        return AppColors.statusUnderReview;
      case SubmissionStatus.approved:
        return AppColors.statusApproved;
      case SubmissionStatus.rejected:
        return AppColors.statusRejected;
      case SubmissionStatus.published:
        return AppColors.statusPublished;
    }
  }

  IconData _getStatusIcon(SubmissionStatus status) {
    switch (status) {
      case SubmissionStatus.draft:
        return Icons.edit_outlined;
      case SubmissionStatus.submitted:
        return Icons.send_outlined;
      case SubmissionStatus.underReview:
        return Icons.hourglass_empty_outlined;
      case SubmissionStatus.approved:
        return Icons.check_circle_outline;
      case SubmissionStatus.rejected:
        return Icons.cancel_outlined;
      case SubmissionStatus.published:
        return Icons.public_outlined;
    }
  }

  String _getStatusTitle(SubmissionStatus status) {
    switch (status) {
      case SubmissionStatus.draft:
        return 'Registro en Progreso';
      case SubmissionStatus.submitted:
        return 'Enviado Exitosamente';
      case SubmissionStatus.underReview:
        return 'En Revisión';
      case SubmissionStatus.approved:
        return 'Aprobado';
      case SubmissionStatus.rejected:
        return 'Requiere Atención';
      case SubmissionStatus.published:
        return 'En Subasta';
    }
  }

  String _getStatusDescription(SubmissionStatus status) {
    switch (status) {
      case SubmissionStatus.draft:
        return 'Completa todos los pasos para enviar tu vehículo a subasta.';
      case SubmissionStatus.submitted:
        return 'Tu vehículo ha sido enviado y está esperando revisión.';
      case SubmissionStatus.underReview:
        return 'Nuestro equipo está revisando tu vehículo actualmente.';
      case SubmissionStatus.approved:
        return '¡Felicidades! Tu vehículo ha sido aprobado para subasta.';
      case SubmissionStatus.rejected:
        return 'Por favor revisa y actualiza la información requerida.';
      case SubmissionStatus.published:
        return 'Tu vehículo está en línea y disponible para ofertas.';
    }
  }
}
