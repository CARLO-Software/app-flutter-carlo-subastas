import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/providers/providers.dart';

const _maxPhotos = 4;

class BonusPhotosScreen extends ConsumerStatefulWidget {
  const BonusPhotosScreen({super.key});

  @override
  ConsumerState<BonusPhotosScreen> createState() => _BonusPhotosScreenState();
}

class _BonusPhotosScreenState extends ConsumerState<BonusPhotosScreen> {
  final _picker = ImagePicker();

  Future<void> _addPhoto() async {
    final photos = ref.read(vehicleRegistrationProvider).bonusPhotos;
    if (photos.length >= _maxPhotos) return;
    final image = await _picker.pickImage(source: ImageSource.camera, imageQuality: 85);
    if (image == null || !mounted) return;
    ref.read(vehicleRegistrationProvider.notifier).addBonusPhoto(image.path);
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final photos = ref.watch(vehicleRegistrationProvider.select((s) => s.bonusPhotos));

    return Scaffold(
      backgroundColor: c.background,
      appBar: AppBar(
        title: const Text('Fotos adicionales'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Agrega más fotos',
                    style: AppTypography.titleLarge.copyWith(
                      color: c.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  AppSpacing.vGapXs,
                  Text(
                    'Muestra cualquier cosa extra que pueda ayudar a atraer ofertas, como mejoras y características destacadas.',
                    style: AppTypography.bodyMedium.copyWith(
                      color: c.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  AppSpacing.vGapLg,
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: AppSpacing.sm,
                      mainAxisSpacing: AppSpacing.sm,
                    ),
                    itemCount: _maxPhotos,
                    itemBuilder: (context, index) {
                      final hasPhoto = index < photos.length;
                      final isLast = index == _maxPhotos - 1;

                      if (hasPhoto) {
                        final bgColor = isLast
                            ? const Color(0xFFFCE1DB)
                            : const Color(0xFFD8FDDD);
                        final iconColor = isLast
                            ? const Color(0xFF904D4A)
                            : const Color(0xFF81B78C);
                        final icon = isLast ? Icons.close : Icons.check;

                        return Stack(
                          children: [
                            ClipRRect(
                              borderRadius: AppSpacing.borderRadiusMd,
                              child: Image.file(
                                File(photos[index]),
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: 4,
                              right: 4,
                              child: GestureDetector(
                                onTap: () {
                                  ref.read(vehicleRegistrationProvider.notifier).removeBonusPhoto(photos[index]);
                                },
                                child: Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    color: bgColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(icon, size: 14, color: iconColor),
                                ),
                              ),
                            ),
                          ],
                        );
                      }

                      return GestureDetector(
                        onTap: _addPhoto,
                        child: Container(
                          decoration: BoxDecoration(
                            color: c.surfaceVariant,
                            borderRadius: AppSpacing.borderRadiusMd,
                            border: Border.all(color: c.border),
                          ),
                          child: Center(
                            child: Icon(Icons.add, color: c.textTertiary, size: 28),
                          ),
                        ),
                      );
                    },
                  ),
                  AppSpacing.vGapXxl,
                  Text(
                    'Buenos extras para agregar:',
                    style: AppTypography.bodyMedium.copyWith(
                      color: c.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  AppSpacing.vGapMd,
                  _buildHint(Icons.check, const Color(0xFF81B78C), 'Debajo del capó'),
                  AppSpacing.vGapSm,
                  _buildHint(Icons.check, const Color(0xFF81B78C), 'Mejoras o características'),
                  AppSpacing.vGapSm,
                  _buildHint(Icons.check, const Color(0xFF81B78C), 'Fotos adicionales del interior'),
                  AppSpacing.vGapSm,
                  _buildHint(Icons.close, const Color(0xFF904D4A), 'Fotos borrosas o duplicadas'),
                ],
              ),
            ),
          ),
          Container(
            color: c.background,
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      ref.read(vehicleRegistrationProvider.notifier).confirmBonusPhotos();
                      context.push(AppRoutes.serviceHistoryInfo);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: AppSpacing.borderRadiusXl,
                      ),
                    ),
                    child: Text(
                      'Continuar',
                      style: AppTypography.button.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHint(IconData icon, Color color, String text) {
    final c = context.colors;
    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: AppSpacing.sm),
        Text(
          text,
          style: AppTypography.bodyMedium.copyWith(color: c.textSecondary),
        ),
      ],
    );
  }
}
