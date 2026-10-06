import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';

class NotificationPermissionScreen extends StatelessWidget {
  const NotificationPermissionScreen({super.key});

  Future<void> _requestPermission(BuildContext context) async {
    await Permission.notification.request();
    if (context.mounted) context.go(AppRoutes.dashboard);
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Scaffold(
      backgroundColor: c.background,
      body: SafeArea(
        child: Padding(
          padding: AppSpacing.screenPadding,
          child: Column(
            children: [
              const Spacer(),
              // Phone mockup illustration
              Container(
                width: 200,
                height: 340,
                decoration: BoxDecoration(
                  color: c.surfaceVariant,
                  borderRadius: AppSpacing.borderRadiusXl,
                  border: Border.all(color: c.border, width: 3),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.directions_car_outlined,
                      size: 64,
                      color: c.textTertiary,
                    ),
                    AppSpacing.vGapMd,
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.sm,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: AppSpacing.borderRadiusMd,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'S/',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          AppSpacing.hGapSm,
                          Icon(
                            Icons.message_outlined,
                            color: Colors.white.withValues(alpha: 0.8),
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Text(
                'Recibe alertas sobre tu venta',
                style: AppTypography.headlineSmall,
                textAlign: TextAlign.center,
              ),
              AppSpacing.vGapMd,
              Text(
                'Solo te notificaremos sobre el vehículo que estás vendiendo para que recibas al instante las actualizaciones importantes.',
                style: AppTypography.bodyMedium.copyWith(
                  color: c.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              AppSpacing.vGapXl,
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () => _requestPermission(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF292929),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: AppSpacing.borderRadiusMd,
                    ),
                  ),
                  child: Text('Aceptar',
                      style: AppTypography.button
                          .copyWith(color: Colors.white)),
                ),
              ),
              AppSpacing.vGapSm,
              SizedBox(
                width: double.infinity,
                height: 56,
                child: OutlinedButton(
                  onPressed: () => context.go(AppRoutes.dashboard),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: c.textPrimary,
                    side: BorderSide(color: c.border),
                    shape: RoundedRectangleBorder(
                      borderRadius: AppSpacing.borderRadiusMd,
                    ),
                  ),
                  child: Text('No', style: AppTypography.button),
                ),
              ),
              AppSpacing.vGapLg,
            ],
          ),
        ),
      ),
    );
  }
}
