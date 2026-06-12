import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../models/photo_position.dart';
import 'car_silhouette_painter.dart';

class CameraOverlayWidget extends StatelessWidget {
  final PhotoAngle angle;
  final String positionName;
  final String instructions;

  const CameraOverlayWidget({
    super.key,
    required this.angle,
    required this.positionName,
    required this.instructions,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Semi-transparent overlay with cutout
        Positioned.fill(
          child: CustomPaint(
            painter: _OverlayPainter(angle: angle),
          ),
        ),
        // Top info bar
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.7),
                  Colors.transparent,
                ],
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    positionName,
                    style: AppTypography.headlineSmall.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  AppSpacing.vGapXs,
                  Text(
                    instructions,
                    style: AppTypography.bodySmall.copyWith(
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
        // Center guide frame
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.85,
            height: MediaQuery.of(context).size.width * 0.65,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.6),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            ),
            child: Center(
              child: CarSilhouetteWidget(
                angle: angle,
                color: Colors.white.withValues(alpha: 0.4),
                strokeWidth: 3,
                size: MediaQuery.of(context).size.width * 0.55,
              ),
            ),
          ),
        ),
        // Corner guides
        _buildCornerGuide(context, Alignment.topLeft),
        _buildCornerGuide(context, Alignment.topRight),
        _buildCornerGuide(context, Alignment.bottomLeft),
        _buildCornerGuide(context, Alignment.bottomRight),
      ],
    );
  }

  Widget _buildCornerGuide(BuildContext context, Alignment alignment) {
    final screenWidth = MediaQuery.of(context).size.width;
    final frameWidth = screenWidth * 0.85;
    final frameHeight = screenWidth * 0.65;

    final horizontalOffset = (screenWidth - frameWidth) / 2;
    final verticalOffset =
        (MediaQuery.of(context).size.height - frameHeight) / 2;

    final isLeft =
        alignment == Alignment.topLeft || alignment == Alignment.bottomLeft;
    final isTop =
        alignment == Alignment.topLeft || alignment == Alignment.topRight;

    return Positioned(
      left: isLeft ? horizontalOffset - 10 : null,
      right: !isLeft ? horizontalOffset - 10 : null,
      top: isTop ? verticalOffset - 10 : null,
      bottom: !isTop ? verticalOffset - 10 : null,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          border: Border(
            top: isTop
                ? const BorderSide(color: AppColors.primary, width: 4)
                : BorderSide.none,
            bottom: !isTop
                ? const BorderSide(color: AppColors.primary, width: 4)
                : BorderSide.none,
            left: isLeft
                ? const BorderSide(color: AppColors.primary, width: 4)
                : BorderSide.none,
            right: !isLeft
                ? const BorderSide(color: AppColors.primary, width: 4)
                : BorderSide.none,
          ),
        ),
      ),
    );
  }
}

class _OverlayPainter extends CustomPainter {
  final PhotoAngle angle;

  _OverlayPainter({required this.angle});

  @override
  void paint(Canvas canvas, Size size) {
    // Light semi-transparent overlay on corners
    final paint = Paint()
      ..color = Colors.black.withValues(alpha: 0.3)
      ..style = PaintingStyle.fill;

    final frameWidth = size.width * 0.85;
    final frameHeight = size.width * 0.65;
    final left = (size.width - frameWidth) / 2;
    final top = (size.height - frameHeight) / 2;

    final path = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(left, top, frameWidth, frameHeight),
        const Radius.circular(12),
      ));

    path.fillType = PathFillType.evenOdd;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_OverlayPainter oldDelegate) => false;
}
