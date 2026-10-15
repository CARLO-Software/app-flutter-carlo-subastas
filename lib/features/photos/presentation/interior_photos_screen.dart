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
  final Set<String> _disabledPositions = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _showIntroPopup());
  }

  void _showIntroPopup() {
    final c = context.colors;
    final positions = AppConstants.interiorPhotoPositions;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      builder: (ctx) => FractionallySizedBox(
        heightFactor: 0.96,
        child: Container(
          decoration: BoxDecoration(
            color: c.surface,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(AppSpacing.radiusXl),
            ),
          ),
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.lg, AppSpacing.lg, 0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () => Navigator.of(ctx).pop(),
                    child: Text(
                      'Cerrar',
                      style: AppTypography.bodyMedium.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),

              // Scrollable content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Fotos interiores',
                        style: AppTypography.headlineSmall.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      AppSpacing.vGapLg,

                      // Tips card
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(AppSpacing.md),
                        decoration: BoxDecoration(
                          color: c.surfaceVariant,
                          borderRadius: AppSpacing.borderRadiusMd,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.check_circle_outline, size: 18, color: c.textPrimary),
                                AppSpacing.hGapSm,
                                Expanded(
                                  child: Text(
                                    'Toma fotos amplias mostrando la mayor parte del interior posible.',
                                    style: AppTypography.bodySmall.copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            AppSpacing.vGapSm,
                            Row(
                              children: [
                                Icon(Icons.check_circle_outline, size: 18, color: c.textPrimary),
                                AppSpacing.hGapSm,
                                Expanded(
                                  child: Text(
                                    'Asegúrate de que las fotos estén bien iluminadas y nítidas.',
                                    style: AppTypography.bodySmall.copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      AppSpacing.vGapXxl,

                      // Photo sections
                      ...positions.map((pos) => _buildPhotoSection(pos, c)),
                    ],
                  ),
                ),
              ),

              // Bottom button
              Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(ctx).pop(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF292929),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: AppSpacing.borderRadiusXl,
                      ),
                    ),
                    child: Text(
                      'OK, entendido',
                      style: AppTypography.button.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPhotoSection(Map<String, String> position, AdaptiveColors c) {
    final reference = position['reference'];
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xxl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            position['name']!,
            style: AppTypography.titleMedium.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          if (position['instructions']?.isNotEmpty ?? false) ...[
            AppSpacing.vGapXs,
            Text(
              position['instructions']!,
              style: AppTypography.bodySmall.copyWith(
                color: c.textSecondary,
              ),
            ),
          ],
          if (reference != null) ...[
            AppSpacing.vGapMd,
            ClipRRect(
              borderRadius: AppSpacing.borderRadiusMd,
              child: Image.asset(
                reference,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _takePhoto(String positionId) async {
    final xFile = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 85,
    );
    if (xFile == null || !mounted) return;

    final appDir = await getApplicationDocumentsDirectory();
    final fileName = 'interior_${positionId}_${DateTime.now().millisecondsSinceEpoch}.jpg';
    final savedFile = await File(xFile.path).copy('${appDir.path}/$fileName');
    if (!mounted) return;

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

    final c = context.colors;
    return Scaffold(
      backgroundColor: c.background,
      appBar: AppBar(
        title: const Text('Fotos Interiores'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: _showIntroPopup,
          ),
        ],
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
                      value: photoCount / totalPhotos,
                      backgroundColor: c.border,
                      valueColor: const AlwaysStoppedAnimation<Color>(AppColors.success),
                      minHeight: 8,
                    ),
                  ),
                ),
                AppSpacing.hGapMd,
                Text(
                  '$photoCount/$totalPhotos',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: c.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: AppSpacing.screenPadding,
              itemCount: positions.length,
              separatorBuilder: (_, __) => AppSpacing.vGapMd,
              itemBuilder: (context, index) {
                final position = positions[index];
                final positionId = position['id']!;
                final photoPath = state.interiorPhotosMap[positionId];
                final hasPhoto = photoPath != null;
                final plantilla = AppConstants.templateForInteriorPosition(positionId);
                final isOptional = position['optional'] == 'true';
                final isDisabled = _disabledPositions.contains(positionId);

                return GestureDetector(
                  onTap: isDisabled ? null : () => _onPhotoTap(positionId),
                  child: Opacity(
                    opacity: isDisabled ? 0.4 : 1.0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: c.surface,
                        borderRadius: AppSpacing.borderRadiusLg,
                        border: Border.all(
                          color: hasPhoto ? AppColors.success : c.border,
                          width: hasPhoto ? 2 : 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          // Image area with optional toggle
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(AppSpacing.radiusLg),
                                ),
                                child: SizedBox(
                                  width: double.infinity,
                                  height: 200,
                                  child: hasPhoto
                                      ? Image.file(
                                          File(photoPath),
                                          fit: BoxFit.cover,
                                          errorBuilder: (_, __, ___) => Center(
                                            child: Icon(Icons.broken_image, size: 48, color: c.textTertiary),
                                          ),
                                        )
                                      : plantilla != null
                                          ? Image.asset(plantilla, fit: BoxFit.contain)
                                          : Icon(Icons.camera_alt_outlined, size: 48, color: c.textTertiary),
                                ),
                              ),
                              if (isOptional)
                                Positioned(
                                  top: AppSpacing.sm,
                                  right: AppSpacing.sm,
                                  child: Transform.scale(
                                    scale: 0.9,
                                    child: Switch(
                                      value: !isDisabled,
                                      onChanged: (val) {
                                        setState(() {
                                          if (val) {
                                            _disabledPositions.remove(positionId);
                                          } else {
                                            _disabledPositions.add(positionId);
                                            if (hasPhoto) {
                                              ref.read(vehicleRegistrationProvider.notifier).removeInteriorPhoto(positionId);
                                            }
                                          }
                                        });
                                      },
                                      activeThumbColor: AppColors.primary,
                                      activeTrackColor: AppColors.primaryLight,
                                      inactiveThumbColor: Colors.white,
                                      inactiveTrackColor: c.border,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          // Bottom row: name + camera button
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.md,
                              vertical: AppSpacing.sm + 4,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    position['name']!,
                                    style: AppTypography.titleMedium.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                if (!isDisabled)
                                  Container(
                                    width: 44,
                                    height: 44,
                                    decoration: const BoxDecoration(
                                      color: AppColors.primary,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      hasPhoto ? Icons.check : Icons.camera_alt_outlined,
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
                  ),
                );
              },
            ),
          ),
          BottomActionBar(
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
}
