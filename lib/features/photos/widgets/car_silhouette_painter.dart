import 'package:flutter/material.dart';
import '../../../models/photo_position.dart';

class CarSilhouettePainter extends CustomPainter {
  final PhotoAngle angle;
  final Color color;
  final double strokeWidth;

  CarSilhouettePainter({
    required this.angle,
    required this.color,
    this.strokeWidth = 2.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    switch (angle) {
      case PhotoAngle.front:
        _drawFrontView(canvas, size, paint);
        break;
      case PhotoAngle.rear:
        _drawRearView(canvas, size, paint);
        break;
      case PhotoAngle.leftSide:
        _drawLeftSideView(canvas, size, paint);
        break;
      case PhotoAngle.rightSide:
        _drawRightSideView(canvas, size, paint);
        break;
      case PhotoAngle.frontLeftCorner:
        _drawFrontLeftCornerView(canvas, size, paint);
        break;
      case PhotoAngle.frontRightCorner:
        _drawFrontRightCornerView(canvas, size, paint);
        break;
      case PhotoAngle.rearLeftCorner:
        _drawRearLeftCornerView(canvas, size, paint);
        break;
      case PhotoAngle.rearRightCorner:
        _drawRearRightCornerView(canvas, size, paint);
        break;
    }
  }

  void _drawFrontView(Canvas canvas, Size size, Paint paint) {
    final path = Path();
    final w = size.width;
    final h = size.height;

    // Car body outline - front view
    path.moveTo(w * 0.12, h * 0.82);
    path.lineTo(w * 0.12, h * 0.58);
    path.quadraticBezierTo(w * 0.12, h * 0.52, w * 0.18, h * 0.48);
    path.lineTo(w * 0.22, h * 0.42);
    // A-pillar left
    path.lineTo(w * 0.28, h * 0.28);
    // Roof line
    path.quadraticBezierTo(w * 0.35, h * 0.18, w * 0.50, h * 0.17);
    path.quadraticBezierTo(w * 0.65, h * 0.18, w * 0.72, h * 0.28);
    // A-pillar right
    path.lineTo(w * 0.78, h * 0.42);
    path.lineTo(w * 0.82, h * 0.48);
    path.quadraticBezierTo(w * 0.88, h * 0.52, w * 0.88, h * 0.58);
    path.lineTo(w * 0.88, h * 0.82);
    canvas.drawPath(path, paint);

    // Wheels with rims
    canvas.drawCircle(Offset(w * 0.22, h * 0.84), w * 0.09, paint);
    canvas.drawCircle(Offset(w * 0.22, h * 0.84), w * 0.05, paint);
    canvas.drawCircle(Offset(w * 0.78, h * 0.84), w * 0.09, paint);
    canvas.drawCircle(Offset(w * 0.78, h * 0.84), w * 0.05, paint);

    // Wheel arches
    final leftArch = Path()
      ..moveTo(w * 0.10, h * 0.82)
      ..quadraticBezierTo(w * 0.22, h * 0.72, w * 0.34, h * 0.82);
    canvas.drawPath(leftArch, paint);
    final rightArch = Path()
      ..moveTo(w * 0.66, h * 0.82)
      ..quadraticBezierTo(w * 0.78, h * 0.72, w * 0.90, h * 0.82);
    canvas.drawPath(rightArch, paint);

    // Headlights with inner detail
    final headlightLeft = RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset(w * 0.24, h * 0.52), width: w * 0.14, height: h * 0.07),
      Radius.circular(w * 0.02),
    );
    canvas.drawRRect(headlightLeft, paint);
    canvas.drawCircle(Offset(w * 0.24, h * 0.52), w * 0.03, paint);

    final headlightRight = RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset(w * 0.76, h * 0.52), width: w * 0.14, height: h * 0.07),
      Radius.circular(w * 0.02),
    );
    canvas.drawRRect(headlightRight, paint);
    canvas.drawCircle(Offset(w * 0.76, h * 0.52), w * 0.03, paint);

    // Windshield
    final windshield = Path()
      ..moveTo(w * 0.30, h * 0.40)
      ..lineTo(w * 0.32, h * 0.26)
      ..quadraticBezierTo(w * 0.50, h * 0.22, w * 0.68, h * 0.26)
      ..lineTo(w * 0.70, h * 0.40)
      ..close();
    canvas.drawPath(windshield, paint);

    // Grille
    final grille = RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset(w * 0.50, h * 0.62), width: w * 0.28, height: h * 0.08),
      Radius.circular(w * 0.01),
    );
    canvas.drawRRect(grille, paint);
    // Grille lines
    for (var i = 1; i < 4; i++) {
      final x = w * (0.38 + i * 0.06);
      canvas.drawLine(Offset(x, h * 0.58), Offset(x, h * 0.66), paint);
    }

    // Hood lines
    canvas.drawLine(Offset(w * 0.35, h * 0.45), Offset(w * 0.35, h * 0.55), paint);
    canvas.drawLine(Offset(w * 0.65, h * 0.45), Offset(w * 0.65, h * 0.55), paint);

    // Front bumper
    final bumper = Path()
      ..moveTo(w * 0.15, h * 0.75)
      ..lineTo(w * 0.85, h * 0.75);
    canvas.drawPath(bumper, paint);

    // License plate area
    canvas.drawRect(
      Rect.fromCenter(center: Offset(w * 0.50, h * 0.72), width: w * 0.18, height: h * 0.05),
      paint,
    );

    // Side mirrors
    canvas.drawOval(
      Rect.fromCenter(center: Offset(w * 0.08, h * 0.42), width: w * 0.05, height: h * 0.03),
      paint,
    );
    canvas.drawOval(
      Rect.fromCenter(center: Offset(w * 0.92, h * 0.42), width: w * 0.05, height: h * 0.03),
      paint,
    );
  }

  void _drawRearView(Canvas canvas, Size size, Paint paint) {
    final path = Path();
    final w = size.width;
    final h = size.height;

    // Car body outline - rear view
    path.moveTo(w * 0.12, h * 0.82);
    path.lineTo(w * 0.12, h * 0.58);
    path.quadraticBezierTo(w * 0.12, h * 0.52, w * 0.18, h * 0.48);
    path.lineTo(w * 0.22, h * 0.42);
    // C-pillar left
    path.lineTo(w * 0.28, h * 0.28);
    // Roof line
    path.quadraticBezierTo(w * 0.35, h * 0.20, w * 0.50, h * 0.19);
    path.quadraticBezierTo(w * 0.65, h * 0.20, w * 0.72, h * 0.28);
    // C-pillar right
    path.lineTo(w * 0.78, h * 0.42);
    path.lineTo(w * 0.82, h * 0.48);
    path.quadraticBezierTo(w * 0.88, h * 0.52, w * 0.88, h * 0.58);
    path.lineTo(w * 0.88, h * 0.82);
    canvas.drawPath(path, paint);

    // Wheels with rims
    canvas.drawCircle(Offset(w * 0.22, h * 0.84), w * 0.09, paint);
    canvas.drawCircle(Offset(w * 0.22, h * 0.84), w * 0.05, paint);
    canvas.drawCircle(Offset(w * 0.78, h * 0.84), w * 0.09, paint);
    canvas.drawCircle(Offset(w * 0.78, h * 0.84), w * 0.05, paint);

    // Wheel arches
    final leftArch = Path()
      ..moveTo(w * 0.10, h * 0.82)
      ..quadraticBezierTo(w * 0.22, h * 0.72, w * 0.34, h * 0.82);
    canvas.drawPath(leftArch, paint);
    final rightArch = Path()
      ..moveTo(w * 0.66, h * 0.82)
      ..quadraticBezierTo(w * 0.78, h * 0.72, w * 0.90, h * 0.82);
    canvas.drawPath(rightArch, paint);

    // Tail lights with inner detail
    final tailLightLeft = RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset(w * 0.20, h * 0.52), width: w * 0.12, height: h * 0.10),
      Radius.circular(w * 0.02),
    );
    canvas.drawRRect(tailLightLeft, paint);
    canvas.drawLine(Offset(w * 0.15, h * 0.52), Offset(w * 0.25, h * 0.52), paint);

    final tailLightRight = RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset(w * 0.80, h * 0.52), width: w * 0.12, height: h * 0.10),
      Radius.circular(w * 0.02),
    );
    canvas.drawRRect(tailLightRight, paint);
    canvas.drawLine(Offset(w * 0.75, h * 0.52), Offset(w * 0.85, h * 0.52), paint);

    // Rear window
    final rearWindow = Path()
      ..moveTo(w * 0.30, h * 0.40)
      ..lineTo(w * 0.32, h * 0.27)
      ..quadraticBezierTo(w * 0.50, h * 0.24, w * 0.68, h * 0.27)
      ..lineTo(w * 0.70, h * 0.40)
      ..close();
    canvas.drawPath(rearWindow, paint);

    // Trunk line
    canvas.drawLine(Offset(w * 0.28, h * 0.45), Offset(w * 0.72, h * 0.45), paint);

    // Rear bumper
    final bumper = RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset(w * 0.50, h * 0.75), width: w * 0.65, height: h * 0.06),
      Radius.circular(w * 0.01),
    );
    canvas.drawRRect(bumper, paint);

    // License plate area
    canvas.drawRect(
      Rect.fromCenter(center: Offset(w * 0.50, h * 0.68), width: w * 0.18, height: h * 0.05),
      paint,
    );

    // Exhaust pipes
    canvas.drawOval(
      Rect.fromCenter(center: Offset(w * 0.30, h * 0.78), width: w * 0.06, height: h * 0.025),
      paint,
    );
    canvas.drawOval(
      Rect.fromCenter(center: Offset(w * 0.70, h * 0.78), width: w * 0.06, height: h * 0.025),
      paint,
    );

    // Rear badge/logo area
    canvas.drawCircle(Offset(w * 0.50, h * 0.58), w * 0.04, paint);
  }

  void _drawLeftSideView(Canvas canvas, Size size, Paint paint) {
    final path = Path();
    final w = size.width;
    final h = size.height;

    // Car body - side profile with curves
    path.moveTo(w * 0.04, h * 0.68);
    // Front bumper
    path.quadraticBezierTo(w * 0.02, h * 0.62, w * 0.05, h * 0.56);
    path.lineTo(w * 0.08, h * 0.52);
    // Hood
    path.lineTo(w * 0.18, h * 0.48);
    // A-pillar
    path.lineTo(w * 0.24, h * 0.28);
    // Roof
    path.quadraticBezierTo(w * 0.30, h * 0.22, w * 0.38, h * 0.21);
    path.lineTo(w * 0.62, h * 0.21);
    path.quadraticBezierTo(w * 0.70, h * 0.22, w * 0.74, h * 0.28);
    // C-pillar
    path.lineTo(w * 0.78, h * 0.42);
    // Trunk
    path.lineTo(w * 0.92, h * 0.48);
    path.lineTo(w * 0.96, h * 0.56);
    // Rear bumper
    path.quadraticBezierTo(w * 0.98, h * 0.62, w * 0.96, h * 0.68);
    canvas.drawPath(path, paint);

    // Wheels with rims and detail
    canvas.drawCircle(Offset(w * 0.18, h * 0.72), w * 0.11, paint);
    canvas.drawCircle(Offset(w * 0.18, h * 0.72), w * 0.07, paint);
    canvas.drawCircle(Offset(w * 0.18, h * 0.72), w * 0.03, paint);
    canvas.drawCircle(Offset(w * 0.82, h * 0.72), w * 0.11, paint);
    canvas.drawCircle(Offset(w * 0.82, h * 0.72), w * 0.07, paint);
    canvas.drawCircle(Offset(w * 0.82, h * 0.72), w * 0.03, paint);

    // Wheel arches
    final frontArch = Path()
      ..moveTo(w * 0.05, h * 0.68)
      ..quadraticBezierTo(w * 0.18, h * 0.58, w * 0.31, h * 0.68);
    canvas.drawPath(frontArch, paint);
    final rearArch = Path()
      ..moveTo(w * 0.69, h * 0.68)
      ..quadraticBezierTo(w * 0.82, h * 0.58, w * 0.95, h * 0.68);
    canvas.drawPath(rearArch, paint);

    // Front window
    final frontWindow = Path()
      ..moveTo(w * 0.26, h * 0.30)
      ..lineTo(w * 0.38, h * 0.24)
      ..lineTo(w * 0.38, h * 0.44)
      ..lineTo(w * 0.24, h * 0.44)
      ..close();
    canvas.drawPath(frontWindow, paint);

    // Rear window
    final rearWindow = Path()
      ..moveTo(w * 0.41, h * 0.24)
      ..lineTo(w * 0.60, h * 0.24)
      ..lineTo(w * 0.60, h * 0.44)
      ..lineTo(w * 0.41, h * 0.44)
      ..close();
    canvas.drawPath(rearWindow, paint);

    // Quarter window
    final quarterWindow = Path()
      ..moveTo(w * 0.63, h * 0.24)
      ..lineTo(w * 0.72, h * 0.30)
      ..lineTo(w * 0.72, h * 0.44)
      ..lineTo(w * 0.63, h * 0.44)
      ..close();
    canvas.drawPath(quarterWindow, paint);

    // Door line
    canvas.drawLine(Offset(w * 0.40, h * 0.44), Offset(w * 0.40, h * 0.66), paint);
    canvas.drawLine(Offset(w * 0.62, h * 0.44), Offset(w * 0.62, h * 0.66), paint);

    // Door handles
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset(w * 0.34, h * 0.50), width: w * 0.06, height: h * 0.02),
        Radius.circular(w * 0.01),
      ),
      paint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset(w * 0.56, h * 0.50), width: w * 0.06, height: h * 0.02),
        Radius.circular(w * 0.01),
      ),
      paint,
    );

    // Side mirror
    final mirror = Path()
      ..moveTo(w * 0.22, h * 0.40)
      ..lineTo(w * 0.19, h * 0.36)
      ..lineTo(w * 0.16, h * 0.36)
      ..lineTo(w * 0.16, h * 0.42)
      ..lineTo(w * 0.20, h * 0.42)
      ..close();
    canvas.drawPath(mirror, paint);

    // Body line (character line)
    canvas.drawLine(Offset(w * 0.10, h * 0.52), Offset(w * 0.90, h * 0.50), paint);

    // Headlight
    canvas.drawOval(
      Rect.fromCenter(center: Offset(w * 0.06, h * 0.54), width: w * 0.04, height: h * 0.05),
      paint,
    );

    // Tail light
    canvas.drawRect(
      Rect.fromCenter(center: Offset(w * 0.94, h * 0.52), width: w * 0.03, height: h * 0.08),
      paint,
    );
  }

  void _drawRightSideView(Canvas canvas, Size size, Paint paint) {
    final path = Path();
    final w = size.width;
    final h = size.height;

    // Car body - side profile mirrored
    path.moveTo(w * 0.96, h * 0.68);
    // Front bumper
    path.quadraticBezierTo(w * 0.98, h * 0.62, w * 0.95, h * 0.56);
    path.lineTo(w * 0.92, h * 0.52);
    // Hood
    path.lineTo(w * 0.82, h * 0.48);
    // A-pillar
    path.lineTo(w * 0.76, h * 0.28);
    // Roof
    path.quadraticBezierTo(w * 0.70, h * 0.22, w * 0.62, h * 0.21);
    path.lineTo(w * 0.38, h * 0.21);
    path.quadraticBezierTo(w * 0.30, h * 0.22, w * 0.26, h * 0.28);
    // C-pillar
    path.lineTo(w * 0.22, h * 0.42);
    // Trunk
    path.lineTo(w * 0.08, h * 0.48);
    path.lineTo(w * 0.04, h * 0.56);
    // Rear bumper
    path.quadraticBezierTo(w * 0.02, h * 0.62, w * 0.04, h * 0.68);
    canvas.drawPath(path, paint);

    // Wheels with rims and detail
    canvas.drawCircle(Offset(w * 0.82, h * 0.72), w * 0.11, paint);
    canvas.drawCircle(Offset(w * 0.82, h * 0.72), w * 0.07, paint);
    canvas.drawCircle(Offset(w * 0.82, h * 0.72), w * 0.03, paint);
    canvas.drawCircle(Offset(w * 0.18, h * 0.72), w * 0.11, paint);
    canvas.drawCircle(Offset(w * 0.18, h * 0.72), w * 0.07, paint);
    canvas.drawCircle(Offset(w * 0.18, h * 0.72), w * 0.03, paint);

    // Wheel arches
    final frontArch = Path()
      ..moveTo(w * 0.95, h * 0.68)
      ..quadraticBezierTo(w * 0.82, h * 0.58, w * 0.69, h * 0.68);
    canvas.drawPath(frontArch, paint);
    final rearArch = Path()
      ..moveTo(w * 0.31, h * 0.68)
      ..quadraticBezierTo(w * 0.18, h * 0.58, w * 0.05, h * 0.68);
    canvas.drawPath(rearArch, paint);

    // Front window
    final frontWindow = Path()
      ..moveTo(w * 0.74, h * 0.30)
      ..lineTo(w * 0.62, h * 0.24)
      ..lineTo(w * 0.62, h * 0.44)
      ..lineTo(w * 0.76, h * 0.44)
      ..close();
    canvas.drawPath(frontWindow, paint);

    // Rear window
    final rearWindow = Path()
      ..moveTo(w * 0.59, h * 0.24)
      ..lineTo(w * 0.40, h * 0.24)
      ..lineTo(w * 0.40, h * 0.44)
      ..lineTo(w * 0.59, h * 0.44)
      ..close();
    canvas.drawPath(rearWindow, paint);

    // Quarter window
    final quarterWindow = Path()
      ..moveTo(w * 0.37, h * 0.24)
      ..lineTo(w * 0.28, h * 0.30)
      ..lineTo(w * 0.28, h * 0.44)
      ..lineTo(w * 0.37, h * 0.44)
      ..close();
    canvas.drawPath(quarterWindow, paint);

    // Door line
    canvas.drawLine(Offset(w * 0.60, h * 0.44), Offset(w * 0.60, h * 0.66), paint);
    canvas.drawLine(Offset(w * 0.38, h * 0.44), Offset(w * 0.38, h * 0.66), paint);

    // Door handles
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset(w * 0.66, h * 0.50), width: w * 0.06, height: h * 0.02),
        Radius.circular(w * 0.01),
      ),
      paint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset(w * 0.44, h * 0.50), width: w * 0.06, height: h * 0.02),
        Radius.circular(w * 0.01),
      ),
      paint,
    );

    // Side mirror
    final mirror = Path()
      ..moveTo(w * 0.78, h * 0.40)
      ..lineTo(w * 0.81, h * 0.36)
      ..lineTo(w * 0.84, h * 0.36)
      ..lineTo(w * 0.84, h * 0.42)
      ..lineTo(w * 0.80, h * 0.42)
      ..close();
    canvas.drawPath(mirror, paint);

    // Body line (character line)
    canvas.drawLine(Offset(w * 0.90, h * 0.52), Offset(w * 0.10, h * 0.50), paint);

    // Headlight
    canvas.drawOval(
      Rect.fromCenter(center: Offset(w * 0.94, h * 0.54), width: w * 0.04, height: h * 0.05),
      paint,
    );

    // Tail light
    canvas.drawRect(
      Rect.fromCenter(center: Offset(w * 0.06, h * 0.52), width: w * 0.03, height: h * 0.08),
      paint,
    );
  }

  void _drawFrontLeftCornerView(Canvas canvas, Size size, Paint paint) {
    final path = Path();
    final w = size.width;
    final h = size.height;

    // 3/4 front-left view - body outline
    path.moveTo(w * 0.06, h * 0.72);
    // Rear quarter
    path.lineTo(w * 0.06, h * 0.58);
    path.lineTo(w * 0.10, h * 0.52);
    // C-pillar
    path.lineTo(w * 0.18, h * 0.32);
    // Roof
    path.quadraticBezierTo(w * 0.28, h * 0.22, w * 0.42, h * 0.20);
    path.lineTo(w * 0.58, h * 0.22);
    // A-pillar
    path.quadraticBezierTo(w * 0.68, h * 0.24, w * 0.75, h * 0.32);
    // Hood slant
    path.lineTo(w * 0.82, h * 0.42);
    // Front
    path.lineTo(w * 0.92, h * 0.48);
    path.quadraticBezierTo(w * 0.96, h * 0.52, w * 0.96, h * 0.58);
    path.lineTo(w * 0.96, h * 0.72);
    canvas.drawPath(path, paint);

    // Front wheel (larger, perspective)
    canvas.drawOval(
      Rect.fromCenter(center: Offset(w * 0.78, h * 0.74), width: w * 0.16, height: h * 0.12),
      paint,
    );
    canvas.drawOval(
      Rect.fromCenter(center: Offset(w * 0.78, h * 0.74), width: w * 0.10, height: h * 0.07),
      paint,
    );
    // Front wheel arch
    final frontArch = Path()
      ..moveTo(w * 0.68, h * 0.70)
      ..quadraticBezierTo(w * 0.78, h * 0.60, w * 0.92, h * 0.70);
    canvas.drawPath(frontArch, paint);

    // Rear wheel (smaller, perspective)
    canvas.drawOval(
      Rect.fromCenter(center: Offset(w * 0.20, h * 0.74), width: w * 0.14, height: h * 0.10),
      paint,
    );
    canvas.drawOval(
      Rect.fromCenter(center: Offset(w * 0.20, h * 0.74), width: w * 0.08, height: h * 0.06),
      paint,
    );
    // Rear wheel arch
    final rearArch = Path()
      ..moveTo(w * 0.08, h * 0.70)
      ..quadraticBezierTo(w * 0.20, h * 0.62, w * 0.32, h * 0.70);
    canvas.drawPath(rearArch, paint);

    // Headlight with detail
    final headlight = RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset(w * 0.88, h * 0.50), width: w * 0.10, height: h * 0.07),
      Radius.circular(w * 0.02),
    );
    canvas.drawRRect(headlight, paint);
    canvas.drawCircle(Offset(w * 0.88, h * 0.50), w * 0.025, paint);

    // Front grille (angled)
    final grille = Path()
      ..moveTo(w * 0.80, h * 0.54)
      ..lineTo(w * 0.92, h * 0.56)
      ..lineTo(w * 0.92, h * 0.64)
      ..lineTo(w * 0.80, h * 0.62)
      ..close();
    canvas.drawPath(grille, paint);

    // Side window
    final sideWindow = Path()
      ..moveTo(w * 0.22, h * 0.34)
      ..lineTo(w * 0.40, h * 0.24)
      ..lineTo(w * 0.52, h * 0.26)
      ..lineTo(w * 0.52, h * 0.44)
      ..lineTo(w * 0.22, h * 0.48)
      ..close();
    canvas.drawPath(sideWindow, paint);

    // Front windshield edge
    final windshield = Path()
      ..moveTo(w * 0.55, h * 0.26)
      ..lineTo(w * 0.72, h * 0.34)
      ..lineTo(w * 0.72, h * 0.46)
      ..lineTo(w * 0.55, h * 0.44)
      ..close();
    canvas.drawPath(windshield, paint);

    // Door line
    canvas.drawLine(Offset(w * 0.42, h * 0.48), Offset(w * 0.42, h * 0.68), paint);

    // Door handle
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset(w * 0.36, h * 0.52), width: w * 0.05, height: h * 0.02),
        Radius.circular(w * 0.01),
      ),
      paint,
    );

    // Side mirror
    canvas.drawOval(
      Rect.fromCenter(center: Offset(w * 0.56, h * 0.38), width: w * 0.05, height: h * 0.03),
      paint,
    );

    // Body character line
    canvas.drawLine(Offset(w * 0.12, h * 0.54), Offset(w * 0.90, h * 0.52), paint);

    // Front bumper corner
    canvas.drawLine(Offset(w * 0.75, h * 0.68), Offset(w * 0.94, h * 0.70), paint);
  }

  void _drawFrontRightCornerView(Canvas canvas, Size size, Paint paint) {
    final path = Path();
    final w = size.width;
    final h = size.height;

    // 3/4 front-right view - body outline (mirrored)
    path.moveTo(w * 0.94, h * 0.72);
    // Rear quarter
    path.lineTo(w * 0.94, h * 0.58);
    path.lineTo(w * 0.90, h * 0.52);
    // C-pillar
    path.lineTo(w * 0.82, h * 0.32);
    // Roof
    path.quadraticBezierTo(w * 0.72, h * 0.22, w * 0.58, h * 0.20);
    path.lineTo(w * 0.42, h * 0.22);
    // A-pillar
    path.quadraticBezierTo(w * 0.32, h * 0.24, w * 0.25, h * 0.32);
    // Hood slant
    path.lineTo(w * 0.18, h * 0.42);
    // Front
    path.lineTo(w * 0.08, h * 0.48);
    path.quadraticBezierTo(w * 0.04, h * 0.52, w * 0.04, h * 0.58);
    path.lineTo(w * 0.04, h * 0.72);
    canvas.drawPath(path, paint);

    // Front wheel (larger, perspective)
    canvas.drawOval(
      Rect.fromCenter(center: Offset(w * 0.22, h * 0.74), width: w * 0.16, height: h * 0.12),
      paint,
    );
    canvas.drawOval(
      Rect.fromCenter(center: Offset(w * 0.22, h * 0.74), width: w * 0.10, height: h * 0.07),
      paint,
    );
    // Front wheel arch
    final frontArch = Path()
      ..moveTo(w * 0.32, h * 0.70)
      ..quadraticBezierTo(w * 0.22, h * 0.60, w * 0.08, h * 0.70);
    canvas.drawPath(frontArch, paint);

    // Rear wheel (smaller, perspective)
    canvas.drawOval(
      Rect.fromCenter(center: Offset(w * 0.80, h * 0.74), width: w * 0.14, height: h * 0.10),
      paint,
    );
    canvas.drawOval(
      Rect.fromCenter(center: Offset(w * 0.80, h * 0.74), width: w * 0.08, height: h * 0.06),
      paint,
    );
    // Rear wheel arch
    final rearArch = Path()
      ..moveTo(w * 0.92, h * 0.70)
      ..quadraticBezierTo(w * 0.80, h * 0.62, w * 0.68, h * 0.70);
    canvas.drawPath(rearArch, paint);

    // Headlight with detail
    final headlight = RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset(w * 0.12, h * 0.50), width: w * 0.10, height: h * 0.07),
      Radius.circular(w * 0.02),
    );
    canvas.drawRRect(headlight, paint);
    canvas.drawCircle(Offset(w * 0.12, h * 0.50), w * 0.025, paint);

    // Front grille (angled)
    final grille = Path()
      ..moveTo(w * 0.20, h * 0.54)
      ..lineTo(w * 0.08, h * 0.56)
      ..lineTo(w * 0.08, h * 0.64)
      ..lineTo(w * 0.20, h * 0.62)
      ..close();
    canvas.drawPath(grille, paint);

    // Side window
    final sideWindow = Path()
      ..moveTo(w * 0.78, h * 0.34)
      ..lineTo(w * 0.60, h * 0.24)
      ..lineTo(w * 0.48, h * 0.26)
      ..lineTo(w * 0.48, h * 0.44)
      ..lineTo(w * 0.78, h * 0.48)
      ..close();
    canvas.drawPath(sideWindow, paint);

    // Front windshield edge
    final windshield = Path()
      ..moveTo(w * 0.45, h * 0.26)
      ..lineTo(w * 0.28, h * 0.34)
      ..lineTo(w * 0.28, h * 0.46)
      ..lineTo(w * 0.45, h * 0.44)
      ..close();
    canvas.drawPath(windshield, paint);

    // Door line
    canvas.drawLine(Offset(w * 0.58, h * 0.48), Offset(w * 0.58, h * 0.68), paint);

    // Door handle
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset(w * 0.64, h * 0.52), width: w * 0.05, height: h * 0.02),
        Radius.circular(w * 0.01),
      ),
      paint,
    );

    // Side mirror
    canvas.drawOval(
      Rect.fromCenter(center: Offset(w * 0.44, h * 0.38), width: w * 0.05, height: h * 0.03),
      paint,
    );

    // Body character line
    canvas.drawLine(Offset(w * 0.88, h * 0.54), Offset(w * 0.10, h * 0.52), paint);

    // Front bumper corner
    canvas.drawLine(Offset(w * 0.25, h * 0.68), Offset(w * 0.06, h * 0.70), paint);
  }

  void _drawRearLeftCornerView(Canvas canvas, Size size, Paint paint) {
    final path = Path();
    final w = size.width;
    final h = size.height;

    // 3/4 rear-left view - body outline
    path.moveTo(w * 0.04, h * 0.72);
    // Rear
    path.lineTo(w * 0.04, h * 0.58);
    path.quadraticBezierTo(w * 0.04, h * 0.52, w * 0.08, h * 0.48);
    // Trunk
    path.lineTo(w * 0.15, h * 0.38);
    // C-pillar
    path.lineTo(w * 0.22, h * 0.28);
    // Roof
    path.quadraticBezierTo(w * 0.32, h * 0.20, w * 0.48, h * 0.20);
    path.lineTo(w * 0.62, h * 0.22);
    // A-pillar
    path.quadraticBezierTo(w * 0.72, h * 0.24, w * 0.78, h * 0.32);
    // Hood
    path.lineTo(w * 0.88, h * 0.46);
    path.lineTo(w * 0.94, h * 0.52);
    path.quadraticBezierTo(w * 0.96, h * 0.56, w * 0.96, h * 0.62);
    path.lineTo(w * 0.96, h * 0.72);
    canvas.drawPath(path, paint);

    // Rear wheel (larger, closer)
    canvas.drawOval(
      Rect.fromCenter(center: Offset(w * 0.20, h * 0.74), width: w * 0.16, height: h * 0.12),
      paint,
    );
    canvas.drawOval(
      Rect.fromCenter(center: Offset(w * 0.20, h * 0.74), width: w * 0.10, height: h * 0.07),
      paint,
    );
    // Rear wheel arch
    final rearArch = Path()
      ..moveTo(w * 0.08, h * 0.70)
      ..quadraticBezierTo(w * 0.20, h * 0.60, w * 0.34, h * 0.70);
    canvas.drawPath(rearArch, paint);

    // Front wheel (smaller, far)
    canvas.drawOval(
      Rect.fromCenter(center: Offset(w * 0.80, h * 0.74), width: w * 0.14, height: h * 0.10),
      paint,
    );
    canvas.drawOval(
      Rect.fromCenter(center: Offset(w * 0.80, h * 0.74), width: w * 0.08, height: h * 0.06),
      paint,
    );
    // Front wheel arch
    final frontArch = Path()
      ..moveTo(w * 0.68, h * 0.70)
      ..quadraticBezierTo(w * 0.80, h * 0.62, w * 0.92, h * 0.70);
    canvas.drawPath(frontArch, paint);

    // Tail light with detail
    final tailLight = RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset(w * 0.10, h * 0.50), width: w * 0.08, height: h * 0.10),
      Radius.circular(w * 0.01),
    );
    canvas.drawRRect(tailLight, paint);
    canvas.drawLine(Offset(w * 0.07, h * 0.46), Offset(w * 0.13, h * 0.46), paint);
    canvas.drawLine(Offset(w * 0.07, h * 0.54), Offset(w * 0.13, h * 0.54), paint);

    // Rear window
    final rearWindow = Path()
      ..moveTo(w * 0.24, h * 0.30)
      ..lineTo(w * 0.42, h * 0.24)
      ..lineTo(w * 0.55, h * 0.26)
      ..lineTo(w * 0.55, h * 0.44)
      ..lineTo(w * 0.26, h * 0.46)
      ..close();
    canvas.drawPath(rearWindow, paint);

    // Side window
    final sideWindow = Path()
      ..moveTo(w * 0.58, h * 0.26)
      ..lineTo(w * 0.75, h * 0.34)
      ..lineTo(w * 0.75, h * 0.46)
      ..lineTo(w * 0.58, h * 0.44)
      ..close();
    canvas.drawPath(sideWindow, paint);

    // Trunk line
    canvas.drawLine(Offset(w * 0.10, h * 0.42), Offset(w * 0.20, h * 0.40), paint);

    // Door line
    canvas.drawLine(Offset(w * 0.56, h * 0.46), Offset(w * 0.56, h * 0.68), paint);

    // Door handle
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset(w * 0.62, h * 0.50), width: w * 0.05, height: h * 0.02),
        Radius.circular(w * 0.01),
      ),
      paint,
    );

    // Side mirror
    canvas.drawOval(
      Rect.fromCenter(center: Offset(w * 0.78, h * 0.38), width: w * 0.04, height: h * 0.025),
      paint,
    );

    // Body character line
    canvas.drawLine(Offset(w * 0.08, h * 0.54), Offset(w * 0.90, h * 0.52), paint);

    // Rear bumper
    canvas.drawLine(Offset(w * 0.06, h * 0.68), Offset(w * 0.30, h * 0.70), paint);

    // License plate
    canvas.drawRect(
      Rect.fromCenter(center: Offset(w * 0.14, h * 0.62), width: w * 0.10, height: h * 0.04),
      paint,
    );

    // Exhaust
    canvas.drawOval(
      Rect.fromCenter(center: Offset(w * 0.24, h * 0.72), width: w * 0.04, height: h * 0.02),
      paint,
    );
  }

  void _drawRearRightCornerView(Canvas canvas, Size size, Paint paint) {
    final path = Path();
    final w = size.width;
    final h = size.height;

    // 3/4 rear-right view - body outline (mirrored)
    path.moveTo(w * 0.96, h * 0.72);
    // Rear
    path.lineTo(w * 0.96, h * 0.58);
    path.quadraticBezierTo(w * 0.96, h * 0.52, w * 0.92, h * 0.48);
    // Trunk
    path.lineTo(w * 0.85, h * 0.38);
    // C-pillar
    path.lineTo(w * 0.78, h * 0.28);
    // Roof
    path.quadraticBezierTo(w * 0.68, h * 0.20, w * 0.52, h * 0.20);
    path.lineTo(w * 0.38, h * 0.22);
    // A-pillar
    path.quadraticBezierTo(w * 0.28, h * 0.24, w * 0.22, h * 0.32);
    // Hood
    path.lineTo(w * 0.12, h * 0.46);
    path.lineTo(w * 0.06, h * 0.52);
    path.quadraticBezierTo(w * 0.04, h * 0.56, w * 0.04, h * 0.62);
    path.lineTo(w * 0.04, h * 0.72);
    canvas.drawPath(path, paint);

    // Rear wheel (larger, closer)
    canvas.drawOval(
      Rect.fromCenter(center: Offset(w * 0.80, h * 0.74), width: w * 0.16, height: h * 0.12),
      paint,
    );
    canvas.drawOval(
      Rect.fromCenter(center: Offset(w * 0.80, h * 0.74), width: w * 0.10, height: h * 0.07),
      paint,
    );
    // Rear wheel arch
    final rearArch = Path()
      ..moveTo(w * 0.92, h * 0.70)
      ..quadraticBezierTo(w * 0.80, h * 0.60, w * 0.66, h * 0.70);
    canvas.drawPath(rearArch, paint);

    // Front wheel (smaller, far)
    canvas.drawOval(
      Rect.fromCenter(center: Offset(w * 0.20, h * 0.74), width: w * 0.14, height: h * 0.10),
      paint,
    );
    canvas.drawOval(
      Rect.fromCenter(center: Offset(w * 0.20, h * 0.74), width: w * 0.08, height: h * 0.06),
      paint,
    );
    // Front wheel arch
    final frontArch = Path()
      ..moveTo(w * 0.32, h * 0.70)
      ..quadraticBezierTo(w * 0.20, h * 0.62, w * 0.08, h * 0.70);
    canvas.drawPath(frontArch, paint);

    // Tail light with detail
    final tailLight = RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset(w * 0.90, h * 0.50), width: w * 0.08, height: h * 0.10),
      Radius.circular(w * 0.01),
    );
    canvas.drawRRect(tailLight, paint);
    canvas.drawLine(Offset(w * 0.87, h * 0.46), Offset(w * 0.93, h * 0.46), paint);
    canvas.drawLine(Offset(w * 0.87, h * 0.54), Offset(w * 0.93, h * 0.54), paint);

    // Rear window
    final rearWindow = Path()
      ..moveTo(w * 0.76, h * 0.30)
      ..lineTo(w * 0.58, h * 0.24)
      ..lineTo(w * 0.45, h * 0.26)
      ..lineTo(w * 0.45, h * 0.44)
      ..lineTo(w * 0.74, h * 0.46)
      ..close();
    canvas.drawPath(rearWindow, paint);

    // Side window
    final sideWindow = Path()
      ..moveTo(w * 0.42, h * 0.26)
      ..lineTo(w * 0.25, h * 0.34)
      ..lineTo(w * 0.25, h * 0.46)
      ..lineTo(w * 0.42, h * 0.44)
      ..close();
    canvas.drawPath(sideWindow, paint);

    // Trunk line
    canvas.drawLine(Offset(w * 0.90, h * 0.42), Offset(w * 0.80, h * 0.40), paint);

    // Door line
    canvas.drawLine(Offset(w * 0.44, h * 0.46), Offset(w * 0.44, h * 0.68), paint);

    // Door handle
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset(w * 0.38, h * 0.50), width: w * 0.05, height: h * 0.02),
        Radius.circular(w * 0.01),
      ),
      paint,
    );

    // Side mirror
    canvas.drawOval(
      Rect.fromCenter(center: Offset(w * 0.22, h * 0.38), width: w * 0.04, height: h * 0.025),
      paint,
    );

    // Body character line
    canvas.drawLine(Offset(w * 0.92, h * 0.54), Offset(w * 0.10, h * 0.52), paint);

    // Rear bumper
    canvas.drawLine(Offset(w * 0.94, h * 0.68), Offset(w * 0.70, h * 0.70), paint);

    // License plate
    canvas.drawRect(
      Rect.fromCenter(center: Offset(w * 0.86, h * 0.62), width: w * 0.10, height: h * 0.04),
      paint,
    );

    // Exhaust
    canvas.drawOval(
      Rect.fromCenter(center: Offset(w * 0.76, h * 0.72), width: w * 0.04, height: h * 0.02),
      paint,
    );
  }

  @override
  bool shouldRepaint(CarSilhouettePainter oldDelegate) {
    return oldDelegate.angle != angle ||
        oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}

class CarSilhouetteWidget extends StatelessWidget {
  final PhotoAngle angle;
  final Color color;
  final double strokeWidth;
  final double size;

  const CarSilhouetteWidget({
    super.key,
    required this.angle,
    this.color = Colors.grey,
    this.strokeWidth = 2.0,
    this.size = 64,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: CarSilhouettePainter(
          angle: angle,
          color: color,
          strokeWidth: strokeWidth,
        ),
      ),
    );
  }
}
