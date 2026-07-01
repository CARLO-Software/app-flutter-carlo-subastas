import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/providers/providers.dart';
import '../../../shared/widgets/widgets.dart';

class InteriorPhotosScreen extends ConsumerStatefulWidget {
  const InteriorPhotosScreen({super.key});

  @override
  ConsumerState<InteriorPhotosScreen> createState() => _InteriorPhotosScreenState();
}

class _InteriorPhotosScreenState extends ConsumerState<InteriorPhotosScreen> {
  final _picker = ImagePicker();

  Future<void> _takePhoto(String positionId) async {
    final xFile = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 85,
    );
    if (xFile == null) return;

    // Copy to app directory for persistence
    final appDir = await getApplicationDocumentsDirectory();
    final fileName = 'interior_${positionId}_${DateTime.now().millisecondsSinceEpoch}.jpg';
    final savedFile = await File(xFile.path).copy('${appDir.path}/$fileName');

    ref.read(vehicleRegistrationProvider.notifier).addInteriorPhoto(positionId, savedFile.path);
  }

  void _onPhotoTap(String positionId) {
    final photos = ref.read(vehicleRegistrationProvider).interiorPhotosMap;
    if (photos.containsKey(positionId)) {
      _showRetakeDialog(positionId);
    } else {
      _takePhoto(positionId);
    }
  }

  void _showRetakeDialog(String positionId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Opciones de foto'),
        content: const Text('¿Deseas volver a tomar esta foto?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ref.read(vehicleRegistrationProvider.notifier).removeInteriorPhoto(positionId);
              _takePhoto(positionId);
            },
            child: const Text('Retomar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(vehicleRegistrationProvider);
    final positions = AppConstants.interiorPhotoPositions;
    final photoCount = state.interiorPhotosMap.length;
    final totalPhotos = positions.length;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Fotos Interiores'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Column(
        children: [
          // Progress bar
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            color: AppColors.surfaceVariant,
            child: Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: AppSpacing.borderRadiusFull,
                    child: LinearProgressIndicator(
                      value: photoCount / totalPhotos,
                      backgroundColor: AppColors.border,
                      valueColor: const AlwaysStoppedAnimation<Color>(AppColors.success),
                      minHeight: 8,
                    ),
                  ),
                ),
                AppSpacing.hGapMd,
                Text(
                  '$photoCount/$totalPhotos',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: AppSpacing.screenPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionHeader(
                    title: 'Fotos del interior',
                    subtitle: 'Toca cada posición para tomar la foto',
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1,
                      crossAxisSpacing: AppSpacing.md,
                      mainAxisSpacing: AppSpacing.md,
                    ),
                    itemCount: positions.length,
                    itemBuilder: (context, index) {
                      final position = positions[index];
                      final positionId = position['id']!;
                      final photoPath = state.interiorPhotosMap[positionId];
                      final hasPhoto = photoPath != null;

                      return GestureDetector(
                        onTap: () => _onPhotoTap(positionId),
                        child: Container(
                          decoration: BoxDecoration(
                            color: hasPhoto ? AppColors.surfaceVariant : AppColors.surface,
                            borderRadius: AppSpacing.borderRadiusMd,
                            border: Border.all(
                              color: hasPhoto ? AppColors.success : AppColors.border,
                              width: hasPhoto ? 2 : 1,
                            ),
                          ),
                          child: hasPhoto
                              ? Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    ClipRRect(
                                      borderRadius: AppSpacing.borderRadiusMd,
                                      child: Image.file(
                                        File(photoPath),
                                        fit: BoxFit.cover,
                                        errorBuilder: (_, __, ___) => const Center(
                                          child: Icon(Icons.broken_image, size: 48, color: AppColors.textTertiary),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      left: 0,
                                      right: 0,
                                      child: Container(
                                        padding: const EdgeInsets.all(AppSpacing.sm),
                                        decoration: BoxDecoration(
                                          color: AppColors.success.withValues(alpha: 0.9),
                                          borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(AppSpacing.radiusMd),
                                            bottomRight: Radius.circular(AppSpacing.radiusMd),
                                          ),
                                        ),
                                        child: Text(
                                          position['name']!,
                                          style: AppTypography.labelMedium.copyWith(color: AppColors.textOnPrimary),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 56,
                                      height: 56,
                                      decoration: BoxDecoration(
                                        color: AppColors.surfaceVariant,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        _iconForPosition(positionId),
                                        size: 28,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                    AppSpacing.vGapSm,
                                    Text(
                                      position['name']!,
                                      style: AppTypography.labelMedium.copyWith(color: AppColors.textPrimary),
                                      textAlign: TextAlign.center,
                                    ),
                                    AppSpacing.vGapXs,
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
                                      child: Text(
                                        position['instructions']!,
                                        style: AppTypography.caption.copyWith(color: AppColors.textTertiary),
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      );
                    },
                  ),
                  AppSpacing.vGapLg,
                ],
              ),
            ),
          ),
          Container(
            padding: AppSpacing.screenPadding,
            decoration: BoxDecoration(
              color: AppColors.surface,
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadow,
                  blurRadius: 8,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: PrimaryButton(
              text: 'Continuar',
              isEnabled: photoCount >= 3,
              onPressed: photoCount >= 3
                  ? () {
                      ref.read(vehicleRegistrationProvider.notifier).confirmInteriorPhotos();
                      context.go(AppRoutes.dashboard);
                    }
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  IconData _iconForPosition(String positionId) {
    return switch (positionId) {
      'dashboard' => Icons.dashboard_outlined,
      'front_seats' => Icons.airline_seat_recline_normal,
      'rear_seats' => Icons.event_seat_outlined,
      'trunk' => Icons.inventory_2_outlined,
      'odometer' => Icons.speed_outlined,
      'center_console' => Icons.tune_outlined,
      _ => Icons.camera_alt_outlined,
    };
  }
}
