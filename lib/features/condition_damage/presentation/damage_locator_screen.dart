import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';

class DamageLocatorScreen extends StatefulWidget {
  final String photoPath;
  final String damageType;

  const DamageLocatorScreen({
    super.key,
    required this.photoPath,
    required this.damageType,
  });

  @override
  State<DamageLocatorScreen> createState() => _DamageLocatorScreenState();
}

class _DamageLocatorScreenState extends State<DamageLocatorScreen> {
  int _currentViewIndex = 0;
  String? _selectedZoneId;
  String? _selectedSize;
  bool _showSizePicker = false;
  bool _showPhotoReview = false;

  static const _accentPurple = Color(0xFF7C4DFF);

  // defaultZoom: car occupies ~55% of frontal/rear viewBox, ~85% of lateral
  static const _views = [
    _VehicleView(
      id: 'frontal',
      name: 'Frontal',
      svgAsset: 'assets/images/plantillas/siluetas_blanco/exterior/svg/exterior-frontal.svg',
      zones: _frontalZones,
      defaultZoom: 1.75,
    ),
    _VehicleView(
      id: 'trasera',
      name: 'Trasera',
      svgAsset: 'assets/images/plantillas/siluetas_blanco/exterior/svg/exterior-trasera.svg',
      zones: _rearZones,
      defaultZoom: 1.75,
    ),
    _VehicleView(
      id: 'lateral_izq',
      name: 'Lateral Izq.',
      svgAsset: 'assets/images/plantillas/siluetas_blanco/exterior/svg/exterior-lateral-izquierdo.svg',
      zones: _leftSideZones,
      defaultZoom: 1.15,
    ),
    _VehicleView(
      id: 'lateral_der',
      name: 'Lateral Der.',
      svgAsset: 'assets/images/plantillas/siluetas_blanco/exterior/svg/exterior-lateral-derecho.svg',
      zones: _rightSideZones,
      defaultZoom: 1.15,
    ),
  ];

  // --- FRONTAL VIEW ZONES (viewBox 2880x1620) ---
  static const _frontalZones = [
    _Zone('parrilla', 'Parrilla', [1130,838, 1750,838, 1690,928, 1190,928]),
    _Zone('parabrisas', 'Parabrisas', [1050,380, 1440,310, 1830,380, 1960,640, 920,640]),
    _Zone('faro_izq', 'Faro izquierdo', [690,500, 920,500, 920,650, 690,650]),
    _Zone('faro_der', 'Faro derecho', [1960,500, 2190,500, 2190,650, 1960,650]),
    _Zone('capo', 'Capó', [920,640, 1960,640, 1750,838, 1130,838]),
    _Zone('guardafango_izq', 'Guardafango izquierdo', [690,650, 920,640, 1130,838, 826,900, 690,900]),
    _Zone('guardafango_der', 'Guardafango derecho', [1960,640, 2190,650, 2190,900, 2054,900, 1750,838]),
    _Zone('parachoques', 'Parachoques', [690,900, 2190,900, 2190,1100, 690,1100]),
    _Zone('faldon', 'Faldón inferior', [690,1100, 2190,1100, 2190,1170, 690,1170]),
  ];

  // --- REAR VIEW ZONES (viewBox 2880x1620) ---
  static const _rearZones = [
    _Zone('luneta', 'Luneta trasera', [1060,320, 1440,280, 1820,320, 1920,590, 960,590]),
    _Zone('faro_t_izq', 'Faro trasero izq.', [720,490, 960,490, 960,630, 720,630]),
    _Zone('faro_t_der', 'Faro trasero der.', [1920,490, 2160,490, 2160,630, 1920,630]),
    _Zone('maletero', 'Maletero', [960,590, 1920,590, 1770,838, 1110,838]),
    _Zone('guardaf_t_izq', 'Guardafango trasero izq.', [720,630, 960,630, 1110,838, 830,900, 720,900]),
    _Zone('guardaf_t_der', 'Guardafango trasero der.', [1920,630, 2160,630, 2160,900, 2050,900, 1770,838]),
    _Zone('parachoque_t', 'Parachoques trasero', [720,900, 2160,900, 2160,1100, 720,1100]),
    _Zone('faldon_t', 'Faldón trasero', [720,1100, 2160,1100, 2160,1170, 720,1170]),
  ];

  // --- LEFT SIDE ZONES (viewBox 2880x1620, from SVG coords) ---
  // Ref: wheels at (656,1041) and (2142,1041), A-pillar ~x=984, B-pillar ~x=1740, C-pillar ~x=2100
  static const _leftSideZones = [
    _Zone('techo_l', 'Techo', [1190,440, 2020,440, 2100,690, 1190,636]),
    _Zone('parabrisas_l', 'Parabrisas', [984,540, 1190,440, 1190,636, 984,700]),
    _Zone('luneta_l', 'Luneta trasera', [2020,440, 2360,630, 2100,690, 2020,690]),
    _Zone('capo_l', 'Capó', [282,760, 984,540, 984,700, 282,812]),
    _Zone('puerta_del_l', 'Puerta delantera', [984,700, 1740,685, 1740,870, 984,870]),
    _Zone('puerta_tra_l', 'Puerta trasera', [1740,685, 2100,690, 2100,870, 1740,870]),
    _Zone('guardaf_del_l', 'Guardafango delantero', [282,812, 500,812, 500,920, 282,920]),
    _Zone('guardaf_tra_l', 'Guardafango trasero', [2100,690, 2630,690, 2630,920, 2100,870]),
    _Zone('faldon_l', 'Faldón lateral', [500,870, 1960,870, 1960,1000, 500,1000]),
    _Zone('rueda_del_l', 'Rueda delantera', [478,860, 836,860, 836,1220, 478,1220]),
    _Zone('rueda_tra_l', 'Rueda trasera', [1964,860, 2322,860, 2322,1220, 1964,1220]),
  ];

  // --- RIGHT SIDE ZONES (mirrored: x' = 2880 - x) ---
  // Ref: wheels at (2224,1041) and (738,1041), A-pillar ~x=1896, B-pillar ~x=1140, C-pillar ~x=780
  static const _rightSideZones = [
    _Zone('techo_r', 'Techo', [780,690, 860,440, 1690,440, 1690,636]),
    _Zone('parabrisas_r', 'Parabrisas', [1690,636, 1690,440, 1896,540, 1896,700]),
    _Zone('luneta_r', 'Luneta trasera', [520,630, 860,440, 860,690, 780,690]),
    _Zone('capo_r', 'Capó', [1896,700, 1896,540, 2598,760, 2598,812]),
    _Zone('puerta_del_r', 'Puerta delantera', [1140,685, 1896,700, 1896,870, 1140,870]),
    _Zone('puerta_tra_r', 'Puerta trasera', [780,690, 1140,685, 1140,870, 780,870]),
    _Zone('guardaf_del_r', 'Guardafango delantero', [2380,812, 2598,812, 2598,920, 2380,920]),
    _Zone('guardaf_tra_r', 'Guardafango trasero', [250,690, 780,690, 780,870, 250,920]),
    _Zone('faldon_r', 'Faldón lateral', [920,870, 2380,870, 2380,1000, 920,1000]),
    _Zone('rueda_del_r', 'Rueda delantera', [2044,860, 2402,860, 2402,1220, 2044,1220]),
    _Zone('rueda_tra_r', 'Rueda trasera', [558,860, 916,860, 916,1220, 558,1220]),
  ];

  static const _sizes = [
    _DamageSize('small', 'Pequeño', '6 - 8 cm'),
    _DamageSize('medium', 'Mediano', '8 - 12 cm'),
    _DamageSize('large', 'Grande', 'Más de 12 cm'),
  ];

  _VehicleView get _currentView => _views[_currentViewIndex];
  _Zone? get _selectedZone {
    if (_selectedZoneId == null) return null;
    try {
      return _currentView.zones.firstWhere((z) => z.id == _selectedZoneId);
    } catch (_) {
      return null;
    }
  }

  void _onTapZone(Offset localPosition, Size widgetSize) {
    final view = _currentView;
    const vbW = 2880.0;
    const vbH = 1620.0;

    final scale = widgetSize.width / vbW;
    final yOffset = (widgetSize.height - vbH * scale) / 2;

    for (final zone in view.zones) {
      final path = _buildZonePath(zone, scale, yOffset);
      if (path.contains(localPosition)) {
        setState(() => _selectedZoneId = zone.id);
        return;
      }
    }
  }

  Path _buildZonePath(_Zone zone, double scale, double yOffset) {
    final path = Path();
    final pts = zone.rawPoints;
    path.moveTo(pts[0] * scale, pts[1] * scale + yOffset);
    for (var i = 2; i < pts.length; i += 2) {
      path.lineTo(pts[i] * scale, pts[i + 1] * scale + yOffset);
    }
    path.close();
    return path;
  }

  void _confirmLocation() {
    setState(() => _showSizePicker = true);
  }

  void _confirmSize() {
    setState(() {
      _showSizePicker = false;
      _showPhotoReview = true;
    });
  }

  void _finish() {
    Navigator.of(context).pop({
      'zoneId': _selectedZoneId,
      'zoneName': _selectedZone?.name,
      'size': _selectedSize,
      'photoPath': widget.photoPath,
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_showPhotoReview) return _buildPhotoReview();
    return _buildLocator();
  }

  Widget _buildLocator() {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        foregroundColor: Colors.white,
        title: const Text('Ubicación del daño'),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              // Selected zone chip centered at top
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: _selectedZone != null ? 40 : 28,
                alignment: Alignment.center,
                child: _selectedZone != null
                    ? Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                        decoration: BoxDecoration(
                          color: _accentPurple.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: _accentPurple),
                        ),
                        child: Text(
                          _selectedZone!.name,
                          style: AppTypography.labelMedium.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      )
                    : Text(
                        'Toca para marcar · Pellizca para ampliar',
                        style: AppTypography.bodySmall.copyWith(color: Colors.white38),
                      ),
              ),
              // SVG + zones — scaled to fill width with car
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final size = Size(constraints.maxWidth, constraints.maxHeight);
                    final zoom = _currentView.defaultZoom;
                    return InteractiveViewer(
                      minScale: 1.0,
                      maxScale: 4.0,
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTapUp: (details) {
                          final center = Offset(size.width / 2, size.height / 2);
                          final pos = details.localPosition;
                          final adjusted = Offset(
                            (pos.dx - center.dx) / zoom + center.dx,
                            (pos.dy - center.dy) / zoom + center.dy,
                          );
                          _onTapZone(adjusted, size);
                        },
                        child: ClipRect(
                          child: Transform.scale(
                            scale: zoom,
                            child: SizedBox(
                              width: size.width,
                              height: size.height,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  SvgPicture.asset(
                                    _currentView.svgAsset,
                                    width: size.width,
                                    fit: BoxFit.fitWidth,
                                  ),
                                  CustomPaint(
                                    size: size,
                                    painter: _ZonePainter(
                                      zones: _currentView.zones,
                                      selectedZoneId: _selectedZoneId,
                                      viewBoxWidth: 2880,
                                      viewBoxHeight: 1620,
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
                ),
              ),
              // View selector cards with SVG thumbnails
              Container(
                color: const Color(0xFF222222),
                child: SafeArea(
                  top: false,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 72,
                        child: Row(
                          children: _views.asMap().entries.map((entry) {
                            final i = entry.key;
                            final view = entry.value;
                            final selected = i == _currentViewIndex;
                            return Expanded(
                              child: GestureDetector(
                                onTap: () => setState(() {
                                  _currentViewIndex = i;
                                  _selectedZoneId = null;
                                }),
                                child: Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: selected ? _accentPurple.withValues(alpha: 0.15) : Colors.transparent,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: selected ? _accentPurple : Colors.white12,
                                      width: selected ? 2 : 1,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        view.svgAsset,
                                        width: 50,
                                        height: 28,
                                        fit: BoxFit.contain,
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        view.name,
                                        style: AppTypography.labelSmall.copyWith(
                                          color: selected ? Colors.white : Colors.white54,
                                          fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                                          fontSize: 9,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      // Confirm button
                      Padding(
                        padding: const EdgeInsets.fromLTRB(AppSpacing.lg, 0, AppSpacing.lg, AppSpacing.md),
                        child: SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: _selectedZoneId != null ? _confirmLocation : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _accentPurple,
                              disabledBackgroundColor: _accentPurple.withValues(alpha: 0.3),
                              foregroundColor: Colors.white,
                              disabledForegroundColor: Colors.white54,
                              elevation: 0,
                              shape: RoundedRectangleBorder(borderRadius: AppSpacing.borderRadiusXl),
                            ),
                            child: Text('Confirmar ubicación', style: AppTypography.button.copyWith(color: Colors.white)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          if (_showSizePicker) _buildSizePicker(),
        ],
      ),
    );
  }

  Widget _buildSizePicker() {
    return GestureDetector(
      onTap: () => setState(() => _showSizePicker = false),
      child: Container(
        color: Colors.black54,
        child: Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () {},
            child: Container(
              width: MediaQuery.of(context).size.width * 0.75,
              height: double.infinity,
              color: const Color(0xFF1E1E1E),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppSpacing.vGapLg,
                      Text(
                        '¿Qué tan grande es el daño?',
                        style: AppTypography.titleLarge.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      AppSpacing.vGapSm,
                      Text(
                        widget.damageType,
                        style: AppTypography.bodyMedium.copyWith(color: Colors.white54),
                      ),
                      AppSpacing.vGapXxl,
                      ..._sizes.map((size) {
                        final selected = _selectedSize == size.id;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: AppSpacing.md),
                          child: GestureDetector(
                            onTap: () => setState(() => _selectedSize = size.id),
                            child: Row(
                              children: [
                                Container(
                                  width: 28, height: 28,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: selected ? _accentPurple : Colors.white38,
                                      width: 2,
                                    ),
                                    color: selected ? _accentPurple : Colors.transparent,
                                  ),
                                  child: selected
                                      ? const Icon(Icons.check, size: 16, color: Colors.white)
                                      : null,
                                ),
                                const SizedBox(width: 14),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      size.label,
                                      style: AppTypography.titleSmall.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      size.description,
                                      style: AppTypography.bodySmall.copyWith(color: Colors.white54),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                      const Spacer(),
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: _selectedSize != null ? _confirmSize : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _accentPurple,
                            disabledBackgroundColor: _accentPurple.withValues(alpha: 0.3),
                            foregroundColor: Colors.white,
                            disabledForegroundColor: Colors.white54,
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: AppSpacing.borderRadiusXl),
                          ),
                          child: Text('Siguiente', style: AppTypography.button.copyWith(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPhotoReview() {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text(widget.damageType),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: InteractiveViewer(minScale: 1.0, maxScale: 5.0, child: Image.file(File(widget.photoPath), fit: BoxFit.contain)),
            ),
          ),
          if (_selectedZone != null || _selectedSize != null)
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              color: const Color(0xFF1E1E1E),
              child: Row(
                children: [
                  if (_selectedZone != null)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: _accentPurple.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        _selectedZone!.name,
                        style: AppTypography.labelMedium.copyWith(color: Colors.white),
                      ),
                    ),
                  const SizedBox(width: 8),
                  if (_selectedSize != null)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        _sizes.firstWhere((s) => s.id == _selectedSize).label,
                        style: AppTypography.labelMedium.copyWith(color: Colors.white70),
                      ),
                    ),
                ],
              ),
            ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() {
                        _showPhotoReview = false;
                        _selectedZoneId = null;
                        _selectedSize = null;
                        _showSizePicker = false;
                      }),
                      child: Container(
                        height: 56,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 2),
                          borderRadius: AppSpacing.borderRadiusXl,
                        ),
                        child: Center(
                          child: Text(
                            'Tomar otra foto',
                            style: AppTypography.button.copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: SizedBox(
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _finish,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _accentPurple,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: AppSpacing.borderRadiusXl),
                        ),
                        child: Text('Confirmar', style: AppTypography.button.copyWith(color: Colors.white)),
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

// --- Data classes ---

class _VehicleView {
  final String id;
  final String name;
  final String svgAsset;
  final List<_Zone> zones;
  final double defaultZoom;
  const _VehicleView({required this.id, required this.name, required this.svgAsset, required this.zones, this.defaultZoom = 1.0});
}

class _Zone {
  final String id;
  final String name;
  final List<double> rawPoints; // [x1,y1, x2,y2, ...] in viewBox coords
  const _Zone(this.id, this.name, this.rawPoints);
}

class _DamageSize {
  final String id;
  final String label;
  final String description;
  const _DamageSize(this.id, this.label, this.description);
}

// --- Zone painter ---

class _ZonePainter extends CustomPainter {
  final List<_Zone> zones;
  final String? selectedZoneId;
  final double viewBoxWidth;
  final double viewBoxHeight;

  _ZonePainter({
    required this.zones,
    required this.selectedZoneId,
    required this.viewBoxWidth,
    required this.viewBoxHeight,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (selectedZoneId == null) return;

    final scale = size.width / viewBoxWidth;
    final scaledH = viewBoxHeight * scale;
    final yOffset = (size.height - scaledH) / 2;

    for (final zone in zones) {
      if (zone.id != selectedZoneId) continue;

      final path = Path();
      final pts = zone.rawPoints;
      path.moveTo(pts[0] * scale, pts[1] * scale + yOffset);
      for (var i = 2; i < pts.length; i += 2) {
        path.lineTo(pts[i] * scale, pts[i + 1] * scale + yOffset);
      }
      path.close();

      // Fill
      canvas.drawPath(
        path,
        Paint()
          ..color = const Color(0x55B388FF)
          ..style = PaintingStyle.fill,
      );
      // Border
      canvas.drawPath(
        path,
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2,
      );
      // Dot at center
      final bounds = path.getBounds();
      canvas.drawCircle(
        bounds.center,
        6,
        Paint()..color = Colors.white,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _ZonePainter oldDelegate) =>
      oldDelegate.selectedZoneId != selectedZoneId;
}
