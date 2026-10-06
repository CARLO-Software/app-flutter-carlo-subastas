import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/providers/providers.dart';

class EstimatedPriceScreen extends ConsumerWidget {
  const EstimatedPriceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = context.colors;
    final vehicle = ref.watch(vehicleProvider);
    final formatter = NumberFormat('#,###', 'es_PE');
    final price = vehicle?.estimatedPrice ?? 0;

    return Scaffold(
      backgroundColor: c.background,
      body: SafeArea(
        child: Padding(
          padding: AppSpacing.screenPadding,
          child: Column(
            children: [
              const Spacer(),

              // Price result
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  color: c.surfaceVariant,
                  borderRadius: AppSpacing.borderRadiusLg,
                ),
                child: Column(
                  children: [
                    Text(
                      'Tu precio estimado de venta',
                      style: AppTypography.bodyMedium.copyWith(
                        color: c.textSecondary,
                      ),
                    ),
                    AppSpacing.vGapSm,
                    Text(
                      'S/ ${formatter.format(price.round())}',
                      style: AppTypography.headlineLarge.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    AppSpacing.vGapSm,
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        'Saber más',
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.primary,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              AppSpacing.vGapXl,

              // Benefits
              Row(
                children: [
                  Expanded(
                    child: _buildBenefitItem(
                      Icons.local_shipping_outlined,
                      'Recogida a\ndomicilio',
                      c,
                    ),
                  ),
                  Expanded(
                    child: _buildBenefitItem(
                      Icons.flash_on_outlined,
                      'Pago\nrápido',
                      c,
                    ),
                  ),
                  Expanded(
                    child: _buildBenefitItem(
                      Icons.money_off_outlined,
                      'Sin\ncomisiones',
                      c,
                    ),
                  ),
                ],
              ),

              AppSpacing.vGapLg,

              Text(
                '* Sujeto al estado del vehículo y a su historial de mantenimiento',
                style: AppTypography.caption.copyWith(
                  color: c.textTertiary,
                ),
                textAlign: TextAlign.center,
              ),

              const Spacer(),

              // CTA button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () =>
                      context.go(AppRoutes.notificationPermission),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF292929),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: AppSpacing.borderRadiusMd,
                    ),
                  ),
                  child: Text(
                    'Empezar a vender',
                    style:
                        AppTypography.button.copyWith(color: Colors.white),
                  ),
                ),
              ),
              AppSpacing.vGapLg,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBenefitItem(IconData icon, String label, AdaptiveColors c) {
    return Column(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: AppColors.primary, size: 24),
        ),
        AppSpacing.vGapSm,
        Text(
          label,
          style: AppTypography.caption,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
