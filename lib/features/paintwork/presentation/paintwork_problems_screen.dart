import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../models/models.dart';
import '../../../shared/providers/providers.dart';


const _views = ['Lado conductor', 'Lado pasajero', 'Trasera', 'Frente', 'Techo'];
const _viewIds = ['driver', 'passenger', 'back', 'front', 'top'];

const _sizes = [
  {'id': 'small', 'label': 'Pequeño', 'desc': '0–5 cm'},
  {'id': 'medium', 'label': 'Mediano', 'desc': '6–15 cm'},
  {'id': 'large', 'label': 'Grande', 'desc': '16+ cm'},
];

class PaintworkProblemsScreen extends ConsumerStatefulWidget {
  const PaintworkProblemsScreen({super.key});

  @override
  ConsumerState<PaintworkProblemsScreen> createState() => _PaintworkProblemsScreenState();
}

class _PaintworkProblemsScreenState extends ConsumerState<PaintworkProblemsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _uuid = const Uuid();
  String _selectedSize = 'small';
  late List<PaintworkMark> _marks;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _views.length, vsync: this);
    _marks = List<PaintworkMark>.from(ref.read(vehicleRegistrationProvider).paintworkMarks);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _addMark(String viewId, Offset position, Size canvasSize) {
    final mark = PaintworkMark(
      id: _uuid.v4(),
      view: viewId,
      x: position.dx / canvasSize.width,
      y: position.dy / canvasSize.height,
      size: _selectedSize,
    );
    setState(() => _marks.add(mark));
    ref.read(vehicleRegistrationProvider.notifier).addPaintworkMark(mark);
  }

  void _removeMark(String markId) {
    setState(() => _marks.removeWhere((m) => m.id == markId));
    ref.read(vehicleRegistrationProvider.notifier).removePaintworkMark(markId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A2E),
        foregroundColor: Colors.white,
        title: const Text('Problemas de pintura'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Column(
        children: [
          // Size selector
          Container(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
            child: Row(
              children: _sizes.map((s) {
                final isSelected = _selectedSize == s['id'];
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedSize = s['id']!),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.primary : Colors.white12,
                          borderRadius: AppSpacing.borderRadiusSm,
                        ),
                        child: Column(
                          children: [
                            Text(
                              s['label']!,
                              style: AppTypography.labelMedium.copyWith(
                                color: Colors.white,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                            Text(
                              s['desc']!,
                              style: AppTypography.caption.copyWith(color: Colors.white60),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          // Tab bar
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

          // Car diagram area
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: List.generate(_views.length, (index) {
                final viewId = _viewIds[index];
                final viewMarks = _marks.where((m) => m.view == viewId).toList();
                return _CarDiagramView(
                  viewId: viewId,
                  viewLabel: _views[index],
                  marks: viewMarks,
                  selectedSize: _selectedSize,
                  onTap: (pos, size) => _addMark(viewId, pos, size),
                  onRemoveMark: _removeMark,
                );
              }),
            ),
          ),

          // Mark count
          if (_marks.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
              child: Row(
                children: [
                  Icon(Icons.circle, size: 12, color: AppColors.primary),
                  AppSpacing.hGapSm,
                  Text(
                    '${_marks.length} problema${_marks.length == 1 ? '' : 's'} marcado${_marks.length == 1 ? '' : 's'}',
                    style: AppTypography.bodySmall.copyWith(color: Colors.white70),
                  ),
                ],
              ),
            ),

          // Bottom actions
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        ref.read(vehicleRegistrationProvider.notifier).confirmPaintwork();
                        context.pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: AppSpacing.borderRadiusMd),
                      ),
                      child: Text(
                        _marks.isEmpty ? 'Sin problemas de pintura' : 'Listo',
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

class _CarDiagramView extends StatelessWidget {
  final String viewId;
  final String viewLabel;
  final List<PaintworkMark> marks;
  final String selectedSize;
  final void Function(Offset position, Size canvasSize) onTap;
  final void Function(String markId) onRemoveMark;

  const _CarDiagramView({
    required this.viewId,
    required this.viewLabel,
    required this.marks,
    required this.selectedSize,
    required this.onTap,
    required this.onRemoveMark,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          onTapUp: (details) => onTap(details.localPosition, constraints.biggest),
          child: Stack(
            children: [
              // Car outline
              Center(
                child: CustomPaint(
                  size: constraints.biggest,
                  painter: _CarOutlinePainter(viewId),
                ),
              ),
              // Marks
              ...marks.map((mark) {
                final x = mark.x * constraints.maxWidth;
                final y = mark.y * constraints.maxHeight;
                final dotSize = _dotSize(mark.size);
                return Positioned(
                  left: x - dotSize / 2,
                  top: y - dotSize / 2,
                  child: GestureDetector(
                    onTap: () => onRemoveMark(mark.id),
                    child: Container(
                      width: dotSize,
                      height: dotSize,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.5),
                            blurRadius: 8,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
              // Instructions
              Positioned(
                bottom: 16,
                left: 0,
                right: 0,
                child: Text(
                  'Toca para marcar problemas de pintura',
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

  double _dotSize(String size) {
    switch (size) {
      case 'small':
        return 16;
      case 'medium':
        return 24;
      case 'large':
        return 34;
      default:
        return 16;
    }
  }
}

class _CarOutlinePainter extends CustomPainter {
  final String viewId;

  _CarOutlinePainter(this.viewId);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white24
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    final cx = size.width / 2;
    final cy = size.height / 2;

    switch (viewId) {
      case 'driver':
      case 'passenger':
        _drawSideView(canvas, size, paint, cx, cy, viewId == 'passenger');
        break;
      case 'front':
        _drawFrontView(canvas, size, paint, cx, cy);
        break;
      case 'back':
        _drawBackView(canvas, size, paint, cx, cy);
        break;
      case 'top':
        _drawTopView(canvas, size, paint, cx, cy);
        break;
    }
  }

  void _drawSideView(Canvas canvas, Size size, Paint paint, double cx, double cy, bool flip) {
    final w = size.width * 0.8;
    final h = size.height * 0.35;
    final left = cx - w / 2;
    final top = cy - h / 2 + 20;

    canvas.save();
    if (flip) {
      canvas.translate(size.width, 0);
      canvas.scale(-1, 1);
    }

    // Body
    final body = Path()
      ..moveTo(left + w * 0.05, top + h)
      ..lineTo(left + w * 0.05, top + h * 0.55)
      ..quadraticBezierTo(left + w * 0.1, top + h * 0.5, left + w * 0.2, top + h * 0.5)
      ..lineTo(left + w * 0.25, top + h * 0.15)
      ..quadraticBezierTo(left + w * 0.3, top, left + w * 0.38, top)
      ..lineTo(left + w * 0.62, top)
      ..quadraticBezierTo(left + w * 0.7, top, left + w * 0.72, top + h * 0.15)
      ..lineTo(left + w * 0.78, top + h * 0.5)
      ..quadraticBezierTo(left + w * 0.9, top + h * 0.5, left + w * 0.95, top + h * 0.55)
      ..lineTo(left + w * 0.95, top + h);
    canvas.drawPath(body, paint);

    // Windows
    final window = Path()
      ..moveTo(left + w * 0.28, top + h * 0.2)
      ..lineTo(left + w * 0.48, top + h * 0.2)
      ..lineTo(left + w * 0.48, top + h * 0.48)
      ..lineTo(left + w * 0.26, top + h * 0.48)
      ..close();
    canvas.drawPath(window, paint);

    final window2 = Path()
      ..moveTo(left + w * 0.52, top + h * 0.2)
      ..lineTo(left + w * 0.68, top + h * 0.2)
      ..lineTo(left + w * 0.72, top + h * 0.48)
      ..lineTo(left + w * 0.52, top + h * 0.48)
      ..close();
    canvas.drawPath(window2, paint);

    // Wheels
    canvas.drawCircle(Offset(left + w * 0.2, top + h), w * 0.07, paint);
    canvas.drawCircle(Offset(left + w * 0.8, top + h), w * 0.07, paint);

    canvas.restore();
  }

  void _drawFrontView(Canvas canvas, Size size, Paint paint, double cx, double cy) {
    final w = size.width * 0.5;
    final h = size.height * 0.45;
    final left = cx - w / 2;
    final top = cy - h / 2;

    // Body outline
    final body = Path()
      ..moveTo(left, top + h)
      ..lineTo(left, top + h * 0.45)
      ..quadraticBezierTo(left + w * 0.1, top + h * 0.4, left + w * 0.15, top + h * 0.25)
      ..quadraticBezierTo(left + w * 0.2, top, cx, top)
      ..quadraticBezierTo(left + w * 0.8, top, left + w * 0.85, top + h * 0.25)
      ..quadraticBezierTo(left + w * 0.9, top + h * 0.4, left + w, top + h * 0.45)
      ..lineTo(left + w, top + h);
    canvas.drawPath(body, paint);

    // Windshield
    final windshield = Path()
      ..moveTo(left + w * 0.2, top + h * 0.28)
      ..quadraticBezierTo(cx, top + h * 0.15, left + w * 0.8, top + h * 0.28)
      ..lineTo(left + w * 0.75, top + h * 0.42)
      ..lineTo(left + w * 0.25, top + h * 0.42)
      ..close();
    canvas.drawPath(windshield, paint);

    // Headlights
    canvas.drawOval(Rect.fromCenter(center: Offset(left + w * 0.18, top + h * 0.55), width: w * 0.15, height: h * 0.08), paint);
    canvas.drawOval(Rect.fromCenter(center: Offset(left + w * 0.82, top + h * 0.55), width: w * 0.15, height: h * 0.08), paint);

    // Grille
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset(cx, top + h * 0.65), width: w * 0.4, height: h * 0.1),
        const Radius.circular(4),
      ),
      paint,
    );

    // Bumper
    canvas.drawLine(Offset(left + w * 0.1, top + h * 0.85), Offset(left + w * 0.9, top + h * 0.85), paint);
  }

  void _drawBackView(Canvas canvas, Size size, Paint paint, double cx, double cy) {
    final w = size.width * 0.5;
    final h = size.height * 0.45;
    final left = cx - w / 2;
    final top = cy - h / 2;

    // Body outline
    final body = Path()
      ..moveTo(left, top + h)
      ..lineTo(left, top + h * 0.3)
      ..quadraticBezierTo(left + w * 0.05, top, cx, top)
      ..quadraticBezierTo(left + w * 0.95, top, left + w, top + h * 0.3)
      ..lineTo(left + w, top + h);
    canvas.drawPath(body, paint);

    // Rear windshield
    final rearWindow = Path()
      ..moveTo(left + w * 0.15, top + h * 0.15)
      ..quadraticBezierTo(cx, top + h * 0.05, left + w * 0.85, top + h * 0.15)
      ..lineTo(left + w * 0.8, top + h * 0.35)
      ..lineTo(left + w * 0.2, top + h * 0.35)
      ..close();
    canvas.drawPath(rearWindow, paint);

    // Tail lights
    canvas.drawOval(Rect.fromCenter(center: Offset(left + w * 0.12, top + h * 0.55), width: w * 0.12, height: h * 0.12), paint);
    canvas.drawOval(Rect.fromCenter(center: Offset(left + w * 0.88, top + h * 0.55), width: w * 0.12, height: h * 0.12), paint);

    // License plate
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset(cx, top + h * 0.7), width: w * 0.35, height: h * 0.1),
        const Radius.circular(3),
      ),
      paint,
    );

    // Bumper
    canvas.drawLine(Offset(left + w * 0.1, top + h * 0.88), Offset(left + w * 0.9, top + h * 0.88), paint);
  }

  void _drawTopView(Canvas canvas, Size size, Paint paint, double cx, double cy) {
    final w = size.width * 0.35;
    final h = size.height * 0.7;
    final left = cx - w / 2;
    final top = cy - h / 2;

    // Body outline
    final body = Path()
      ..moveTo(cx, top)
      ..quadraticBezierTo(left + w, top + h * 0.05, left + w, top + h * 0.15)
      ..lineTo(left + w, top + h * 0.85)
      ..quadraticBezierTo(left + w, top + h * 0.95, cx, top + h)
      ..quadraticBezierTo(left, top + h * 0.95, left, top + h * 0.85)
      ..lineTo(left, top + h * 0.15)
      ..quadraticBezierTo(left, top + h * 0.05, cx, top)
      ..close();
    canvas.drawPath(body, paint);

    // Windshield line
    canvas.drawLine(Offset(left + w * 0.15, top + h * 0.25), Offset(left + w * 0.85, top + h * 0.25), paint);
    // Rear window line
    canvas.drawLine(Offset(left + w * 0.15, top + h * 0.7), Offset(left + w * 0.85, top + h * 0.7), paint);
    // Roof line
    canvas.drawLine(Offset(left + w * 0.2, top + h * 0.35), Offset(left + w * 0.8, top + h * 0.35), paint);
    canvas.drawLine(Offset(left + w * 0.2, top + h * 0.6), Offset(left + w * 0.8, top + h * 0.6), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
