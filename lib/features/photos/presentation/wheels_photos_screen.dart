import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/providers/providers.dart';
import '../../../shared/widgets/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'overlay_capture_screen.dart';

const _wheelPositions = [
  {'id': 'front_left', 'name': 'Conductor delantera', 'icon': Icons.tire_repair},
  {'id': 'front_right', 'name': 'Copiloto delantera', 'icon': Icons.tire_repair},
  {'id': 'rear_left', 'name': 'Conductor trasera', 'icon': Icons.tire_repair},
  {'id': 'rear_right', 'name': 'Copiloto trasera', 'icon': Icons.tire_repair},
];

class WheelsPhotosScreen extends ConsumerStatefulWidget {
  const WheelsPhotosScreen({super.key});

  @override
  ConsumerState<WheelsPhotosScreen> createState() => _WheelsPhotosScreenState();
}

class _WheelsPhotosScreenState extends ConsumerState<WheelsPhotosScreen> {
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
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Fotos de ruedas',
                        style: AppTypography.headlineSmall.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
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
                                    'Toma fotos de cerca mostrando el neumático y el rin completo.',
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
                                    'Asegúrate de que se vea bien el estado del neumático.',
                                    style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      AppSpacing.vGapXxl,
                      // Llanta delantera
                      Text(
                        'Llanta delantera',
                        style: AppTypography.titleMedium.copyWith(fontWeight: FontWeight.w700),
                      ),
                      AppSpacing.vGapMd,
                      ClipRRect(
                        borderRadius: AppSpacing.borderRadiusMd,
                        child: Image.asset(
                          'assets/images/llantas/llantas-delantera.webp',
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                      AppSpacing.vGapXxl,
                      // Llanta trasera
                      Text(
                        'Llanta trasera',
                        style: AppTypography.titleMedium.copyWith(fontWeight: FontWeight.w700),
                      ),
                      AppSpacing.vGapMd,
                      ClipRRect(
                        borderRadius: AppSpacing.borderRadiusMd,
                        child: Image.asset(
                          'assets/images/llantas/llantas-trasera.webp',
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
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
        ? _wheelPositions.indexWhere((w) => w['id'] == startFromId)
        : 0;
    for (var i = start; i < _wheelPositions.length; i++) {
      final wheel = _wheelPositions[i];
      final wheelId = wheel['id'] as String;
      final overlay = AppConstants.cameraOverlayForWheelPosition(wheelId);
      if (overlay == null) continue;
      final exampleAsset = wheelId.startsWith('front')
          ? 'assets/images/llantas/llantas-delantera.webp'
          : 'assets/images/llantas/llantas-trasera.webp';
      items.add(OverlayCaptureItem(
        id: wheelId,
        title: wheel['name'] as String,
        overlayAsset: overlay,
        filePrefix: 'wheel_$wheelId',
        exampleAsset: exampleAsset,
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
      ref.read(vehicleRegistrationProvider.notifier).addWheelPhoto(entry.key, entry.value);
    }
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
                _startCapture(startFromId: wheelId);
              },
              child: const Text('Retomar'),
            ),
          ],
        ),
      );
    } else {
      _startCapture(startFromId: wheelId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final wheelsPhotosMap = ref.watch(vehicleRegistrationProvider.select((s) => s.wheelsPhotosMap));
    final photoCount = wheelsPhotosMap.length;

    return Scaffold(
      backgroundColor: c.background,
      appBar: AppBar(
        title: const Text('Fotos de Ruedas'),
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
                    title: 'Ruedas del vehículo',
                    subtitle: 'Toma una foto de cerca de cada llanta mostrando el neumático y el rin',
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
                      final photoPath = wheelsPhotosMap[wheelId];
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
                                        child: SvgPicture.asset(
                                          AppConstants.templateForWheelPosition(wheelId)!,
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
                      context.push(AppRoutes.wheelDamage);
                    }
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
