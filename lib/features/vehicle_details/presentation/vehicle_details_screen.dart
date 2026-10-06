import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/providers/providers.dart';
import '../../../shared/widgets/widgets.dart';

class VehicleDetailsScreen extends ConsumerWidget {
  const VehicleDetailsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = context.colors;
    final registrationState = ref.watch(vehicleRegistrationProvider);
    final vehicle = registrationState.vehicle;

    if (vehicle == null) {
      return const Scaffold(
        body: Center(
          child: Text('No vehicle data available'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles del Vehículo'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: AppSpacing.screenPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Vehicle Summary Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: AppSpacing.borderRadiusLg,
                      border: Border.all(
                        color: AppColors.primary.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.2),
                            borderRadius: AppSpacing.borderRadiusMd,
                          ),
                          child: const Icon(
                            Icons.directions_car,
                            size: 40,
                            color: AppColors.primary,
                          ),
                        ),
                        AppSpacing.hGapMd,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${vehicle.brand} ${vehicle.model}',
                                style: AppTypography.headlineSmall,
                              ),
                              AppSpacing.vGapXs,
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppSpacing.sm,
                                  vertical: AppSpacing.xxs,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: AppSpacing.borderRadiusSm,
                                ),
                                child: Text(
                                  vehicle.plate,
                                  style: AppTypography.labelMedium.copyWith(
                                    color: c.textOnPrimary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  AppSpacing.vGapLg,

                  const SectionHeader(
                    title: 'Información del Vehículo',
                    subtitle: 'Verifica los datos de tu vehículo',
                  ),

                  _buildDetailRow('Placa', vehicle.plate, c),
                  _buildDetailRow('Marca', vehicle.brand, c),
                  _buildDetailRow('Modelo', vehicle.model, c),
                  _buildDetailRow('Año', vehicle.year.toString(), c),
                  _buildDetailRow('Kilometraje', '${registrationState.mileage} km', c),
                  _buildDetailRow('Color', vehicle.color, c),
                  _buildDetailRow('Carrocería', vehicle.bodyType, c),
                  _buildDetailRow('Puertas', vehicle.doors.toString(), c),
                  _buildDetailRow('Transmisión', vehicle.transmission, c),
                  _buildDetailRow('Combustible', vehicle.fuelType, c),
                  _buildDetailRow('Motor', vehicle.engineSize, c),
                  _buildDetailRow('Propietario', vehicle.ownership, c),
                  _buildDetailRow('Venc. Revisión', vehicle.motExpiry, c),

                  AppSpacing.vGapLg,
                ],
              ),
            ),
          ),
          BottomActionBar(
            child: PrimaryButton(
              text: 'Confirmar Detalles',
              onPressed: () {
                ref.read(vehicleRegistrationProvider.notifier).confirmVehicleDetails();
                context.pop();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, AdaptiveColors c) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: c.divider),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTypography.bodyMedium.copyWith(
              color: c.textSecondary,
            ),
          ),
          Text(
            value.isNotEmpty ? value : '-',
            style: AppTypography.bodyMedium.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
