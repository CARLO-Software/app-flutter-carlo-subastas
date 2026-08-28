import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/widgets.dart';
import '../widgets/widgets.dart';

class PhotoReadyScreen extends StatelessWidget {
  const PhotoReadyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Scaffold(
      backgroundColor: c.background,
      appBar: AppBar(
        title: const Text('Listo para Comenzar'),
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
                    title: 'Antes de comenzar',
                    subtitle: 'Asegúrate de estar listo para tomar fotos exteriores',
                  ),
                  const PhotoGuide(
                    title: 'Consejos de Fotos',
                    description: 'Sigue estos consejos para mejores resultados:',
                    tips: [
                      'Estaciona en un área abierta con buena luz',
                      'Limpia tu vehículo si es posible',
                      'Retira objetos personales de la vista',
                      'Asegúrate de que el vehículo completo esté en el encuadre',
                      'Toma fotos desde las posiciones indicadas',
                    ],
                  ),
                  AppSpacing.vGapLg,
                  Text(
                    'Lo que fotografiarás:',
                    style: AppTypography.titleMedium,
                  ),
                  AppSpacing.vGapMd,
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
            child: Column(
              children: [
                PrimaryButton(
                  text: 'Estoy Listo',
                  onPressed: () => context.push(AppRoutes.exteriorPhotos),
                ),
                AppSpacing.vGapSm,
                SecondaryButton(
                  text: 'Omitir por Ahora',
                  onPressed: () => context.go(AppRoutes.dashboard),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoListItem(String text, AdaptiveColors c) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        children: [
          Icon(
            Icons.camera_alt_outlined,
            color: c.textSecondary,
            size: 20,
          ),
          AppSpacing.hGapSm,
          Text(
            text,
            style: AppTypography.bodyMedium,
          ),
        ],
      ),
    );
  }
}
