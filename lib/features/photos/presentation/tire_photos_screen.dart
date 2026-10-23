import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/providers/providers.dart';
import '../../../shared/widgets/widgets.dart';
import 'overlay_capture_screen.dart';

const _tirePositions = [
  {'id': 'front_left', 'name': 'Conductor delantera'},
  {'id': 'front_right', 'name': 'Copiloto delantera'},
  {'id': 'rear_left', 'name': 'Conductor trasera'},
  {'id': 'rear_right', 'name': 'Copiloto trasera'},
];

class TirePhotosScreen extends ConsumerStatefulWidget {
  const TirePhotosScreen({super.key});

  @override
  ConsumerState<TirePhotosScreen> createState() => _TirePhotosScreenState();
}

class _TirePhotosScreenState extends ConsumerState<TirePhotosScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _showIntroPopup());
  }

  void _showIntroPopup() {
    final c = context.colors;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      builder: (ctx) => FractionallySizedBox(
        heightFactor: 0.7,
        child: Container(
          decoration: BoxDecoration(
            color: c.surface,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(AppSpacing.radiusXl),
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.lg, AppSpacing.lg, 0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () => Navigator.of(ctx).pop(),
                    child: Text(
                      'Cerrar',
                      style: AppTypography.bodyMedium.copyWith(fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Fotos de neumáticos',
                        style: AppTypography.headlineSmall.copyWith(fontWeight: FontWeight.w700),
                      ),
                      AppSpacing.vGapLg,
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
                                    'Toma fotos en diagonal para que se vea la banda de rodamiento del neumático.',
                                    style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w500),
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
                                    'Asegúrate de que se vea el desgaste y estado general del neumático.',
                                    style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SafeArea(
                top: false,
                child: Padding(
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
                        shape: RoundedRectangleBorder(borderRadius: AppSpacing.borderRadiusXl),
                      ),
                      child: Text(
                        'OK, entendido',
                        style: AppTypography.button.copyWith(color: Colors.white),
                      ),
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

  List<OverlayCaptureItem> _buildItems({String? startFromId}) {
    final items = <OverlayCaptureItem>[];
    final start = startFromId != null
        ? _tirePositions.indexWhere((t) => t['id'] == startFromId)
        : 0;
    for (var i = start; i < _tirePositions.length; i++) {
      final tire = _tirePositions[i];
      final tireId = tire['id'] as String;
      items.add(OverlayCaptureItem(
        id: tireId,
        title: tire['name'] as String,
        overlayAsset: AppConstants.cameraOverlayForTirePosition(tireId),
        filePrefix: 'tire_$tireId',
      ));
    }
    return items;
  }

  Future<void> _startCapture({String? startFromId}) async {
    final items = _buildItems(startFromId: startFromId);
    if (items.isEmpty) return;

    final results = await Navigator.of(context).push<Map<String, String>>(
      MaterialPageRoute(
        builder: (_) => OverlayCaptureScreen(
          params: OverlayCaptureParams(items: items, landscape: true),
        ),
      ),
    );
    if (results == null || !mounted) return;

    for (final entry in results.entries) {
      ref.read(vehicleRegistrationProvider.notifier).addTirePhoto(entry.key, entry.value);
    }
  }

  void _onTap(String tireId) {
    final photos = ref.read(vehicleRegistrationProvider).tirePhotosMap;
    if (photos.containsKey(tireId)) {
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
                ref.read(vehicleRegistrationProvider.notifier).removeTirePhoto(tireId);
                _startCapture(startFromId: tireId);
              },
              child: const Text('Retomar'),
            ),
          ],
        ),
      );
    } else {
      _startCapture(startFromId: tireId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final tirePhotosMap = ref.watch(vehicleRegistrationProvider.select((s) => s.tirePhotosMap));
    final photoCount = tirePhotosMap.length;

    return Scaffold(
      backgroundColor: c.background,
      appBar: AppBar(
        title: const Text('Fotos de Neumáticos'),
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
                    title: 'Neumáticos del vehículo',
                    subtitle: 'Toma una foto en diagonal de cada neumático mostrando la banda de rodamiento',
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
                    itemCount: _tirePositions.length,
                    itemBuilder: (context, index) {
                      final tire = _tirePositions[index];
                      final tireId = tire['id'] as String;
                      final tireName = tire['name'] as String;
                      final photoPath = tirePhotosMap[tireId];
                      final hasPhoto = photoPath != null;

                      return GestureDetector(
                        onTap: () => _onTap(tireId),
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
                                        cacheWidth: 300,
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
                                                tireName,
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
                                        child: AppConstants.templateForTirePosition(tireId) != null
                                            ? SvgPicture.asset(
                                                AppConstants.templateForTirePosition(tireId)!,
                                                fit: BoxFit.contain,
                                              )
                                            : Icon(
                                                Icons.tire_repair,
                                                size: 64,
                                                color: c.textTertiary,
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
                                              tireName,
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
                      ref.read(vehicleRegistrationProvider.notifier).confirmTirePhotos();
                      context.push(AppRoutes.tireDamage);
                    }
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
