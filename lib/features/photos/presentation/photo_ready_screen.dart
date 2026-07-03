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
        title: const Text('Ready to Start'),
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
                    title: 'Before you begin',
                    subtitle: 'Make sure you\'re ready to take exterior photos',
                  ),
                  const PhotoGuide(
                    title: 'Photo Tips',
                    description: 'Follow these tips for the best results:',
                    tips: [
                      'Park in an open area with good lighting',
                      'Clean your vehicle if possible',
                      'Remove personal items from view',
                      'Make sure the full vehicle is in frame',
                      'Take photos from the positions shown',
                    ],
                  ),
                  AppSpacing.vGapLg,
                  Text(
                    'What you\'ll photograph:',
                    style: AppTypography.titleMedium,
                  ),
                  AppSpacing.vGapMd,
                  _buildPhotoListItem('Front view', c),
                  _buildPhotoListItem('Rear view', c),
                  _buildPhotoListItem('Left side', c),
                  _buildPhotoListItem('Right side', c),
                  _buildPhotoListItem('Front left corner', c),
                  _buildPhotoListItem('Front right corner', c),
                  _buildPhotoListItem('Rear left corner', c),
                  _buildPhotoListItem('Rear right corner', c),
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
                  text: 'I\'m Ready',
                  onPressed: () => context.push(AppRoutes.exteriorPhotos),
                ),
                AppSpacing.vGapSm,
                SecondaryButton(
                  text: 'Skip for Now',
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
