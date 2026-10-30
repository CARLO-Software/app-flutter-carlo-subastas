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
                    icon: Icons.storefront_outlined,
                    title: 'Ecommerce',
                    subtitle: 'Venta directa',
                    description: 'Carlo compra tu vehículo y lo vende directamente. Recibes el pago de forma rápida y segura.',
                    selected: _selected == SaleType.ecommerce,
                    onTap: () => setState(() => _selected = SaleType.ecommerce),
                    c: c,
                  ),
                  AppSpacing.vGapMd,
                  _SaleTypeCard(
                    icon: Icons.gavel_outlined,
                    title: 'Subasta',
                    subtitle: 'Venta al mejor postor',
                    description: 'Tu vehículo entra en subasta para dealers verificados. Puedes obtener un mejor precio por la competencia entre compradores.',
                    selected: _selected == SaleType.auction,
                    onTap: () => setState(() => _selected = SaleType.auction),
                    c: c,
                  ),
                  AppSpacing.vGapMd,
                  _SaleTypeCard(
                    icon: Icons.handshake_outlined,
                    title: 'Consigna',
                    subtitle: 'Carlo vende por ti',
                    description: 'Dejás tu vehículo en consigna y Carlo se encarga de venderlo. Tú defines el precio esperado y Carlo cobra una comisión.',
                    selected: _selected == SaleType.consignment,
                    onTap: () => setState(() => _selected = SaleType.consignment),
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
