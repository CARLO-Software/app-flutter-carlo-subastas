import 'package:flutter/material.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';

class RotateDeviceOverlay extends StatelessWidget {
  const RotateDeviceOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withValues(alpha: 0.92),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.screen_rotation,
              color: Colors.white,
              size: 64,
            ),
            AppSpacing.vGapLg,
            Text(
              'Gire su dispositivo horizontalmente',
              style: AppTypography.titleMedium.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            AppSpacing.vGapSm,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48),
              child: Text(
                'Para mejores resultados, sostenga el teléfono en posición horizontal al tomar la foto.',
                style: AppTypography.bodySmall.copyWith(color: Colors.white70),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
