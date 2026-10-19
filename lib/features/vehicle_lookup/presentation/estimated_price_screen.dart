import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/providers/providers.dart';

void showEstimatedPricePopup(BuildContext context, WidgetRef ref) {
  final c = context.colors;
  final vehicle = ref.read(vehicleProvider);
  final formatter = NumberFormat('#,###', 'es_PE');
  final price = vehicle?.estimatedPrice ?? 0;

  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    isDismissible: false,
    enableDrag: false,
    builder: (ctx) => FractionallySizedBox(
      heightFactor: 0.96,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: c.surface,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(AppSpacing.radiusXl),
          ),
        ),
        child: Column(
        children: [
          // Header con botón Cerrar
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () => Navigator.of(ctx).pop(),
              child: Text(
                'Cerrar',
                style: AppTypography.bodyMedium.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          const Spacer(flex: 2),

          // Precio section
          Text(
            'Tu precio de venta estimada',
            style: AppTypography.titleMedium.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 18,
              color: c.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          AppSpacing.vGapSm,
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'S/${formatter.format(price.round())}',
                  style: AppTypography.headlineLarge.copyWith(
                    fontWeight: FontWeight.w800,
                    fontSize: 48,
                  ),
                ),
                WidgetSpan(
                  alignment: PlaceholderAlignment.aboveBaseline,
                  baseline: TextBaseline.alphabetic,
                  child: Transform.translate(
                    offset: const Offset(2, -12),
                    child: Text(
                      '*',
                      style: AppTypography.bodyMedium.copyWith(
                        fontWeight: FontWeight.w800,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          AppSpacing.vGapSm,
          Text(
            'Basado en ofertas de concesionarios en Carlo para vehículos ${vehicle?.brand ?? ''}',
            style: AppTypography.bodyMedium.copyWith(
              fontWeight: FontWeight.w500,
              color: c.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          AppSpacing.vGapSm,
          GestureDetector(
            onTap: () {},
            child: Text(
              'Aprender más',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.info,
                decoration: TextDecoration.underline,
                decorationColor: AppColors.info,
              ),
            ),
          ),

          const Spacer(flex: 2),

          // Tu venta incluirá
          Text(
            'Tu venta incluirá',
            style: AppTypography.titleMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          AppSpacing.vGapLg,
          Row(
            children: [
              Expanded(child: _buildBenefitItem(Icons.local_shipping_outlined, 'Recogida a\ndomicilio', c)),
              Expanded(child: _buildBenefitItem(Icons.flash_on_outlined, 'Pago\nrápido', c)),
              Expanded(child: _buildBenefitItem(Icons.money_off_outlined, 'Sin\ncomisiones', c)),
            ],
          ),
          const Spacer(flex: 3),
          Text(
            '* Sujeto al estado del vehículo y a su historial de mantenimiento',
            style: AppTypography.caption.copyWith(
              fontWeight: FontWeight.w600,
              color: c.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          AppSpacing.vGapMd,
          Divider(color: c.divider),
          AppSpacing.vGapMd,

          // CTA
          SafeArea(
            top: false,
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                  GoRouter.of(context).go(AppRoutes.notificationPermission);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF292929),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: AppSpacing.borderRadiusXl,
                  ),
                ),
                child: Text(
                  'Empezar a vender',
                  style: AppTypography.button.copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
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
