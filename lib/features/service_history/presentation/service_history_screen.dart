import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart' as path;
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../models/models.dart';
import '../../../shared/providers/providers.dart';
import '../../../shared/widgets/widgets.dart';

class ServiceHistoryScreen extends ConsumerStatefulWidget {
  const ServiceHistoryScreen({super.key});

  @override
  ConsumerState<ServiceHistoryScreen> createState() => _ServiceHistoryScreenState();
}

class _ServiceHistoryScreenState extends ConsumerState<ServiceHistoryScreen> {
  bool _isPickingFile = false;

  Future<void> _pickDocuments() async {
    if (_isPickingFile) return;

    setState(() => _isPickingFile = true);

    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
        allowMultiple: true,
      );

      if (result != null && result.files.isNotEmpty) {
        final notifier = ref.read(vehicleRegistrationProvider.notifier);
        for (final file in result.files) {
          if (file.path != null) {
            notifier.addServiceDocument(file.path!);
          }
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al seleccionar archivos: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isPickingFile = false);
      }
    }
  }

  void _removeDocument(String documentPath) {
    ref.read(vehicleRegistrationProvider.notifier).removeServiceDocument(documentPath);
  }

  String _getFileName(String filePath) {
    return path.basename(filePath);
  }

  IconData _getFileIcon(String filePath) {
    final extension = path.extension(filePath).toLowerCase();
    if (extension == '.pdf') {
      return Icons.picture_as_pdf;
    }
    return Icons.image;
  }

  String _getFileSize(String filePath) {
    try {
      final file = File(filePath);
      final bytes = file.lengthSync();
      if (bytes < 1024) return '$bytes B';
      if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    } catch (_) {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final registrationState = ref.watch(vehicleRegistrationProvider);
    final selectedType = registrationState.serviceHistoryType;
    final documents = registrationState.serviceDocuments;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial de Servicio'),
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
                    title: 'Historial de Servicio',
                    subtitle: 'Cuéntanos sobre el historial de servicio de tu vehículo',
                  ),
                  SelectableOptionCard(
                    title: 'Historial Completo',
                    subtitle: 'Todos los servicios completados a tiempo',
                    icon: Icons.check_circle_outline,
                    isSelected: selectedType == ServiceHistoryType.full,
                    onTap: () {
                      ref
                          .read(vehicleRegistrationProvider.notifier)
                          .setServiceHistoryType(ServiceHistoryType.full);
                    },
                  ),
                  AppSpacing.vGapMd,
                  SelectableOptionCard(
                    title: 'Historial Parcial',
                    subtitle: 'Algunos registros de servicio disponibles',
                    icon: Icons.remove_circle_outline,
                    isSelected: selectedType == ServiceHistoryType.partial,
                    onTap: () {
                      ref
                          .read(vehicleRegistrationProvider.notifier)
                          .setServiceHistoryType(ServiceHistoryType.partial);
                    },
                  ),
                  AppSpacing.vGapMd,
                  SelectableOptionCard(
                    title: 'Sin Historial',
                    subtitle: 'No hay registros de servicio disponibles',
                    icon: Icons.cancel_outlined,
                    isSelected: selectedType == ServiceHistoryType.none,
                    onTap: () {
                      ref
                          .read(vehicleRegistrationProvider.notifier)
                          .setServiceHistoryType(ServiceHistoryType.none);
                    },
                  ),
                  AppSpacing.vGapLg,

                  if (selectedType != null && selectedType != ServiceHistoryType.none) ...[
                    Text(
                      'Subir Documentos',
                      style: AppTypography.titleMedium,
                    ),
                    AppSpacing.vGapSm,
                    Text(
                      'Sube tus registros de servicio para mejorar el valor en subasta',
                      style: AppTypography.bodySmall.copyWith(
                        color: c.textSecondary,
                      ),
                    ),
                    AppSpacing.vGapMd,

                    // Lista de documentos subidos
                    if (documents.isNotEmpty) ...[
                      ...documents.map((doc) => _DocumentTile(
                            filePath: doc,
                            fileName: _getFileName(doc),
                            fileSize: _getFileSize(doc),
                            icon: _getFileIcon(doc),
                            onRemove: () => _removeDocument(doc),
                          )),
                      AppSpacing.vGapMd,
                    ],

                    // Botón de upload
                    GestureDetector(
                      onTap: _isPickingFile ? null : _pickDocuments,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(AppSpacing.xl),
                        decoration: BoxDecoration(
                          color: c.surfaceVariant,
                          borderRadius: AppSpacing.borderRadiusMd,
                          border: Border.all(
                            color: c.border,
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: 64,
                              height: 64,
                              decoration: BoxDecoration(
                                color: AppColors.primary.withValues(alpha: 0.1),
                                shape: BoxShape.circle,
                              ),
                              child: _isPickingFile
                                  ? const Padding(
                                      padding: EdgeInsets.all(16),
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: AppColors.primary,
                                      ),
                                    )
                                  : const Icon(
                                      Icons.upload_file_outlined,
                                      size: 32,
                                      color: AppColors.primary,
                                    ),
                            ),
                            AppSpacing.vGapMd,
                            Text(
                              _isPickingFile
                                  ? 'Seleccionando...'
                                  : documents.isEmpty
                                      ? 'Toca para subir documentos'
                                      : 'Agregar más documentos',
                              style: AppTypography.titleSmall.copyWith(
                                color: AppColors.primary,
                              ),
                            ),
                            AppSpacing.vGapXs,
                            Text(
                              'PDF, JPG, PNG hasta 10MB',
                              style: AppTypography.caption,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                  AppSpacing.vGapLg,
                ],
              ),
            ),
          ),
          BottomActionBar(
            child: PrimaryButton(
              text: 'Continuar',
              isEnabled: selectedType != null,
              onPressed: selectedType != null
                  ? () {
                      ref.read(vehicleRegistrationProvider.notifier).confirmServiceHistory();
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

class _DocumentTile extends StatelessWidget {
  const _DocumentTile({
    required this.filePath,
    required this.fileName,
    required this.fileSize,
    required this.icon,
    required this.onRemove,
  });

  final String filePath;
  final String fileName;
  final String fileSize;
  final IconData icon;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;

    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: c.surface,
        borderRadius: AppSpacing.borderRadiusSm,
        border: Border.all(color: c.border),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: AppSpacing.borderRadiusSm,
            ),
            child: Icon(
              icon,
              color: AppColors.primary,
              size: 20,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fileName,
                  style: AppTypography.bodyMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (fileSize.isNotEmpty)
                  Text(
                    fileSize,
                    style: AppTypography.caption.copyWith(
                      color: c.textSecondary,
                    ),
                  ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.close,
              color: c.textSecondary,
              size: 20,
            ),
            onPressed: onRemove,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(
              minWidth: 32,
              minHeight: 32,
            ),
          ),
        ],
      ),
    );
  }
}
