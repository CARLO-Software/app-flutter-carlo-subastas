import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../models/models.dart';
import '../../../shared/providers/providers.dart';

const _views = ['Lado conductor', 'Lado pasajero', 'Trasera', 'Frente'];
const _viewIds = ['driver', 'passenger', 'back', 'front'];

const _fittingTypes = [
  'Manija',
  'Espejo',
  'Luz',
  'Moldura',
  'Parachoques',
  'Otro',
];

const _silhouettes = {
  'driver': 'assets/images/plantillas/siluetas_blanco/exterior/png/exterior-lateral-izquierdo.png',
  'passenger': 'assets/images/plantillas/siluetas_blanco/exterior/png/exterior-lateral-derecho.png',
  'front': 'assets/images/plantillas/siluetas_blanco/exterior/png/exterior-frontal.png',
  'back': 'assets/images/plantillas/siluetas_blanco/exterior/png/exterior-trasera.png',
};

class BrokenFittingsScreen extends ConsumerStatefulWidget {
  const BrokenFittingsScreen({super.key});

  @override
  ConsumerState<BrokenFittingsScreen> createState() => _BrokenFittingsScreenState();
}

class _BrokenFittingsScreenState extends ConsumerState<BrokenFittingsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _uuid = const Uuid();
  final _picker = ImagePicker();
  String _selectedType = _fittingTypes.first;
  late List<BrokenFittingMark> _marks;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _views.length, vsync: this);
    _marks = List<BrokenFittingMark>.from(ref.read(vehicleRegistrationProvider).brokenFittingMarks);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _addMark(String viewId, Offset position, Size canvasSize) {
    final mark = BrokenFittingMark(
      id: _uuid.v4(),
      view: viewId,
      x: position.dx / canvasSize.width,
      y: position.dy / canvasSize.height,
      label: _selectedType,
    );
    setState(() => _marks.add(mark));
    ref.read(vehicleRegistrationProvider.notifier).addBrokenFittingMark(mark);
  }

  void _removeMark(String markId) {
    setState(() => _marks.removeWhere((m) => m.id == markId));
    ref.read(vehicleRegistrationProvider.notifier).removeBrokenFittingMark(markId);
  }

  /// Toma fotos de cada punto marcado que aún no tenga foto
  Future<void> _takePhotosForMarks() async {
    final pending = _marks.where((m) => m.photoPath == null).toList();
    if (pending.isEmpty) {
      _confirm();
      return;
    }

    for (int i = 0; i < pending.length; i++) {
      final mark = pending[i];
      final xFile = await _picker.pickImage(source: ImageSource.camera, imageQuality: 85);
      if (xFile == null) return; // el usuario canceló

      final appDir = await getApplicationDocumentsDirectory();
      final fileName = 'broken_${mark.label.toLowerCase()}_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final saved = await File(xFile.path).copy('${appDir.path}/$fileName');

      ref.read(vehicleRegistrationProvider.notifier).updateBrokenFittingMarkPhoto(mark.id, saved.path);
      setState(() {
        final idx = _marks.indexWhere((m) => m.id == mark.id);
        if (idx >= 0) _marks[idx] = _marks[idx].copyWith(photoPath: saved.path);
      });
    }

    if (mounted) _confirm();
  }

  void _confirm() {
    ref.read(vehicleRegistrationProvider.notifier).setHasBrokenFittings(_marks.isNotEmpty);
    ref.read(vehicleRegistrationProvider.notifier).confirmBrokenFittings();
    context.pop();
  }

  int get _pendingPhotos => _marks.where((m) => m.photoPath == null).length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A2E),
        foregroundColor: Colors.white,
        title: const Text('Accesorios rotos o faltantes'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Column(
        children: [
          // Selector de tipo de accesorio
          Container(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _fittingTypes.map((type) {
                  final isSelected = _selectedType == type;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedType = type),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.primary : Colors.white12,
                          borderRadius: AppSpacing.borderRadiusSm,
                        ),
                        child: Text(
                          type,
                          style: AppTypography.labelMedium.copyWith(
                            color: Colors.white,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          // Tabs de vista
          TabBar(
            controller: _tabController,
            onTap: (_) => setState(() {}),
            isScrollable: true,
            indicatorColor: AppColors.primary,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white54,
            tabAlignment: TabAlignment.start,
            tabs: _views.map((v) => Tab(text: v)).toList(),
          ),

          // Diagrama con puntos
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: List.generate(_views.length, (index) {
                final viewId = _viewIds[index];
                final viewMarks = _marks.where((m) => m.view == viewId).toList();
                return _FittingDiagramView(
                  viewId: viewId,
                  marks: viewMarks,
                  onTap: (pos, size) => _addMark(viewId, pos, size),
                  onRemoveMark: _removeMark,
                );
              }),
            ),
          ),

          // Contador de marcas
          if (_marks.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
              child: Row(
                children: [
                  Icon(Icons.circle, size: 12, color: AppColors.error),
                  AppSpacing.hGapSm,
                  Text(
                    '${_marks.length} accesorio${_marks.length == 1 ? '' : 's'} marcado${_marks.length == 1 ? '' : 's'}',
                    style: AppTypography.bodySmall.copyWith(color: Colors.white70),
                  ),
                  if (_pendingPhotos > 0) ...[
                    const Spacer(),
                    Text(
                      '$_pendingPhotos sin foto',
                      style: AppTypography.bodySmall.copyWith(color: Colors.orange),
                    ),
                  ],
                ],
              ),
            ),

          // Botones inferiores
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                children: [
                  if (_marks.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                      child: SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton.icon(
                          onPressed: _takePhotosForMarks,
                          icon: const Icon(Icons.camera_alt_outlined),
                          label: Text(
                            _pendingPhotos > 0
                                ? 'Tomar fotos ($_pendingPhotos pendientes)'
                                : 'Listo',
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: AppSpacing.borderRadiusMd),
                          ),
                        ),
                      ),
                    ),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        ref.read(vehicleRegistrationProvider.notifier).setHasBrokenFittings(false);
                        ref.read(vehicleRegistrationProvider.notifier).confirmBrokenFittings();
                        context.pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _marks.isEmpty ? Colors.white : Colors.white12,
                        foregroundColor: _marks.isEmpty ? Colors.black : Colors.white70,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: AppSpacing.borderRadiusMd),
                      ),
                      child: Text(
                        _marks.isEmpty ? 'Sin accesorios rotos' : 'Omitir fotos y confirmar',
                        style: AppTypography.button,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FittingDiagramView extends StatelessWidget {
  final String viewId;
  final List<BrokenFittingMark> marks;
  final void Function(Offset position, Size canvasSize) onTap;
  final void Function(String markId) onRemoveMark;

  const _FittingDiagramView({
    required this.viewId,
    required this.marks,
    required this.onTap,
    required this.onRemoveMark,
  });

  @override
  Widget build(BuildContext context) {
    final silhouette = _silhouettes[viewId];
    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          onTapUp: (details) => onTap(details.localPosition, constraints.biggest),
          child: Stack(
            children: [
              Center(
                child: silhouette != null
                    ? Padding(
                        padding: const EdgeInsets.all(24),
                        child: Opacity(
                          opacity: 0.45,
                          child: Image.asset(silhouette, fit: BoxFit.contain),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
              // Marcas con label
              ...marks.map((mark) {
                final x = mark.x * constraints.maxWidth;
                final y = mark.y * constraints.maxHeight;
                final hasPhoto = mark.photoPath != null;
                return Positioned(
                  left: x - 14,
                  top: y - 14,
                  child: GestureDetector(
                    onTap: () => onRemoveMark(mark.id),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            color: hasPhoto ? AppColors.success : AppColors.error,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                            boxShadow: [
                              BoxShadow(
                                color: (hasPhoto ? AppColors.success : AppColors.error).withValues(alpha: 0.5),
                                blurRadius: 8,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: Icon(
                            hasPhoto ? Icons.check : Icons.close,
                            size: 14,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 2),
                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                          decoration: BoxDecoration(
                            color: Colors.black87,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            mark.label,
                            style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
              // Instrucción
              Positioned(
                bottom: 16,
                left: 0,
                right: 0,
                child: Text(
                  'Toca para marcar accesorios rotos o faltantes',
                  textAlign: TextAlign.center,
                  style: AppTypography.bodySmall.copyWith(color: Colors.white38),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
