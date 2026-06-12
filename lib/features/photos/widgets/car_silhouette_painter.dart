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
    path.moveTo(w * 0.15, h * 0.85);
    path.lineTo(w * 0.15, h * 0.55);
    path.quadraticBezierTo(w * 0.15, h * 0.45, w * 0.25, h * 0.40);
    path.lineTo(w * 0.30, h * 0.25);
    path.quadraticBezierTo(w * 0.35, h * 0.15, w * 0.50, h * 0.15);
    path.quadraticBezierTo(w * 0.65, h * 0.15, w * 0.70, h * 0.25);
    path.lineTo(w * 0.75, h * 0.40);
    path.quadraticBezierTo(w * 0.85, h * 0.45, w * 0.85, h * 0.55);
    path.lineTo(w * 0.85, h * 0.85);

    // Wheels
    canvas.drawCircle(Offset(w * 0.22, h * 0.85), w * 0.08, paint);
    canvas.drawCircle(Offset(w * 0.78, h * 0.85), w * 0.08, paint);

    // Headlights
    canvas.drawOval(
      Rect.fromCenter(center: Offset(w * 0.25, h * 0.55), width: w * 0.12, height: h * 0.08),
      paint,
    );
    canvas.drawOval(
      Rect.fromCenter(center: Offset(w * 0.75, h * 0.55), width: w * 0.12, height: h * 0.08),
      paint,
    );

    // Windshield
    path.moveTo(w * 0.32, h * 0.38);
    path.lineTo(w * 0.68, h * 0.38);

    // Grille
    path.moveTo(w * 0.35, h * 0.65);
    path.lineTo(w * 0.65, h * 0.65);

    canvas.drawPath(path, paint);
  }

  void _drawRearView(Canvas canvas, Size size, Paint paint) {
    final path = Path();
    final w = size.width;
    final h = size.height;

    // Car body outline - rear view
    path.moveTo(w * 0.15, h * 0.85);
    path.lineTo(w * 0.15, h * 0.55);
    path.quadraticBezierTo(w * 0.15, h * 0.45, w * 0.25, h * 0.40);
    path.lineTo(w * 0.30, h * 0.25);
    path.quadraticBezierTo(w * 0.35, h * 0.18, w * 0.50, h * 0.18);
    path.quadraticBezierTo(w * 0.65, h * 0.18, w * 0.70, h * 0.25);
    path.lineTo(w * 0.75, h * 0.40);
    path.quadraticBezierTo(w * 0.85, h * 0.45, w * 0.85, h * 0.55);
    path.lineTo(w * 0.85, h * 0.85);

    // Wheels
    canvas.drawCircle(Offset(w * 0.22, h * 0.85), w * 0.08, paint);
    canvas.drawCircle(Offset(w * 0.78, h * 0.85), w * 0.08, paint);

    // Tail lights
    canvas.drawRect(
      Rect.fromCenter(center: Offset(w * 0.22, h * 0.55), width: w * 0.10, height: h * 0.06),
      paint,
    );
    canvas.drawRect(
      Rect.fromCenter(center: Offset(w * 0.78, h * 0.55), width: w * 0.10, height: h * 0.06),
      paint,
    );

    // Rear window
    path.moveTo(w * 0.32, h * 0.35);
    path.lineTo(w * 0.68, h * 0.35);

    // Bumper
    path.moveTo(w * 0.25, h * 0.75);
    path.lineTo(w * 0.75, h * 0.75);

    canvas.drawPath(path, paint);
  }

  void _drawLeftSideView(Canvas canvas, Size size, Paint paint) {
    final path = Path();
    final w = size.width;
    final h = size.height;

    // Car body - side profile
    path.moveTo(w * 0.05, h * 0.70);
    path.lineTo(w * 0.05, h * 0.55);
    path.lineTo(w * 0.15, h * 0.55);
    path.lineTo(w * 0.25, h * 0.30);
    path.lineTo(w * 0.70, h * 0.30);
    path.lineTo(w * 0.80, h * 0.55);
    path.lineTo(w * 0.95, h * 0.55);
    path.lineTo(w * 0.95, h * 0.70);

    // Wheels
    canvas.drawCircle(Offset(w * 0.20, h * 0.75), w * 0.10, paint);
    canvas.drawCircle(Offset(w * 0.80, h * 0.75), w * 0.10, paint);

    // Windows
    path.moveTo(w * 0.28, h * 0.32);
    path.lineTo(w * 0.45, h * 0.32);
    path.lineTo(w * 0.45, h * 0.52);
    path.lineTo(w * 0.30, h * 0.52);
    path.close();

    path.moveTo(w * 0.48, h * 0.32);
    path.lineTo(w * 0.68, h * 0.32);
    path.lineTo(w * 0.75, h * 0.52);
    path.lineTo(w * 0.48, h * 0.52);
    path.close();

    // Door handle
    path.moveTo(w * 0.50, h * 0.58);
    path.lineTo(w * 0.58, h * 0.58);

    canvas.drawPath(path, paint);
  }

  void _drawRightSideView(Canvas canvas, Size size, Paint paint) {
    final path = Path();
    final w = size.width;
    final h = size.height;

    // Car body - side profile (mirrored)
    path.moveTo(w * 0.95, h * 0.70);
    path.lineTo(w * 0.95, h * 0.55);
    path.lineTo(w * 0.85, h * 0.55);
    path.lineTo(w * 0.75, h * 0.30);
    path.lineTo(w * 0.30, h * 0.30);
    path.lineTo(w * 0.20, h * 0.55);
    path.lineTo(w * 0.05, h * 0.55);
    path.lineTo(w * 0.05, h * 0.70);

    // Wheels
    canvas.drawCircle(Offset(w * 0.80, h * 0.75), w * 0.10, paint);
    canvas.drawCircle(Offset(w * 0.20, h * 0.75), w * 0.10, paint);

    // Windows (mirrored)
    path.moveTo(w * 0.72, h * 0.32);
    path.lineTo(w * 0.55, h * 0.32);
    path.lineTo(w * 0.55, h * 0.52);
    path.lineTo(w * 0.70, h * 0.52);
    path.close();

    path.moveTo(w * 0.52, h * 0.32);
    path.lineTo(w * 0.32, h * 0.32);
    path.lineTo(w * 0.25, h * 0.52);
    path.lineTo(w * 0.52, h * 0.52);
    path.close();

    // Door handle
    path.moveTo(w * 0.50, h * 0.58);
    path.lineTo(w * 0.42, h * 0.58);

    canvas.drawPath(path, paint);
  }

  void _drawFrontLeftCornerView(Canvas canvas, Size size, Paint paint) {
    final path = Path();
    final w = size.width;
    final h = size.height;

    // 3/4 front-left view
    path.moveTo(w * 0.10, h * 0.75);
    path.lineTo(w * 0.10, h * 0.55);
    path.lineTo(w * 0.20, h * 0.55);
    path.lineTo(w * 0.30, h * 0.32);
    path.lineTo(w * 0.60, h * 0.25);
    path.lineTo(w * 0.85, h * 0.35);
    path.lineTo(w * 0.90, h * 0.55);
    path.lineTo(w * 0.90, h * 0.75);

    // Wheels
    canvas.drawOval(
      Rect.fromCenter(center: Offset(w * 0.25, h * 0.78), width: w * 0.18, height: h * 0.12),
      paint,
    );
    canvas.drawOval(
      Rect.fromCenter(center: Offset(w * 0.78, h * 0.78), width: w * 0.14, height: h * 0.10),
      paint,
    );

    // Headlight
    canvas.drawOval(
      Rect.fromCenter(center: Offset(w * 0.82, h * 0.50), width: w * 0.10, height: h * 0.08),
      paint,
    );

    // Windows
    path.moveTo(w * 0.32, h * 0.34);
    path.lineTo(w * 0.55, h * 0.28);
    path.lineTo(w * 0.55, h * 0.48);
    path.lineTo(w * 0.35, h * 0.50);
    path.close();

    canvas.drawPath(path, paint);
  }

  void _drawFrontRightCornerView(Canvas canvas, Size size, Paint paint) {
    final path = Path();
    final w = size.width;
    final h = size.height;

    // 3/4 front-right view (mirrored)
    path.moveTo(w * 0.90, h * 0.75);
    path.lineTo(w * 0.90, h * 0.55);
    path.lineTo(w * 0.80, h * 0.55);
    path.lineTo(w * 0.70, h * 0.32);
    path.lineTo(w * 0.40, h * 0.25);
    path.lineTo(w * 0.15, h * 0.35);
    path.lineTo(w * 0.10, h * 0.55);
    path.lineTo(w * 0.10, h * 0.75);

    // Wheels
    canvas.drawOval(
      Rect.fromCenter(center: Offset(w * 0.75, h * 0.78), width: w * 0.18, height: h * 0.12),
      paint,
    );
    canvas.drawOval(
      Rect.fromCenter(center: Offset(w * 0.22, h * 0.78), width: w * 0.14, height: h * 0.10),
      paint,
    );

    // Headlight
    canvas.drawOval(
      Rect.fromCenter(center: Offset(w * 0.18, h * 0.50), width: w * 0.10, height: h * 0.08),
      paint,
    );

    // Windows
    path.moveTo(w * 0.68, h * 0.34);
    path.lineTo(w * 0.45, h * 0.28);
    path.lineTo(w * 0.45, h * 0.48);
    path.lineTo(w * 0.65, h * 0.50);
    path.close();

    canvas.drawPath(path, paint);
  }

  void _drawRearLeftCornerView(Canvas canvas, Size size, Paint paint) {
    final path = Path();
    final w = size.width;
    final h = size.height;

    // 3/4 rear-left view
    path.moveTo(w * 0.10, h * 0.75);
    path.lineTo(w * 0.10, h * 0.55);
    path.lineTo(w * 0.15, h * 0.35);
    path.lineTo(w * 0.40, h * 0.25);
    path.lineTo(w * 0.70, h * 0.32);
    path.lineTo(w * 0.80, h * 0.55);
    path.lineTo(w * 0.90, h * 0.55);
    path.lineTo(w * 0.90, h * 0.75);

    // Wheels
    canvas.drawOval(
      Rect.fromCenter(center: Offset(w * 0.22, h * 0.78), width: w * 0.14, height: h * 0.10),
      paint,
    );
    canvas.drawOval(
      Rect.fromCenter(center: Offset(w * 0.75, h * 0.78), width: w * 0.18, height: h * 0.12),
      paint,
    );

    // Tail light
    canvas.drawRect(
      Rect.fromCenter(center: Offset(w * 0.18, h * 0.50), width: w * 0.08, height: h * 0.06),
      paint,
    );

    // Rear window
    path.moveTo(w * 0.42, h * 0.28);
    path.lineTo(w * 0.65, h * 0.34);
    path.lineTo(w * 0.62, h * 0.48);
    path.lineTo(w * 0.40, h * 0.45);
    path.close();

    canvas.drawPath(path, paint);
  }

  void _drawRearRightCornerView(Canvas canvas, Size size, Paint paint) {
    final path = Path();
    final w = size.width;
    final h = size.height;

    // 3/4 rear-right view (mirrored)
    path.moveTo(w * 0.90, h * 0.75);
    path.lineTo(w * 0.90, h * 0.55);
    path.lineTo(w * 0.85, h * 0.35);
    path.lineTo(w * 0.60, h * 0.25);
    path.lineTo(w * 0.30, h * 0.32);
    path.lineTo(w * 0.20, h * 0.55);
    path.lineTo(w * 0.10, h * 0.55);
    path.lineTo(w * 0.10, h * 0.75);

    // Wheels
    canvas.drawOval(
      Rect.fromCenter(center: Offset(w * 0.78, h * 0.78), width: w * 0.14, height: h * 0.10),
      paint,
    );
    canvas.drawOval(
      Rect.fromCenter(center: Offset(w * 0.25, h * 0.78), width: w * 0.18, height: h * 0.12),
      paint,
    );

    // Tail light
    canvas.drawRect(
      Rect.fromCenter(center: Offset(w * 0.82, h * 0.50), width: w * 0.08, height: h * 0.06),
      paint,
    );

    // Rear window
    path.moveTo(w * 0.58, h * 0.28);
    path.lineTo(w * 0.35, h * 0.34);
    path.lineTo(w * 0.38, h * 0.48);
    path.lineTo(w * 0.60, h * 0.45);
    path.close();

    canvas.drawPath(path, paint);
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
