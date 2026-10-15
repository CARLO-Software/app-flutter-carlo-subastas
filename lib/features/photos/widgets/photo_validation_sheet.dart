import 'dart:io';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';

class PhotoValidationSheet extends StatelessWidget {
  final String takenPhotoPath;
  final String title;
  final String description;
  final String? goodExampleAsset;
  final VoidCallback onRetake;
  final VoidCallback onAccept;

  const PhotoValidationSheet({
    super.key,
    required this.takenPhotoPath,
    required this.title,
    required this.description,
    this.goodExampleAsset,
    required this.onRetake,
    required this.onAccept,
  });

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.15),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: c.background,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(AppSpacing.radiusXl),
              topRight: Radius.circular(AppSpacing.radiusXl),
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(bottom: bottomPadding + AppSpacing.lg),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Close
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: AppSpacing.md, right: AppSpacing.md),
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Text(
                          'Cerrar',
                          style: AppTypography.bodyMedium.copyWith(color: c.textSecondary),
                        ),
                      ),
                    ),
                  ),

                  // Two example photos side by side
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Bad example (the photo just taken)
                        Expanded(
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: AppSpacing.borderRadiusMd,
                                child: AspectRatio(
                                  aspectRatio: 1.2,
                                  child: Image.file(
                                    File(takenPhotoPath),
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => Container(
                                      color: c.surfaceVariant,
                                      child: Icon(Icons.image, size: 48, color: c.textTertiary),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                width: 28,
                                height: 28,
                                decoration: const BoxDecoration(
                                  color: AppColors.error,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.close, size: 18, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        AppSpacing.hGapMd,
                        // Good example (template or placeholder)
                        Expanded(
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: AppSpacing.borderRadiusMd,
                                child: AspectRatio(
                                  aspectRatio: 1.2,
                                  child: goodExampleAsset != null
                                      ? Image.asset(
                                          goodExampleAsset!,
                                          fit: BoxFit.cover,
                                          errorBuilder: (_, __, ___) => _goodPlaceholder(c),
                                        )
                                      : _goodPlaceholder(c),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                width: 28,
                                height: 28,
                                decoration: const BoxDecoration(
                                  color: AppColors.success,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.check, size: 18, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  AppSpacing.vGapLg,

                  // Title
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                    child: Text(
                      title,
                      style: AppTypography.headlineSmall.copyWith(fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  AppSpacing.vGapSm,

                  // Description
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                    child: Text(
                      description,
                      style: AppTypography.bodyMedium.copyWith(color: c.textSecondary),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  AppSpacing.vGapXl,

                  // Retake button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                    child: SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          onRetake();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF292929),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: AppSpacing.borderRadiusMd),
                        ),
                        child: Text('Retomar', style: AppTypography.button.copyWith(color: Colors.white)),
                      ),
                    ),
                  ),

                  AppSpacing.vGapMd,

                  // Accept link
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      onAccept();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                      child: Text(
                        'Mi foto es correcta',
                        style: AppTypography.titleSmall.copyWith(
                          color: c.textPrimary,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _goodPlaceholder(AdaptiveColors c) {
    return Container(
      color: c.surfaceVariant,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.check_circle_outline, size: 48, color: AppColors.success),
          const SizedBox(height: 8),
          Text('Ejemplo correcto', style: TextStyle(color: c.textSecondary, fontSize: 12)),
        ],
      ),
    );
  }
}
