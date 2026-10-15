import 'dart:io';
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

const _headerColor = Color(0xFF6327E2);

class ReviewScreen extends ConsumerWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = context.colors;
    final state = ref.watch(vehicleRegistrationProvider);
    final vehicle = state.vehicle;
    final progress = ref.watch(progressPercentageProvider);

    final firstPhoto = state.exteriorPhotosMap.isNotEmpty
        ? state.exteriorPhotosMap.values.first
        : null;
    final totalPhotos = state.exteriorPhotosMap.length +
        state.interiorPhotosMap.length +
        state.wheelsPhotosMap.length;

    return Scaffold(
      backgroundColor: c.background,
      body: Column(
        children: [
          // Purple header
          Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top,
            ),
            color: _headerColor,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => context.pop(),
                ),
                const Expanded(
                  child: Text(
                    'Confirmar tu perfil',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(width: 48),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Vehicle photo hero
                  Stack(
                    children: [
                      Container(
                        height: 220,
                        width: double.infinity,
                        color: c.surfaceVariant,
                        child: firstPhoto != null
                            ? Image.file(
                                File(firstPhoto),
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => _photoPlaceholder(c),
                              )
                            : _photoPlaceholder(c),
                      ),
                      Positioned(
                        top: 12,
                        right: 12,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
                          ),
                          child: Icon(Icons.edit, size: 20, color: c.textPrimary),
                        ),
                      ),
                      if (totalPhotos > 0)
                        Positioned(
                          bottom: 12,
                          right: 12,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '1 / $totalPhotos',
                              style: const TextStyle(color: Colors.white, fontSize: 13),
                            ),
                          ),
                        ),
                    ],
                  ),

                  // Vehicle info
                  Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (vehicle != null) ...[
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: _headerColor.withValues(alpha: 0.1),
                              border: Border.all(color: _headerColor.withValues(alpha: 0.3)),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              vehicle.plate,
                              style: AppTypography.labelMedium.copyWith(
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                                color: _headerColor,
                              ),
                            ),
                          ),
                          AppSpacing.vGapSm,
                          Text(
                            '${vehicle.brand} ${vehicle.model}',
                            style: AppTypography.headlineSmall.copyWith(fontWeight: FontWeight.w700),
                          ),
                          AppSpacing.vGapXs,
                          Text(
                            [
                              vehicle.year.toString(),
                              '${state.mileage % 1 == 0 ? state.mileage.toInt() : state.mileage} km',
                              if (vehicle.fuelType.isNotEmpty) vehicle.fuelType,
                              if (vehicle.transmission.isNotEmpty) vehicle.transmission,
                            ].join(' · '),
                            style: AppTypography.bodyMedium.copyWith(color: c.textSecondary),
                          ),
                        ],

                        // Personal information
                        AppSpacing.vGapLg,
                        Text('Información personal', style: AppTypography.titleMedium.copyWith(fontWeight: FontWeight.w700)),
                        AppSpacing.vGapSm,
                        _GroupedCard(
                          c: c,
                          children: [
                            _DetailRow(label: 'Nombre', value: 'Propietario', c: c, hasChevron: true),
                            _DetailRow(label: 'Email', value: 'contacto@carlo.pe', c: c, hasChevron: true),
                            _DetailRow(label: 'Teléfono', value: '---', c: c, hasChevron: true),
                          ],
                        ),
                        AppSpacing.vGapSm,
                        Container(
                          padding: const EdgeInsets.all(AppSpacing.md),
                          decoration: BoxDecoration(
                            color: _headerColor.withValues(alpha: 0.05),
                            borderRadius: AppSpacing.borderRadiusMd,
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.info_outline, color: _headerColor, size: 20),
                              AppSpacing.hGapSm,
                              Expanded(
                                child: Text(
                                  'Asegúrate de que tus datos son correctos, los necesitaremos para contactarte.',
                                  style: AppTypography.bodySmall.copyWith(color: c.textSecondary),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Vehicle details
                        AppSpacing.vGapLg,
                        Text('Detalles del vehículo', style: AppTypography.titleMedium.copyWith(fontWeight: FontWeight.w700)),
                        AppSpacing.vGapSm,
                        _GroupedCard(
                          c: c,
                          children: [
                            _DetailRow(label: 'Siniestro o robo', value: 'No', c: c),
                            _DetailRow(label: 'Uso como taxi', value: 'No', c: c),
                            _DetailRow(
                              label: 'Comprobante de compra',
                              value: state.hasProofOfPurchase ? 'Sí' : 'No',
                              c: c,
                              hasChevron: true,
                              valueColor: _headerColor,
                            ),
                            _DetailRow(
                              label: 'Características',
                              value: state.extraFeatures.isEmpty
                                  ? 'Ninguna'
                                  : '${state.extraFeatures.length} característica${state.extraFeatures.length == 1 ? '' : 's'}',
                              c: c,
                              hasChevron: true,
                              valueColor: _headerColor,
                            ),
                            _DetailRow(
                              label: 'Material de asientos',
                              value: _getSeatMaterialText(state.seatMaterial),
                              c: c,
                              hasChevron: true,
                              valueColor: _headerColor,
                            ),
                            _DetailRow(
                              label: 'Número de llaves',
                              value: '${state.numberOfKeys}',
                              c: c,
                              hasChevron: true,
                              valueColor: _headerColor,
                            ),
                            _DetailRow(
                              label: 'Kit de herramientas',
                              value: state.hasToolPack ? 'Sí' : 'No',
                              c: c,
                              hasChevron: true,
                              valueColor: _headerColor,
                            ),
                            _DetailRow(
                              label: 'Tuerca de seguridad',
                              value: state.hasLockingWheelNut ? 'Sí' : 'No',
                              c: c,
                              hasChevron: true,
                              valueColor: _headerColor,
                            ),
                            _DetailRow(
                              label: 'Fumador',
                              value: state.hasBeenSmokedIn ? 'Sí' : 'No',
                              c: c,
                              hasChevron: true,
                              valueColor: _headerColor,
                            ),
                          ],
                        ),

                        // Ownership
                        AppSpacing.vGapLg,
                        Text('Propiedad', style: AppTypography.titleMedium.copyWith(fontWeight: FontWeight.w700)),
                        AppSpacing.vGapSm,
                        _GroupedCard(
                          c: c,
                          children: [
                            _DetailRow(
                              label: 'Placa privada',
                              value: state.hasPrivatePlate ? 'Sí' : 'No',
                              c: c,
                              hasChevron: true,
                              valueColor: _headerColor,
                            ),
                            _DetailRow(
                              label: 'Financiamiento',
                              value: state.hasFinance ? 'Con financiamiento' : 'Sin financiamiento',
                              c: c,
                              hasChevron: true,
                              valueColor: _headerColor,
                            ),
                          ],
                        ),

                        // Condition
                        AppSpacing.vGapLg,
                        Text('Condición', style: AppTypography.titleMedium.copyWith(fontWeight: FontWeight.w700)),
                        AppSpacing.vGapSm,
                        _GroupedCard(
                          c: c,
                          children: [
                            _DetailRow(
                              label: 'Daño en ruedas',
                              value: _getWheelDamageText(state.wheelDamageMap),
                              c: c,
                              hasChevron: true,
                              valueColor: _headerColor,
                            ),
                            _DetailRow(
                              label: 'Estado de neumáticos',
                              value: _getTireConditionText(state.tireCondition),
                              c: c,
                              hasChevron: true,
                              valueColor: _headerColor,
                            ),
                            _DetailRow(
                              label: 'Rayones o marcas',
                              value: state.damages.where((d) => d.type == 'Rayón').isEmpty ? 'Ninguno' : '${state.damages.where((d) => d.type == 'Rayón').length}',
                              c: c,
                              hasChevron: true,
                              valueColor: _headerColor,
                            ),
                            _DetailRow(
                              label: 'Abolladuras',
                              value: state.damages.where((d) => d.type == 'Abolladura').isEmpty ? 'Ninguno' : '${state.damages.where((d) => d.type == 'Abolladura').length}',
                              c: c,
                              hasChevron: true,
                              valueColor: _headerColor,
                            ),
                            _DetailRow(
                              label: 'Problemas de pintura',
                              value: state.paintworkMarks.isEmpty
                                  ? 'Ninguno'
                                  : '${state.paintworkMarks.length} foto${state.paintworkMarks.length == 1 ? '' : 's'}',
                              c: c,
                              hasChevron: true,
                              valueColor: _headerColor,
                            ),
                            _DetailRow(
                              label: 'Accesorios rotos',
                              value: state.hasBrokenFittings
                                  ? '${state.brokenFittingsPhotos.length} foto${state.brokenFittingsPhotos.length == 1 ? '' : 's'}'
                                  : 'Ninguno',
                              c: c,
                              hasChevron: true,
                              valueColor: _headerColor,
                            ),
                            _DetailRow(
                              label: 'Mecánico o eléctrico',
                              value: state.mechanicalIssues.isEmpty ? 'No' : 'Sí',
                              c: c,
                              hasChevron: true,
                              valueColor: _headerColor,
                            ),
                            _DetailRow(
                              label: 'Condición de marcha',
                              value: _getRunningConditionShort(state.runningCondition),
                              c: c,
                              hasChevron: true,
                              valueColor: _headerColor,
                            ),
                          ],
                        ),

                        // Service history
                        AppSpacing.vGapLg,
                        Text('Historial de servicio', style: AppTypography.titleMedium.copyWith(fontWeight: FontWeight.w700)),
                        AppSpacing.vGapSm,
                        _GroupedCard(
                          c: c,
                          children: [
                            _DetailRow(
                              label: 'Tiene historial',
                              value: _getServiceHistoryShort(state.serviceHistoryType),
                              c: c,
                              hasChevron: true,
                              valueColor: _headerColor,
                            ),
                          ],
                        ),
                        AppSpacing.vGapXl,
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom button
          BottomActionBar(
            child: PrimaryButton(
              text: progress == 100 ? 'Enviar para revisión' : 'Continuar ($progress% completado)',
              onPressed: () => _showSubmissionDialog(context, ref),
            ),
          ),
        ],
      ),
    );
  }

  Widget _photoPlaceholder(AdaptiveColors c) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.directions_car, size: 64, color: c.textTertiary),
          AppSpacing.vGapSm,
          Text('Sin fotos', style: TextStyle(color: c.textTertiary)),
        ],
      ),
    );
  }

  void _showSubmissionDialog(BuildContext context, WidgetRef ref) {
    final registrationState = ref.read(vehicleRegistrationProvider);
    ref.read(submissionProvider.notifier).reset();
    ref.read(submissionProvider.notifier).submit(registrationState);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const _SubmissionProgressDialog(),
    );
  }

  String _getSeatMaterialText(String? material) {
    return switch (material) {
      'cloth' => 'Tela',
      'faux_leather' => 'Cuero sintético',
      'half_leather' => 'Medio cuero',
      'half_suede' => 'Medio gamuza',
      'leather' => 'Cuero',
      'suede' => 'Gamuza',
      _ => 'No especificado',
    };
  }

  String _getTireConditionText(String? condition) {
    return switch (condition) {
      'good' => 'Bueno',
      'fair' => 'Aceptable',
      'poor' => 'Necesita reemplazo',
      _ => 'Ninguno',
    };
  }

  String _getWheelDamageText(Map<String, bool> map) {
    final damaged = map.entries.where((e) => e.value).length;
    if (damaged == 0) return 'Ninguno';
    return '$damaged rueda${damaged == 1 ? '' : 's'}';
  }

  String _getRunningConditionShort(RunningCondition? condition) {
    return switch (condition) {
      RunningCondition.startsAndDrivesSmoothly => 'Funciona bien',
      RunningCondition.startsAndDrivesWithIssues => 'Con problemas',
      RunningCondition.doesNotStart => 'No enciende',
      null => 'No especificado',
    };
  }

  String _getServiceHistoryShort(ServiceHistoryType? type) {
    return switch (type) {
      ServiceHistoryType.full => 'Completo',
      ServiceHistoryType.partial => 'Parcial',
      ServiceHistoryType.none => 'No',
      null => 'No',
    };
  }
}

class _GroupedCard extends StatelessWidget {
  final AdaptiveColors c;
  final List<_DetailRow> children;

  const _GroupedCard({required this.c, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: c.card,
        borderRadius: AppSpacing.borderRadiusMd,
        border: Border.all(color: c.cardBorder),
      ),
      child: Column(
        children: [
          for (int i = 0; i < children.length; i++) ...[
            children[i],
            if (i < children.length - 1)
              Divider(height: 1, color: c.border, indent: AppSpacing.md, endIndent: AppSpacing.md),
          ],
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final AdaptiveColors c;
  final bool hasChevron;
  final Color? valueColor;

  const _DetailRow({
    required this.label,
    required this.value,
    required this.c,
    this.hasChevron = false,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: 14),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: AppTypography.bodyMedium.copyWith(color: c.textPrimary),
            ),
          ),
          Text(
            value,
            style: AppTypography.bodyMedium.copyWith(
              color: valueColor ?? c.textPrimary,
              fontWeight: hasChevron ? FontWeight.w500 : FontWeight.normal,
            ),
          ),
          if (hasChevron) ...[
            const SizedBox(width: 4),
            Icon(Icons.chevron_right, size: 20, color: c.textTertiary),
          ],
        ],
      ),
    );
  }
}

class _SubmissionProgressDialog extends ConsumerWidget {
  const _SubmissionProgressDialog();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(submissionProvider);
    final c = context.colors;

    ref.listen<SubmissionProgress>(submissionProvider, (prev, next) {
      if (next.phase == SubmissionPhase.done) {
        ref.read(vehicleRegistrationProvider.notifier).submitForReview();
        Navigator.of(context).pop();
        context.go(AppRoutes.submissionStatus);
      }
    });

    return AlertDialog(
      backgroundColor: c.surface,
      shape: RoundedRectangleBorder(borderRadius: AppSpacing.borderRadiusLg),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (progress.phase == SubmissionPhase.uploadingPhotos) ...[
            const Icon(Icons.cloud_upload_outlined, size: 48, color: AppColors.primary),
            AppSpacing.vGapMd,
            Text('Subiendo fotos...', style: AppTypography.titleMedium),
            AppSpacing.vGapSm,
            Text(
              '${progress.uploadedPhotos}/${progress.totalPhotos} - ${progress.currentPhotoLabel}',
              style: AppTypography.bodySmall.copyWith(color: c.textSecondary),
              textAlign: TextAlign.center,
            ),
            AppSpacing.vGapMd,
            ClipRRect(
              borderRadius: AppSpacing.borderRadiusFull,
              child: LinearProgressIndicator(
                value: progress.totalPhotos > 0
                    ? (progress.uploadedPhotos + progress.currentFileProgress) / progress.totalPhotos
                    : 0,
                backgroundColor: c.border,
                valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                minHeight: 8,
              ),
            ),
          ] else if (progress.phase == SubmissionPhase.submittingData) ...[
            const Icon(Icons.send_outlined, size: 48, color: AppColors.primary),
            AppSpacing.vGapMd,
            Text('Enviando datos del vehículo...', style: AppTypography.titleMedium),
            AppSpacing.vGapMd,
            const LinearProgressIndicator(color: AppColors.primary),
          ] else if (progress.phase == SubmissionPhase.error) ...[
            const Icon(Icons.error_outline, size: 48, color: AppColors.error),
            AppSpacing.vGapMd,
            Text('Error al enviar', style: AppTypography.titleMedium),
            AppSpacing.vGapSm,
            Text(
              progress.errorMessage ?? 'Error inesperado',
              style: AppTypography.bodySmall.copyWith(color: c.textSecondary),
              textAlign: TextAlign.center,
            ),
            AppSpacing.vGapLg,
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancelar'),
                  ),
                ),
                AppSpacing.hGapMd,
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
                    onPressed: () {
                      final state = ref.read(vehicleRegistrationProvider);
                      ref.read(submissionProvider.notifier).submit(state);
                    },
                    child: const Text('Reintentar', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ] else ...[
            const CircularProgressIndicator(color: AppColors.primary),
            AppSpacing.vGapMd,
            Text('Preparando envío...', style: AppTypography.titleMedium),
          ],
        ],
      ),
    );
  }
}
