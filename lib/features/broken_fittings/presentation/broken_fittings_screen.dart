import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/providers/providers.dart';
import '../../../shared/widgets/widgets.dart';

const _exampleItems = [
  {'title': 'Manijas de puertas', 'icon': Icons.door_front_door_outlined},
  {'title': 'Parachoques con hoyos', 'icon': Icons.car_crash_outlined},
  {'title': 'Cuero dañado', 'icon': Icons.event_seat_outlined},
  {'title': 'Luz trasera rota', 'icon': Icons.lightbulb_outline},
];

class BrokenFittingsScreen extends ConsumerStatefulWidget {
  const BrokenFittingsScreen({super.key});

  @override
  ConsumerState<BrokenFittingsScreen> createState() => _BrokenFittingsScreenState();
}

class _BrokenFittingsScreenState extends ConsumerState<BrokenFittingsScreen> {
  final _picker = ImagePicker();
  late List<String> _photos;

  @override
  void initState() {
    super.initState();
    _photos = List<String>.from(ref.read(vehicleRegistrationProvider).brokenFittingsPhotos);
  }

  Future<void> _takePhoto() async {
    final xFile = await _picker.pickImage(source: ImageSource.camera, imageQuality: 85);
    if (xFile == null) return;

    final appDir = await getApplicationDocumentsDirectory();
    final fileName = 'broken_${DateTime.now().millisecondsSinceEpoch}.jpg';
    final saved = await File(xFile.path).copy('${appDir.path}/$fileName');

    setState(() => _photos.add(saved.path));
    ref.read(vehicleRegistrationProvider.notifier).addBrokenFittingPhoto(saved.path);
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;

    return Scaffold(
      backgroundColor: c.background,
      appBar: AppBar(
        title: const Text('Accesorios rotos o faltantes'),
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
                    title: 'Accesorios rotos o faltantes',
                    subtitle: '¿Hay partes rotas o faltantes en tu vehículo?',
                  ),
                  Text(
                    'Ejemplos de accesorios rotos:',
                    style: AppTypography.labelLarge.copyWith(color: c.textSecondary),
                  ),
                  AppSpacing.vGapMd,
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: _exampleItems.map((item) {
                      return Container(
                        width: (MediaQuery.of(context).size.width - 48) / 2,
                        padding: const EdgeInsets.all(AppSpacing.md),
                        decoration: BoxDecoration(
                          color: c.surfaceVariant,
                          borderRadius: AppSpacing.borderRadiusMd,
                          border: Border.all(color: c.border),
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: AppColors.error.withValues(alpha: 0.1),
                                borderRadius: AppSpacing.borderRadiusSm,
                              ),
                              child: Icon(item['icon'] as IconData, color: AppColors.error, size: 24),
                            ),
                            AppSpacing.vGapSm,
                            Text(
                              item['title'] as String,
                              style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  AppSpacing.vGapLg,
                  if (_photos.isNotEmpty) ...[
                    Text(
                      'Fotos tomadas (${_photos.length})',
                      style: AppTypography.titleSmall.copyWith(fontWeight: FontWeight.w600),
                    ),
                    AppSpacing.vGapSm,
                    SizedBox(
                      height: 100,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: _photos.length,
                        separatorBuilder: (_, __) => AppSpacing.hGapSm,
                        itemBuilder: (_, i) {
                          return Stack(
                            children: [
                              ClipRRect(
                                borderRadius: AppSpacing.borderRadiusMd,
                                child: Image.file(
                                  File(_photos[i]),
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => Container(
                                    width: 100,
                                    height: 100,
                                    color: c.surfaceVariant,
                                    child: const Icon(Icons.broken_image),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 4,
                                right: 4,
                                child: GestureDetector(
                                  onTap: () {
                                    ref.read(vehicleRegistrationProvider.notifier).removeBrokenFittingPhoto(_photos[i]);
                                    setState(() => _photos.removeAt(i));
                                  },
                                  child: Container(
                                    width: 24,
                                    height: 24,
                                    decoration: const BoxDecoration(
                                      color: AppColors.error,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(Icons.close, size: 14, color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    AppSpacing.vGapMd,
                  ],
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton.icon(
                      onPressed: _takePhoto,
                      icon: const Icon(Icons.camera_alt_outlined),
                      label: const Text('Tomar fotos'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: AppSpacing.borderRadiusMd),
                      ),
                    ),
                  ),
                  AppSpacing.vGapMd,
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        ref.read(vehicleRegistrationProvider.notifier).setHasBrokenFittings(false);
                        ref.read(vehicleRegistrationProvider.notifier).confirmBrokenFittings();
                        context.pop();
                      },
                      child: Text(
                        'No tiene accesorios rotos o faltantes',
                        style: AppTypography.titleSmall.copyWith(
                          color: AppColors.primary,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_photos.isNotEmpty)
            BottomActionBar(
              child: PrimaryButton(
                text: 'Confirmar',
                onPressed: () {
                  ref.read(vehicleRegistrationProvider.notifier).setHasBrokenFittings(true);
                  ref.read(vehicleRegistrationProvider.notifier).confirmBrokenFittings();
                  context.pop();
                },
              ),
            ),
        ],
      ),
    );
  }
}
