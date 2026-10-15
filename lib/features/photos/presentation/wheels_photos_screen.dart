import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/providers/providers.dart';
import '../../../shared/widgets/widgets.dart';

const _wheelPositions = [
  {'id': 'front_left', 'name': 'Delantera izquierda', 'icon': Icons.tire_repair},
  {'id': 'front_right', 'name': 'Delantera derecha', 'icon': Icons.tire_repair},
  {'id': 'rear_left', 'name': 'Trasera izquierda', 'icon': Icons.tire_repair},
  {'id': 'rear_right', 'name': 'Trasera derecha', 'icon': Icons.tire_repair},
];

class WheelsPhotosScreen extends ConsumerStatefulWidget {
  const WheelsPhotosScreen({super.key});

  @override
  ConsumerState<WheelsPhotosScreen> createState() => _WheelsPhotosScreenState();
}

class _WheelsPhotosScreenState extends ConsumerState<WheelsPhotosScreen> {
  final _picker = ImagePicker();

  Future<void> _takePhoto(String wheelId) async {
    final xFile = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 85,
    );
    if (xFile == null) return;

    final appDir = await getApplicationDocumentsDirectory();
    final fileName = 'wheel_${wheelId}_${DateTime.now().millisecondsSinceEpoch}.jpg';
    final savedFile = await File(xFile.path).copy('${appDir.path}/$fileName');

    ref.read(vehicleRegistrationProvider.notifier).addWheelPhoto(wheelId, savedFile.path);
  }

  void _onTap(String wheelId) {
    final photos = ref.read(vehicleRegistrationProvider).wheelsPhotosMap;
    if (photos.containsKey(wheelId)) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Opciones de foto'),
          content: const Text('Deseas volver a tomar esta foto?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                ref.read(vehicleRegistrationProvider.notifier).removeWheelPhoto(wheelId);
                _takePhoto(wheelId);
              },
              child: const Text('Retomar'),
            ),
          ],
        ),
      );
    } else {
      _takePhoto(wheelId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final state = ref.watch(vehicleRegistrationProvider);
    final photoCount = state.wheelsPhotosMap.length;

    return Scaffold(
      backgroundColor: c.background,
      appBar: AppBar(
        title: const Text('Fotos de Ruedas'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            color: c.surfaceVariant,
            child: Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: AppSpacing.borderRadiusFull,
                    child: LinearProgressIndicator(
                      value: photoCount / 4,
                      backgroundColor: c.border,
                      valueColor: const AlwaysStoppedAnimation<Color>(AppColors.success),
                      minHeight: 8,
                    ),
                  ),
                ),
                AppSpacing.hGapMd,
                Text(
                  '$photoCount/4',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: c.textSecondary,
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
                    title: 'Ruedas del vehículo',
                    subtitle: 'Toma una foto de cerca de cada rueda mostrando el neumático y el rin',
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.85,
                      crossAxisSpacing: AppSpacing.md,
                      mainAxisSpacing: AppSpacing.md,
                    ),
                    itemCount: _wheelPositions.length,
                    itemBuilder: (context, index) {
                      final wheel = _wheelPositions[index];
                      final wheelId = wheel['id'] as String;
                      final wheelName = wheel['name'] as String;
                      final photoPath = state.wheelsPhotosMap[wheelId];
                      final hasPhoto = photoPath != null;

                      return GestureDetector(
                        onTap: () => _onTap(wheelId),
                        child: Container(
                          decoration: BoxDecoration(
                            color: hasPhoto ? c.surfaceVariant : c.surface,
                            borderRadius: AppSpacing.borderRadiusMd,
                            border: Border.all(
                              color: hasPhoto ? AppColors.success : c.border,
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
                                        errorBuilder: (_, __, ___) => Center(
                                          child: Icon(Icons.broken_image, size: 48, color: c.textTertiary),
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
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            const Icon(Icons.check_circle, color: Colors.white, size: 16),
                                            const SizedBox(width: 4),
                                            Flexible(
                                              child: Text(
                                                wheelName,
                                                style: AppTypography.labelMedium.copyWith(color: Colors.white),
                                                textAlign: TextAlign.center,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : Column(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(AppSpacing.sm),
                                        child: Image.asset(
                                          AppConstants.wheelTireTemplate,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: AppSpacing.md,
                                        right: AppSpacing.md,
                                        bottom: AppSpacing.sm + 4,
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              wheelName,
                                              style: AppTypography.titleMedium.copyWith(fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          Container(
                                            width: 44,
                                            height: 44,
                                            decoration: const BoxDecoration(
                                              color: AppColors.primary,
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Icon(
                                              Icons.camera_alt_outlined,
                                              color: Colors.white,
                                              size: 22,
                                            ),
                                          ),
                                        ],
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
          BottomActionBar(
            child: PrimaryButton(
              text: 'Continuar',
              isEnabled: photoCount >= 4,
              onPressed: photoCount >= 4
                  ? () {
                      ref.read(vehicleRegistrationProvider.notifier).confirmWheelsPhotos();
                      context.pop();
                    }
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
