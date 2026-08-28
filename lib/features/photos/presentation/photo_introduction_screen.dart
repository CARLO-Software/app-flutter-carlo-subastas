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
        title: const Text('Fotos'),
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppSpacing.vGapLg,
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.camera_alt_outlined,
                      size: 56,
                      color: AppColors.primary,
                    ),
                  ),
                  AppSpacing.vGapLg,
                  Text(
                    'Es hora de tomar fotos',
                    style: AppTypography.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                  AppSpacing.vGapSm,
                  Text(
                    'Buenas fotos ayudan a los compradores a ver tu vehículo claramente y pueden aumentar el valor de subasta.',
                    style: AppTypography.bodyMedium.copyWith(
                      color: c.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  AppSpacing.vGapXl,
                  _buildTipCard(
                    context: context,
                    icon: Icons.wb_sunny_outlined,
                    title: 'Buena iluminación',
                    description: 'Toma fotos con luz natural o en áreas bien iluminadas',
                  ),
                  AppSpacing.vGapMd,
                  _buildTipCard(
                    context: context,
                    icon: Icons.cleaning_services_outlined,
                    title: 'Limpia tu vehículo',
                    description: 'Un auto limpio se fotografía mejor',
                  ),
                  AppSpacing.vGapMd,
                  _buildTipCard(
                    context: context,
                    icon: Icons.center_focus_strong_outlined,
                    title: 'Mantén firme',
                    description: 'Sostén tu teléfono firme para fotos claras',
                  ),
                  AppSpacing.vGapMd,
                  _buildTipCard(
                    context: context,
                    icon: Icons.panorama_horizontal_outlined,
                    title: 'Captura todos los ángulos',
                    description: 'Te guiaremos en cada toma',
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
              text: 'Comenzar',
              onPressed: () => context.push(AppRoutes.photoReady),
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
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: AppSpacing.borderRadiusSm,
            ),
            child: Icon(
              icon,
              color: AppColors.primary,
              size: 24,
            ),
          ),
          AppSpacing.hGapMd,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.titleSmall,
                ),
                AppSpacing.vGapXxs,
                Text(
                  description,
                  style: AppTypography.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
