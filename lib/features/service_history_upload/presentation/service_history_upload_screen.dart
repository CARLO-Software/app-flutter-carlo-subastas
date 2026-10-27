import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/providers/providers.dart';
import 'document_scanner_screen.dart';

class ServiceHistoryUploadScreen extends ConsumerStatefulWidget {
  const ServiceHistoryUploadScreen({super.key});

  @override
  ConsumerState<ServiceHistoryUploadScreen> createState() => _ServiceHistoryUploadScreenState();
}

class _ServiceHistoryUploadScreenState extends ConsumerState<ServiceHistoryUploadScreen> {
  final _picker = ImagePicker();

  void _showOptions() {
    final c = context.colors;
    showModalBottomSheet(
      context: context,
      backgroundColor: c.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: AppSpacing.sm),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: c.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            ListTile(
              leading: Icon(Icons.photo_library_outlined, color: c.textSecondary),
              title: Text('Biblioteca de fotos', style: AppTypography.bodyMedium.copyWith(color: c.textPrimary)),
              onTap: () async {
                Navigator.pop(ctx);
                final image = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 85);
                if (image != null && mounted) {
                  ref.read(vehicleRegistrationProvider.notifier).addServiceHistoryPhoto(image.path);
                }
              },
            ),
            ListTile(
              leading: Icon(Icons.camera_alt_outlined, color: c.textSecondary),
              title: Text('Tomar foto', style: AppTypography.bodyMedium.copyWith(color: c.textPrimary)),
              onTap: () async {
                Navigator.pop(ctx);
                final result = await Navigator.of(context).push<String>(
                  MaterialPageRoute(builder: (_) => const DocumentScannerScreen()),
                );
                if (result != null && mounted) {
                  ref.read(vehicleRegistrationProvider.notifier).addServiceHistoryPhoto(result);
                }
              },
            ),
            ListTile(
              leading: Icon(Icons.folder_outlined, color: c.textSecondary),
              title: Text('Elegir archivo', style: AppTypography.bodyMedium.copyWith(color: c.textPrimary)),
              onTap: () async {
                Navigator.pop(ctx);
                final result = await FilePicker.platform.pickFiles(type: FileType.image);
                if (result != null && result.files.single.path != null && mounted) {
                  ref.read(vehicleRegistrationProvider.notifier).addServiceHistoryPhoto(result.files.single.path!);
                }
              },
            ),
            const SizedBox(height: AppSpacing.lg),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final photos = ref.watch(vehicleRegistrationProvider.select((s) => s.serviceHistoryPhotos));
    final noHistory = ref.watch(vehicleRegistrationProvider.select((s) => s.noServiceHistory));
    final canContinue = photos.isNotEmpty || noHistory;

    return Scaffold(
      backgroundColor: c.background,
      appBar: AppBar(
        title: const Text('Historial de servicio'),
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
                    'Sube tu historial de servicio',
                    style: AppTypography.titleLarge.copyWith(
                      color: c.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  AppSpacing.vGapXs,
                  Text(
                    'Incluye cualquier historial de servicio de todos los dueños anteriores si lo tienes.',
                    style: AppTypography.bodyMedium.copyWith(
                      color: c.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  AppSpacing.vGapLg,
                  // Upload card
                  GestureDetector(
                    onTap: noHistory ? null : _showOptions,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(AppSpacing.xl),
                      decoration: BoxDecoration(
                        color: c.surfaceVariant,
                        borderRadius: AppSpacing.borderRadiusLg,
                        border: Border.all(
                          color: c.border,
                          width: 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              color: c.surfaceVariant,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.cloud_upload_outlined, color: c.textSecondary, size: 28),
                          ),
                          const SizedBox(height: AppSpacing.md),
                          Text(
                            'Toca para agregar fotos',
                            style: AppTypography.bodyMedium.copyWith(
                              color: c.textSecondary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Foto, cámara o archivo',
                            style: AppTypography.bodySmall.copyWith(color: c.textTertiary),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Captured photos
                  if (photos.isNotEmpty) ...[
                    AppSpacing.vGapMd,
                    SizedBox(
                      height: 100,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: photos.length,
                        separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.sm),
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              ClipRRect(
                                borderRadius: AppSpacing.borderRadiusMd,
                                child: Image.file(
                                  File(photos[index]),
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: 4,
                                right: 4,
                                child: GestureDetector(
                                  onTap: () {
                                    ref.read(vehicleRegistrationProvider.notifier)
                                        .removeServiceHistoryPhoto(photos[index]);
                                  },
                                  child: Container(
                                    width: 22,
                                    height: 22,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFFCE1DB),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(Icons.close, size: 14, color: Color(0xFF904D4A)),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                  AppSpacing.vGapXxl,
                  // No service history option
                  GestureDetector(
                    onTap: () {
                      ref.read(vehicleRegistrationProvider.notifier).setNoServiceHistory(!noHistory);
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: c.surfaceVariant,
                        borderRadius: AppSpacing.borderRadiusLg,
                        border: Border.all(
                          color: noHistory ? AppColors.primary : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: noHistory ? AppColors.primary : Colors.transparent,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: noHistory ? AppColors.primary : c.border,
                                width: 2,
                              ),
                            ),
                            child: noHistory
                                ? const Icon(Icons.check, size: 16, color: Colors.white)
                                : null,
                          ),
                          const SizedBox(width: AppSpacing.md),
                          Text(
                            'No tengo historial de servicio',
                            style: AppTypography.bodyMedium.copyWith(
                              color: c.textPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
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
                    onPressed: canContinue
                        ? () {
                            ref.read(vehicleRegistrationProvider.notifier).confirmServiceHistoryUpload();
                            context.push(AppRoutes.v5cLogBook);
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: AppColors.primary.withValues(alpha: 0.3),
                      disabledForegroundColor: Colors.white,
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
}
