import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../home/providers/registered_vehicles_provider.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../models/models.dart';
import '../../../shared/providers/providers.dart';
import '../../../shared/widgets/widgets.dart';

const _headerColor = Color(0xFF6327E2);

class SaleTypeScreen extends ConsumerStatefulWidget {
  const SaleTypeScreen({super.key});

  @override
  ConsumerState<SaleTypeScreen> createState() => _SaleTypeScreenState();
}

class _SaleTypeScreenState extends ConsumerState<SaleTypeScreen> {
  SaleType? _selected;

  @override
  void initState() {
    super.initState();
    _selected = ref.read(vehicleRegistrationProvider).saleType;
  }

  void _showDetail({
    required String title,
    required IconData icon,
    required List<String> details,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: context.colors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.4,
        maxChildSize: 0.85,
        expand: false,
        builder: (_, scrollController) => Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: ListView(
            controller: scrollController,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: context.colors.border,
                    borderRadius: AppSpacing.borderRadiusFull,
                  ),
                ),
              ),
              AppSpacing.vGapLg,
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: _headerColor.withValues(alpha: 0.1),
                      borderRadius: AppSpacing.borderRadiusMd,
                    ),
                    child: Icon(icon, color: _headerColor, size: 24),
                  ),
                  AppSpacing.hGapMd,
                  Text(
                    title,
                    style: AppTypography.headlineSmall.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              AppSpacing.vGapLg,
              ...details.map((detail) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.md),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 6),
                      child: Icon(Icons.check_circle, color: _headerColor, size: 18),
                    ),
                    AppSpacing.hGapSm,
                    Expanded(
                      child: Text(
                        detail,
                        style: AppTypography.bodyMedium.copyWith(
                          color: context.colors.textSecondary,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
              AppSpacing.vGapLg,
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    final type = title == 'Venta Inmediata'
                        ? SaleType.ecommerce
                        : title == 'Subasta'
                            ? SaleType.auction
                            : SaleType.consignment;
                    setState(() => _selected = type);
                    Navigator.of(ctx).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _headerColor,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: AppSpacing.borderRadiusMd),
                  ),
                  child: Text('Seleccionar $title', style: AppTypography.button.copyWith(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onConfirm() {
    if (_selected == null) return;
    ref.read(vehicleRegistrationProvider.notifier).setSaleType(_selected!);
    _showSubmissionDialog();
  }

  void _showSubmissionDialog() {
    final registrationState = ref.read(vehicleRegistrationProvider);
    ref.read(submissionProvider.notifier).reset();
    ref.read(submissionProvider.notifier).submit(registrationState);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const _SubmissionProgressDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;

    return Scaffold(
      backgroundColor: c.background,
      body: Column(
        children: [
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
                    'Tipo de venta',
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
              padding: AppSpacing.screenPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppSpacing.vGapLg,
                  Text(
                    '¿Cómo quieres vender\ntu vehículo?',
                    style: AppTypography.headlineSmall.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  AppSpacing.vGapSm,
                  Text(
                    'Selecciona la modalidad de venta que prefieras. Cada una tiene un proceso diferente.',
                    style: AppTypography.bodyMedium.copyWith(
                      color: c.textSecondary,
                    ),
                  ),
                  AppSpacing.vGapXl,
                  _SaleTypeCard(
                    icon: Icons.bolt_outlined,
                    title: 'Venta Inmediata',
                    subtitle: 'Pago el mismo día',
                    description: 'Hacemos la inspección de tu auto y si todo está ok, gestionamos el abono en ese instante. La forma más rápida de vender.',
                    selected: _selected == SaleType.ecommerce,
                    onTap: () => _showDetail(
                      title: 'Venta Inmediata',
                      icon: Icons.bolt_outlined,
                      details: [
                        'Carlo compra tu vehículo directamente después de la inspección.',
                        'El pago se gestiona el mismo día que se aprueba la inspección.',
                        'No necesitas esperar compradores ni negociar con terceros.',
                        'Si tu auto aún tiene deuda bancaria, se descuenta del monto de la propuesta.',
                        'La inspección es 100% gratuita, ya sea en tu domicilio o en nuestras instalaciones.',
                      ],
                    ),
                    c: c,
                  ),
                  AppSpacing.vGapMd,
                  _SaleTypeCard(
                    icon: Icons.gavel_outlined,
                    title: 'Subasta',
                    subtitle: 'Venta al mejor postor',
                    description: 'Tu vehículo entra en subasta para dealers verificados. El pago es inmediato al aceptarse la mejor oferta.',
                    selected: _selected == SaleType.auction,
                    onTap: () => _showDetail(
                      title: 'Subasta',
                      icon: Icons.gavel_outlined,
                      details: [
                        'Tu auto se publica en la plataforma de subastas de Carlo para dealers verificados.',
                        'Los dealers compiten con pujas para ofrecer el mejor precio por tu vehículo.',
                        'Todas las pujas son vinculantes — una vez aceptada la oferta, la venta es segura.',
                        'El pago es inmediato una vez que se acepta la mejor oferta.',
                        'Carlo cobra una tarifa administrativa por vehículo vendido.',
                        'Tienes hasta 5 días para aceptar la propuesta después de la inspección.',
                      ],
                    ),
                    c: c,
                  ),
                  AppSpacing.vGapMd,
                  _SaleTypeCard(
                    icon: Icons.handshake_outlined,
                    title: 'Consignación',
                    subtitle: 'Mayor rentabilidad',
                    description: 'Si buscas mayor rentabilidad, esta es la mejor alternativa. Carlo se encarga de todo y el pago se realiza en 30-45 días.',
                    selected: _selected == SaleType.consignment,
                    onTap: () => _showDetail(
                      title: 'Consignación',
                      icon: Icons.handshake_outlined,
                      details: [
                        'Si buscas mayor rentabilidad por tu auto, esta es la mejor alternativa.',
                        'Tu vehículo se queda en las instalaciones de Carlo y se firma un documento de consignación.',
                        'Carlo se encarga de todo el proceso de venta — tú no tienes que hacer nada más.',
                        'Una vez vendido el auto (estimado 30-45 días), se te deposita el valor acordado.',
                        'Tú defines el precio esperado junto con Carlo.',
                        'La inspección es 100% gratuita.',
                      ],
                    ),
                    c: c,
                  ),
                  AppSpacing.vGapXl,
                ],
              ),
            ),
          ),
          BottomActionBar(
            child: PrimaryButton(
              text: 'Enviar para revisión',
              onPressed: _selected != null ? _onConfirm : null,
            ),
          ),
        ],
      ),
    );
  }
}

class _SaleTypeCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String description;
  final bool selected;
  final VoidCallback onTap;
  final AdaptiveColors c;

  const _SaleTypeCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.selected,
    required this.onTap,
    required this.c,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: c.card,
          borderRadius: AppSpacing.borderRadiusLg,
          border: Border.all(
            color: selected ? _headerColor : c.cardBorder,
            width: selected ? 2 : 1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: selected
                    ? _headerColor.withValues(alpha: 0.1)
                    : c.surfaceVariant,
                borderRadius: AppSpacing.borderRadiusMd,
              ),
              child: Icon(
                icon,
                color: selected ? _headerColor : c.textSecondary,
                size: 24,
              ),
            ),
            AppSpacing.hGapMd,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: AppTypography.titleMedium.copyWith(
                          fontWeight: FontWeight.w700,
                          color: selected ? _headerColor : null,
                        ),
                      ),
                      AppSpacing.hGapSm,
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: selected
                              ? _headerColor.withValues(alpha: 0.1)
                              : c.surfaceVariant,
                          borderRadius: AppSpacing.borderRadiusFull,
                        ),
                        child: Text(
                          subtitle,
                          style: AppTypography.labelSmall.copyWith(
                            color: selected ? _headerColor : c.textSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  AppSpacing.vGapXs,
                  Text(
                    description,
                    style: AppTypography.bodySmall.copyWith(
                      color: c.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selected ? _headerColor : Colors.transparent,
                border: Border.all(
                  color: selected ? _headerColor : c.border,
                  width: 2,
                ),
              ),
              child: selected
                  ? const Icon(Icons.check, size: 16, color: Colors.white)
                  : null,
            ),
          ],
        ),
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
        ref.read(registeredVehiclesProvider.notifier).refresh();
        Navigator.of(context).pop();
        context.go(AppRoutes.home);
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
