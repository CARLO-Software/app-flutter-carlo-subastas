import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/widgets.dart';

class OverlayCaptureItem {
  final String id;
  final String title;
  final String overlayAsset;
  final String filePrefix;
  final String? exampleAsset;

  const OverlayCaptureItem({
    required this.id,
    required this.title,
    required this.overlayAsset,
    required this.filePrefix,
    this.exampleAsset,
  });
}

class OverlayCaptureParams {
  final List<OverlayCaptureItem> items;
  final bool landscape;

  const OverlayCaptureParams({
    required this.items,
    this.landscape = false,
  });
}

class OverlayCaptureScreen extends StatefulWidget {
  final OverlayCaptureParams params;

  const OverlayCaptureScreen({super.key, required this.params});

  @override
  State<OverlayCaptureScreen> createState() => _OverlayCaptureScreenState();
}

class _OverlayCaptureScreenState extends State<OverlayCaptureScreen>
    with WidgetsBindingObserver {
  CameraController? _controller;
  bool _isInitialized = false;
  bool _isCapturing = false;
  String? _errorMessage;
  String? _previewPath;
  double _minZoom = 1.0;
  double _maxZoom = 1.0;
  double _currentZoom = 1.0;
  double _baseZoom = 1.0;
  int _currentIndex = 0;
  final Map<String, String> _capturedPhotos = {};

  OverlayCaptureItem get _currentItem => widget.params.items[_currentIndex];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    if (widget.params.landscape) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    }
    _initCamera();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller?.dispose();
    if (widget.params.landscape) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    }
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
    if (!status.isGranted) {
      setState(() => _errorMessage = 'Se requiere permiso de cámara');
      return;
    }
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        setState(() => _errorMessage = 'No hay cámaras disponibles');
        return;
      }
      final back = cameras.firstWhere(
        (c) => c.lensDirection == CameraLensDirection.back,
        orElse: () => cameras.first,
      );
      _controller = CameraController(back, ResolutionPreset.high, enableAudio: false);
      await _controller!.initialize();
      _minZoom = await _controller!.getMinZoomLevel();
      _maxZoom = await _controller!.getMaxZoomLevel();
      _currentZoom = _minZoom;
      if (mounted) setState(() => _isInitialized = true);
    } catch (e) {
      setState(() => _errorMessage = 'Error al inicializar la cámara: $e');
    }
  }

  Future<void> _takePhoto() async {
    if (_controller == null || !_controller!.value.isInitialized || _isCapturing) return;
    setState(() => _isCapturing = true);
    try {
      final photo = await _controller!.takePicture();
      final dir = await getApplicationDocumentsDirectory();
      final name = '${_currentItem.filePrefix}_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final saved = '${dir.path}/$name';
      await File(photo.path).copy(saved);
      if (mounted) setState(() { _isCapturing = false; _previewPath = saved; });
    } catch (_) {
      if (mounted) setState(() => _isCapturing = false);
    }
  }

  void _accept() {
    if (_previewPath == null) return;
    _capturedPhotos[_currentItem.id] = _previewPath!;

    if (_currentIndex < widget.params.items.length - 1) {
      setState(() {
        _currentIndex++;
        _previewPath = null;
      });
    } else {
      Navigator.of(context).pop(_capturedPhotos);
    }
  }

  void _retake() {
    if (_previewPath != null) File(_previewPath!).deleteSync();
    setState(() => _previewPath = null);
  }

  void _showExamplePanel() {
    final asset = _currentItem.exampleAsset;
    if (asset == null) return;
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Cerrar ejemplo',
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 250),
      pageBuilder: (ctx, anim, secAnim) => const SizedBox.shrink(),
      transitionBuilder: (ctx, anim, secAnim, child) {
        final slideAnim = Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).animate(CurvedAnimation(parent: anim, curve: Curves.easeOutCubic));
        return SlideTransition(
          position: slideAnim,
          child: Align(
            alignment: Alignment.centerRight,
            child: Material(
              color: const Color(0xFF1A1A1A),
              child: SafeArea(
                child: SizedBox(
                  width: MediaQuery.of(ctx).size.width * 0.65,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Ejemplo',
                                style: AppTypography.titleMedium.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => Navigator.of(ctx).pop(),
                              child: const Icon(Icons.close, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                          child: ClipRRect(
                            borderRadius: AppSpacing.borderRadiusMd,
                            child: Image.asset(asset, fit: BoxFit.contain),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        child: Text(
                          'Foto de referencia',
                          style: AppTypography.bodySmall.copyWith(color: Colors.white70),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _previewPath != null ? _buildReview() : _buildCamera(),
    );
  }

  static const double _panelWidth = 90.0;
  static const Color _panelColor = Color(0xFF2A2A2A);

  Widget _buildCamera() {
    final item = _currentItem;
    final params = widget.params;
    return Stack(
      children: [
        if (_errorMessage != null)
          Center(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: AppColors.error, size: 64),
                  AppSpacing.vGapMd,
                  Text(_errorMessage!, style: const TextStyle(color: Colors.white), textAlign: TextAlign.center),
                  AppSpacing.vGapLg,
                  PrimaryButton(text: 'Intentar de Nuevo', onPressed: _initCamera),
                ],
              ),
            ),
          )
        else if (!_isInitialized)
          const Center(child: CircularProgressIndicator(color: Colors.white))
        else ...[
          Positioned.fill(
            child: GestureDetector(
              onScaleStart: (_) => _baseZoom = _currentZoom,
              onScaleUpdate: (d) {
                final z = (_baseZoom * d.scale).clamp(_minZoom, _maxZoom);
                if (z != _currentZoom) { _currentZoom = z; _controller?.setZoomLevel(z); }
              },
              child: CameraPreview(_controller!),
            ),
          ),
          Positioned(
            top: 0, bottom: 0, left: _panelWidth, right: _panelWidth,
            child: IgnorePointer(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Opacity(
                        opacity: 0.55,
                        child: Image.asset(item.overlayAsset, fit: BoxFit.contain),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: AppSpacing.md),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(item.title, style: AppTypography.labelMedium.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ),
        ],
        // Left panel — Salir
        Positioned(
          top: 0, bottom: 0, left: 0,
          child: Container(
            width: _panelWidth,
            color: _panelColor,
            child: Column(
              children: [
                const SizedBox(height: AppSpacing.lg),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                    child: Text('Salir', style: AppTypography.labelMedium.copyWith(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Right panel — Ejemplo + botón + contador
        Positioned(
          top: 0, bottom: 0, right: 0,
          child: Container(
            width: _panelWidth,
            color: _panelColor,
            child: Column(
              children: [
                const SizedBox(height: AppSpacing.lg),
                if (item.exampleAsset != null)
                  GestureDetector(
                    onTap: _showExamplePanel,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                      child: Text('Ejemplo', style: AppTypography.labelMedium.copyWith(color: Colors.white)),
                    ),
                  ),
                const Spacer(),
                if (_isInitialized) ...[
                  GestureDetector(
                    onTap: _isCapturing ? null : _takePhoto,
                    child: Container(
                      width: 68, height: 68,
                      decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 4)),
                      child: Center(
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 100),
                          width: _isCapturing ? 46 : 56,
                          height: _isCapturing ? 46 : 56,
                          decoration: BoxDecoration(color: _isCapturing ? AppColors.error : Colors.white, shape: BoxShape.circle),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    '${_currentIndex + 1} de ${params.items.length}',
                    style: AppTypography.labelSmall.copyWith(color: Colors.white70),
                  ),
                ],
                const Spacer(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReview() {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(color: Colors.black),
        Center(child: Image.file(File(_previewPath!), fit: BoxFit.contain)),
        Positioned(
          top: 0, left: 0, right: 0,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.black.withValues(alpha: 0.7), Colors.transparent]),
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Row(
                  children: [
                    const Icon(Icons.photo_camera_outlined, color: Colors.white, size: 22),
                    AppSpacing.hGapSm,
                    Text(_currentItem.title, style: AppTypography.titleMedium.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                      decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(14)),
                      child: Text('Revisa tu foto', style: AppTypography.labelSmall.copyWith(color: Colors.white70)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0, left: 0, right: 0,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.bottomCenter, end: Alignment.topCenter, colors: [Colors.black.withValues(alpha: 0.8), Colors.transparent]),
            ),
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl, vertical: AppSpacing.md),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: _retake,
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(border: Border.all(color: Colors.white, width: 2), borderRadius: BorderRadius.circular(25)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.refresh, color: Colors.white, size: 20),
                              const SizedBox(width: 8),
                              Text('Retomar', style: AppTypography.labelLarge.copyWith(color: Colors.white)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: GestureDetector(
                        onTap: _accept,
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(color: AppColors.success, borderRadius: BorderRadius.circular(25)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.check, color: Colors.white, size: 20),
                              const SizedBox(width: 8),
                              Text('Usar foto', style: AppTypography.labelLarge.copyWith(color: Colors.white)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
