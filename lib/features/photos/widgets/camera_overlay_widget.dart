import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../models/photo_position.dart';

class CameraOverlayWidget extends StatelessWidget {
  final PhotoAngle angle;

  const CameraOverlayWidget({
    super.key,
    required this.angle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: Opacity(
        opacity: 0.55,
        child: Image.asset(
          AppConstants.templateForAngle(angle),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
