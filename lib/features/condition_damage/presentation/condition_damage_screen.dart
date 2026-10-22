import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/providers/providers.dart';
import '../../photos/presentation/overlay_capture_screen.dart';
import 'damage_locator_screen.dart';

class ConditionDamageScreen extends ConsumerStatefulWidget {
  const ConditionDamageScreen({super.key});

  @override
  ConsumerState<ConditionDamageScreen> createState() => _ConditionDamageScreenState();
}

class _ConditionDamageScreenState extends ConsumerState<ConditionDamageScreen> {
  final Map<String, String> _capturedPhotos = {};

  static const _damageTypes = [
    {
      'id': 'rayones',
      'title': 'Rayones o rozaduras',
      'image': 'assets/images/condicion-danos/condicion-rayadura.jpeg',
      'icon': Icons.gesture,
    },
    {
      'id': 'oxido_pintura',
      'title': 'Óxido o defectos en la pintura',
      'image': 'assets/images/condicion-danos/condicion-pintura.jpeg',
      'icon': Icons.format_paint_outlined,
    },
    {
      'id': 'parabrisas',
      'title': 'Picaduras o grietas en el parabrisas',
      'image': 'assets/images/condicion-danos/condicion-rajado-faro.jpeg',
      'icon': Icons.window_outlined,
    },
    {
      'id': 'abolladuras',
      'title': 'Abolladuras',
      'image': 'assets/images/condicion-danos/condicion-abolladura.jpeg',
      'icon': Icons.car_crash_outlined,
    },
    {
      'id': 'molduras',
      'title': 'Molduras rotas o faltantes',
      'image': 'assets/images/condicion-danos/condicion-quine.jpeg',
      'icon': Icons.build_outlined,
    },
  ];

  static const _damageExamples = [
    {
      'image': 'assets/images/condicion-danos/condicion-abolladura.jpeg',
      'title': 'Abolladura',
      'description': 'Hundimiento en el panel lateral de la puerta causado por un impacto. Requiere trabajo de desabollado y posible repintado de la zona afectada.',
    },
    {
      'image': 'assets/images/condicion-danos/condicion-quine.jpeg',
      'title': 'Quiñe',
      'description': 'Desconche de pintura en el borde de la puerta por golpe menor. Se repara con retoque de pintura o repintado parcial del panel.',
    },
    {
      'image': 'assets/images/condicion-danos/condicion-rayadura.jpeg',
      'title': 'Rayadura en parachoques',
      'description': 'Rayas superficiales en el parachoques delantero por roce. Se corrige con pulido profesional o repintado si es profunda.',
    },
    {
      'image': 'assets/images/condicion-danos/condicion-rayadura-3.jpeg',
      'title': 'Rayadura en carrocería',
      'description': 'Rayas y marcas de roce en el parachoques trasero. Requiere pulido o repintado dependiendo de la profundidad del daño.',
    },
    {
      'image': 'assets/images/condicion-danos/condicion-rayadura-faro.jpeg',
      'title': 'Rayadura en faro',
      'description': 'Rayas y opacidad en la mica del faro delantero por desgaste. Se restaura con kit de pulido de faros o reemplazo de la mica.',
    },
    {
      'image': 'assets/images/condicion-danos/condicion-rajado-faro.jpeg',
      'title': 'Faro rajado',
      'description': 'Rajadura visible en la mica del faro trasero. Requiere reemplazo completo del faro ya que no se puede reparar.',
    },
    {
      'image': 'assets/images/condicion-danos/condicion-pintura.jpeg',
      'title': 'Pintura desgastada',
      'description': 'Decoloración y desgaste de la pintura en la puerta por exposición solar. Necesita lijado y repintado completo del panel.',
    },
    {
      'image': 'assets/images/condicion-danos/condicion-pintura-reventada.jpeg',
      'title': 'Pintura reventada',
      'description': 'Pintura levantada y descascarada en el parachoques, exponiendo la base. Requiere lijado, preparación y repintado de la zona.',
    },
    {
      'image': 'assets/images/condicion-danos/condicion-desgaste-llantas.jpeg',
      'title': 'Desgaste de llantas',
      'description': 'Llanta con banda de rodamiento severamente gastada y agrietada. Requiere reemplazo inmediato por seguridad.',
    },
    {
      'image': 'assets/images/condicion-danos/condicion-descuadrado.jpeg',
      'title': 'Panel descuadrado',
      'description': 'Desalineación del parachoques trasero respecto a la carrocería. Indica un golpe previo; requiere alineación o reemplazo del panel.',
    },
  ];

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
                        'Tipos de daños',
                        style: AppTypography.headlineSmall.copyWith(fontWeight: FontWeight.w700),
                      ),
                      AppSpacing.vGapSm,
                      Text(
                        'Estos son ejemplos de los daños más comunes que debes reportar en tu vehículo.',
                        style: AppTypography.bodyMedium.copyWith(color: c.textSecondary),
                      ),
                      AppSpacing.vGapXxl,
                      ..._damageExamples.map((example) => Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.xxl),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              example['title']!,
                              style: AppTypography.titleMedium.copyWith(fontWeight: FontWeight.w700),
                            ),
                            AppSpacing.vGapXs,
                            Text(
                              example['description']!,
                              style: AppTypography.bodySmall.copyWith(color: c.textSecondary),
                            ),
                            AppSpacing.vGapMd,
                            ClipRRect(
                              borderRadius: AppSpacing.borderRadiusMd,
                              child: Image.asset(
                                example['image']!,
                                width: double.infinity,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      )),
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

  Future<void> _openCamera(Map<String, Object> type) async {
    final id = type['id'] as String;
    final title = type['title'] as String;
    final image = type['image'] as String;

    final results = await Navigator.of(context).push<Map<String, String>>(
      MaterialPageRoute(
        builder: (_) => OverlayCaptureScreen(
          params: OverlayCaptureParams(
            items: [
              OverlayCaptureItem(
                id: id,
                title: title,
                filePrefix: 'damage_$id',
                exampleAsset: image,
              ),
            ],
            landscape: true,
          ),
        ),
      ),
    );

    if (results != null && results.containsKey(id) && mounted) {
      final photoPath = results[id]!;
      final locatorResult = await Navigator.of(context).push<Map<String, dynamic>>(
        MaterialPageRoute(
          builder: (_) => DamageLocatorScreen(
            photoPath: photoPath,
            damageType: title,
          ),
        ),
      );
      if (locatorResult != null && mounted) {
        setState(() => _capturedPhotos[id] = photoPath);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E1E),
        foregroundColor: Colors.white,
        titleTextStyle: AppTypography.titleLarge.copyWith(color: Colors.white),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Condición y Daños'),
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
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '¿Qué tipo de daño o desgaste presenta?',
                    style: AppTypography.titleLarge.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  AppSpacing.vGapXs,
                  Text(
                    'Toca para tomar una foto del daño',
                    style: AppTypography.bodyMedium.copyWith(
                      color: Colors.white54,
                    ),
                  ),
                  AppSpacing.vGapXxl,
                  ..._damageTypes.map((type) => _buildDamageCard(type)),
                ],
              ),
            ),
          ),
          Container(
            color: const Color(0xFF1E1E1E),
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      final notifier = ref.read(vehicleRegistrationProvider.notifier);
                      notifier.confirmConditionDamage();
                      notifier.confirmPaintwork();
                      notifier.confirmBrokenFittings();
                      notifier.confirmWheelDamage();
                      context.push(AppRoutes.wheelsPhotos);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: AppSpacing.borderRadiusXl,
                      ),
                    ),
                    child: Text(
                      _capturedPhotos.isEmpty
                          ? 'Mi auto no tiene daños'
                          : 'Continuar',
                      style: AppTypography.button.copyWith(color: Colors.black),
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

  void _viewPhoto(String photoPath, String title, Map<String, Object> type) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => _DamagePhotoViewer(
          photoPath: photoPath,
          title: title,
          onRetake: () {
            Navigator.of(context).pop();
            _openCamera(type);
          },
        ),
      ),
    );
  }

  Widget _buildDamageCard(Map<String, Object> type) {
    final id = type['id'] as String;
    final title = type['title'] as String;
    final icon = type['icon'] as IconData;
    final capturedPath = _capturedPhotos[id];
    final hasPhoto = capturedPath != null;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: GestureDetector(
        onTap: () => hasPhoto ? _viewPhoto(capturedPath, title, type) : _openCamera(type),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF2A2A2A),
            borderRadius: AppSpacing.borderRadiusLg,
            border: Border.all(
              color: hasPhoto ? AppColors.success : Colors.transparent,
              width: 2,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  color: hasPhoto
                      ? AppColors.success.withValues(alpha: 0.15)
                      : Colors.white.withValues(alpha: 0.07),
                  borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(AppSpacing.radiusLg),
                  ),
                ),
                child: Icon(
                  icon,
                  color: hasPhoto ? AppColors.success : Colors.white70,
                  size: 40,
                ),
              ),
              AppSpacing.hGapMd,
              Expanded(
                child: Text(
                  title,
                  style: AppTypography.titleSmall.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: AppSpacing.md),
                child: hasPhoto
                    ? const Icon(Icons.check_circle, color: AppColors.success, size: 26)
                    : const Icon(Icons.camera_alt_outlined, color: Colors.white38, size: 24),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DamagePhotoViewer extends StatelessWidget {
  final String photoPath;
  final String title;
  final VoidCallback onRetake;

  const _DamagePhotoViewer({
    required this.photoPath,
    required this.title,
    required this.onRetake,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text(title),
        actions: [
          TextButton.icon(
            onPressed: onRetake,
            icon: const Icon(Icons.camera_alt_outlined, color: Colors.white, size: 20),
            label: Text(
              'Retomar',
              style: AppTypography.bodyMedium.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
      body: InteractiveViewer(
        minScale: 1.0,
        maxScale: 5.0,
        child: Center(
          child: Image.file(
            File(photoPath),
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
