import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/widgets.dart';

class PhotoIntroductionScreen extends StatelessWidget {
  const PhotoIntroductionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Scaffold(
      backgroundColor: c.background,
      appBar: AppBar(
        title: const Text('Fotos Exteriores'),
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
                    title: 'Prepárate para las fotos',
                    subtitle: 'Buenas fotos ayudan a los compradores y pueden aumentar el valor de subasta.',
                  ),
                  _buildTipCard(
                    context: context,
                    icon: Icons.wb_sunny_outlined,
                    title: 'Buena iluminación',
                    description: 'Estaciona en un área abierta con luz natural',
                  ),
                  AppSpacing.vGapSm,
                  _buildTipCard(
                    context: context,
                    icon: Icons.cleaning_services_outlined,
                    title: 'Limpia tu vehículo',
                    description: 'Un auto limpio se fotografía mejor',
                  ),
                  AppSpacing.vGapSm,
                  _buildTipCard(
                    context: context,
                    icon: Icons.center_focus_strong_outlined,
                    title: 'Mantén firme',
                    description: 'Sostén tu teléfono firme para fotos claras',
                  ),
                  AppSpacing.vGapLg,
                  Text(
                    'Tomarás 8 fotos:',
                    style: AppTypography.titleMedium,
                  ),
                  AppSpacing.vGapSm,
                  _buildPhotoListItem('Vista frontal', c),
                  _buildPhotoListItem('Vista trasera', c),
                  _buildPhotoListItem('Lado izquierdo', c),
                  _buildPhotoListItem('Lado derecho', c),
                  _buildPhotoListItem('Esquina frontal izquierda', c),
                  _buildPhotoListItem('Esquina frontal derecha', c),
                  _buildPhotoListItem('Esquina trasera izquierda', c),
                  _buildPhotoListItem('Esquina trasera derecha', c),
                  AppSpacing.vGapLg,
                ],
              ),
            ),
          ),
          BottomActionBar(
            child: Column(
              children: [
                PrimaryButton(
                  text: 'Comenzar',
                  onPressed: () => context.push(AppRoutes.exteriorPhotos),
                ),
                AppSpacing.vGapSm,
                SecondaryButton(
                  text: 'Omitir por Ahora',
                  onPressed: () => context.pop(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTipCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: context.colors.surfaceVariant,
        borderRadius: AppSpacing.borderRadiusMd,
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: AppSpacing.borderRadiusSm,
            ),
            child: Icon(
              icon,
              color: AppColors.primary,
              size: 20,
            ),
          ),
          AppSpacing.hGapMd,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTypography.titleSmall),
                AppSpacing.vGapXxs,
                Text(description, style: AppTypography.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoListItem(String text, AdaptiveColors c) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: Row(
        children: [
          Icon(Icons.check_circle_outline, color: c.textTertiary, size: 18),
          AppSpacing.hGapSm,
          Text(text, style: AppTypography.bodyMedium),
        ],
      ),
    );
  }
}
