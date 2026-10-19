import 'package:flutter/material.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';

/// Banner de feedback en la cámara. Dos variantes visuales:
/// - isAiFeedback=true  → badge [AI] rojo, fondo rojo. La IA detectó un problema en la foto.
/// - isAiFeedback=false → badge [Error] ámbar, fondo ámbar. Error técnico (red, API, etc.)
class AiFeedbackBanner extends StatelessWidget {
  final String message;
  final String? detail;
  final bool isLoading;
  final bool isAiFeedback;

  const AiFeedbackBanner({
    super.key,
    required this.message,
    this.detail,
    this.isLoading = false,
    this.isAiFeedback = true,
  });

  Color get _badgeColor => isAiFeedback
      ? Colors.red.withValues(alpha: 0.7)
      : Colors.orange.withValues(alpha: 0.7);

  Color get _bgColor => isAiFeedback
      ? Colors.red.withValues(alpha: 0.25)
      : Colors.orange.withValues(alpha: 0.25);

  String get _badgeLabel => isAiFeedback ? 'AI' : 'Error';

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const SizedBox(
              width: 16, height: 16,
              child: CircularProgressIndicator(color: Colors.white70, strokeWidth: 2),
            ),
            const SizedBox(width: 10),
            Text('Analizando foto...', style: AppTypography.labelMedium.copyWith(color: Colors.white70)),
          ],
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: _bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: _badgeColor,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(_badgeLabel, style: AppTypography.labelSmall.copyWith(color: Colors.white, fontWeight: FontWeight.w800)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: AppTypography.labelMedium.copyWith(color: Colors.white),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (detail != null)
            GestureDetector(
              onTap: () => _showDetail(context),
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  'Más info',
                  style: AppTypography.labelMedium.copyWith(
                    color: Colors.white,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.white70,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _showDetail(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A1A1A),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: _badgeColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(_badgeLabel, style: AppTypography.labelSmall.copyWith(color: Colors.white, fontWeight: FontWeight.w800)),
                ),
                const SizedBox(width: 10),
                Text(
                  isAiFeedback ? 'Resultado del análisis' : 'Detalle del error',
                  style: AppTypography.titleMedium.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              detail ?? message,
              style: AppTypography.bodyMedium.copyWith(color: Colors.white70, height: 1.5),
            ),
            const SizedBox(height: AppSpacing.lg),
          ],
        ),
      ),
    );
  }
}
