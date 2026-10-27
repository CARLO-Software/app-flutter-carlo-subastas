import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';

class DocumentScannerScreen extends StatefulWidget {
  const DocumentScannerScreen({super.key});

  @override
  State<DocumentScannerScreen> createState() => _DocumentScannerScreenState();
}

class _DocumentScannerScreenState extends State<DocumentScannerScreen>
    with WidgetsBindingObserver {
  CameraController? _controller;
  bool _isInitialized = false;
  bool _isCapturing = false;
  String? _capturedPath;
  bool _showScanEffect = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initCamera();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_controller == null || !_controller!.value.isInitialized) return;
    if (state == AppLifecycleState.inactive) {
      _controller?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _initCamera();
    }
  }

  Future<void> _initCamera() async {
    final status = await Permission.camera.request();
    if (!status.isGranted) return;
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) return;
      final back = cameras.firstWhere(
        (c) => c.lensDirection == CameraLensDirection.back,
        orElse: () => cameras.first,
      );
      _controller = CameraController(back, ResolutionPreset.high, enableAudio: false);
      await _controller!.initialize();
      if (mounted) setState(() => _isInitialized = true);
    } catch (_) {}
  }

  Future<void> _takePhoto() async {
    if (_controller == null || !_controller!.value.isInitialized || _isCapturing) return;
    setState(() => _isCapturing = true);
    try {
      final photo = await _controller!.takePicture();
      final dir = await getApplicationDocumentsDirectory();
      final name = 'service_doc_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final saved = '${dir.path}/$name';
      await File(photo.path).copy(saved);
      if (!mounted) return;
      setState(() {
        _capturedPath = saved;
        _showScanEffect = true;
        _isCapturing = false;
      });
      await Future.delayed(const Duration(milliseconds: 1200));
      if (mounted) setState(() => _showScanEffect = false);
    } catch (_) {
      if (mounted) setState(() => _isCapturing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            if (_isInitialized && _capturedPath == null)
              Positioned.fill(
                child: GestureDetector(
                  onTap: _isCapturing ? null : _takePhoto,
                  child: CameraPreview(_controller!),
                ),
              )
            else if (_capturedPath != null)
              Positioned.fill(
                child: Image.file(File(_capturedPath!), fit: BoxFit.contain),
              )
            else
              const Center(child: CircularProgressIndicator(color: Colors.white)),

            // A4 overlay
            if (_capturedPath == null && _isInitialized)
              Positioned.fill(
                child: IgnorePointer(
                  child: CustomPaint(
                    painter: _A4OverlayPainter(
                      showScanEffect: false,
                    ),
                  ),
                ),
              ),

            // Scan effect on captured photo
            if (_capturedPath != null && _showScanEffect)
              Positioned.fill(
                child: IgnorePointer(
                  child: CustomPaint(
                    painter: _A4OverlayPainter(showScanEffect: true),
                  ),
                ),
              ),

            // Top instruction
            if (_capturedPath == null && _isInitialized)
              Positioned(
                top: AppSpacing.lg,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Alinea el documento y toca para capturar',
                      style: AppTypography.bodySmall.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),

            // Top bar
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(null),
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.5),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.close, color: Colors.white, size: 20),
                      ),
                    ),
                    if (_capturedPath != null)
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(_capturedPath),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'Hecho',
                            style: AppTypography.labelMedium.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),

            // Retake button when photo is captured
            if (_capturedPath != null && !_showScanEffect)
              Positioned(
                bottom: AppSpacing.xl,
                left: 0,
                right: 0,
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      if (_capturedPath != null) File(_capturedPath!).deleteSync();
                      setState(() => _capturedPath = null);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Text(
                        'Retomar',
                        style: AppTypography.labelLarge.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _A4OverlayPainter extends CustomPainter {
  final bool showScanEffect;

  _A4OverlayPainter({required this.showScanEffect});

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final docW = size.width * 0.7;
    final docH = docW * 1.414; // A4 ratio
    final rect = Rect.fromCenter(center: Offset(centerX, centerY), width: docW, height: docH);
    const cornerLen = 24.0;

    if (showScanEffect) {
      // Yellow fill
      final fillPaint = Paint()
        ..color = const Color(0xFFFFD54F).withValues(alpha: 0.25)
        ..style = PaintingStyle.fill;
      canvas.drawRRect(RRect.fromRectAndRadius(rect, const Radius.circular(4)), fillPaint);

      // Yellow border
      final borderPaint = Paint()
        ..color = const Color(0xFFFFD54F)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;
      canvas.drawRRect(RRect.fromRectAndRadius(rect, const Radius.circular(4)), borderPaint);
      return;
    }

    // Corner brackets
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.7)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    // Top-left
    canvas.drawLine(Offset(rect.left, rect.top + cornerLen), rect.topLeft, paint);
    canvas.drawLine(rect.topLeft, Offset(rect.left + cornerLen, rect.top), paint);

    // Top-right
    canvas.drawLine(Offset(rect.right - cornerLen, rect.top), rect.topRight, paint);
    canvas.drawLine(rect.topRight, Offset(rect.right, rect.top + cornerLen), paint);

    // Bottom-left
    canvas.drawLine(Offset(rect.left, rect.bottom - cornerLen), rect.bottomLeft, paint);
    canvas.drawLine(rect.bottomLeft, Offset(rect.left + cornerLen, rect.bottom), paint);

    // Bottom-right
    canvas.drawLine(Offset(rect.right - cornerLen, rect.bottom), rect.bottomRight, paint);
    canvas.drawLine(rect.bottomRight, Offset(rect.right, rect.bottom - cornerLen), paint);
  }

  @override
  bool shouldRepaint(covariant _A4OverlayPainter old) => old.showScanEffect != showScanEffect;
}
