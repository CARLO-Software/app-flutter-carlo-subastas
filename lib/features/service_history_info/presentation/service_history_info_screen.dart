import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/providers/providers.dart';

const _cards = [
  {
    'icon': Icons.menu_book_outlined,
    'title': 'Libro de servicio',
    'sub': 'Sellado por talleres, generalmente guardado en la guantera',
  },
  {
    'icon': Icons.language_outlined,
    'title': 'En línea',
    'sub': 'Algunos sitios del fabricante guardan registros, usualmente para coches más nuevos',
  },
  {
    'icon': Icons.dashboard_outlined,
    'title': 'Tablero del coche',
    'sub': 'Los coches más nuevos pueden mostrar registros en la pantalla integrada',
  },
  {
    'icon': Icons.support_agent_outlined,
    'title': 'Servicio al cliente',
    'sub': 'Generalmente puedes solicitarlo a tu distribuidor o fabricante principal',
  },
];

class ServiceHistoryInfoScreen extends ConsumerWidget {
  const ServiceHistoryInfoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = context.colors;

    return Scaffold(
      backgroundColor: c.background,
      appBar: AppBar(
        title: const Text('Historial de servicio'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '¿Dónde encontrar tu historial de servicio?',
                    style: AppTypography.titleLarge.copyWith(
                      color: c.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  AppSpacing.vGapXs,
                  Text(
                    'Hay varios lugares donde puedes encontrarlo, dependiendo de tu coche.',
                    style: AppTypography.bodyMedium.copyWith(
                      color: c.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  AppSpacing.vGapLg,
                  ..._cards.map((card) {
                    final icon = card['icon'] as IconData;
                    final title = card['title'] as String;
                    final sub = card['sub'] as String;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(AppSpacing.md),
                        decoration: BoxDecoration(
                          color: c.surfaceVariant,
                          borderRadius: AppSpacing.borderRadiusLg,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    title,
                                    style: AppTypography.bodyMedium.copyWith(
                                      color: c.textPrimary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    sub,
                                    style: AppTypography.bodySmall.copyWith(
                                      color: c.textTertiary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: AppSpacing.md),
                            Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                color: c.surfaceVariant,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(icon, color: c.textSecondary, size: 24),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
          Container(
            color: c.background,
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      ref.read(vehicleRegistrationProvider.notifier).markServiceHistoryInfoSeen();
                      context.push(AppRoutes.serviceHistoryUpload);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: AppSpacing.borderRadiusXl,
                      ),
                    ),
                    child: Text(
                      'Continuar',
                      style: AppTypography.button.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
