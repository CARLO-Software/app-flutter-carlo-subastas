import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/providers/providers.dart';
import '../../../shared/widgets/widgets.dart';
import '../data/mock_vehicle_repository.dart';

class VehicleLookupScreen extends ConsumerStatefulWidget {
  const VehicleLookupScreen({super.key});

  @override
  ConsumerState<VehicleLookupScreen> createState() =>
      _VehicleLookupScreenState();
}

class _VehicleLookupScreenState extends ConsumerState<VehicleLookupScreen> {
  final _plateController = TextEditingController();
  final _mileageController = TextEditingController();
  bool _isLoading = false;
  String? _plateError;
  String? _mileageError;

  @override
  void dispose() {
    _plateController.dispose();
    _mileageController.dispose();
    super.dispose();
  }

  bool _validate() {
    bool isValid = true;
    setState(() {
      _plateError = null;
      _mileageError = null;

      if (_plateController.text.trim().isEmpty) {
        _plateError = 'Ingresa la placa de tu vehículo';
        isValid = false;
      }

      if (_mileageController.text.trim().isEmpty) {
        _mileageError = 'Ingresa el kilometraje';
        isValid = false;
      } else {
        final mileage =
            int.tryParse(_mileageController.text.replaceAll(',', ''));
        if (mileage == null || mileage < 0) {
          _mileageError = 'Ingresa un kilometraje válido';
          isValid = false;
        }
      }
    });
    return isValid;
  }

  Future<void> _onSearch() async {
    if (!_validate()) return;

    setState(() => _isLoading = true);

    try {
      final mileage = int.parse(_mileageController.text.replaceAll(',', ''));
      final vehicle = await mockVehicleRepository.lookupVehicle(
        _plateController.text.trim(),
        mileage,
      );

      if (vehicle != null && mounted) {
        ref.read(vehicleRegistrationProvider.notifier).setVehicle(vehicle);
        ref.read(vehicleRegistrationProvider.notifier).setMileage(mileage);
        context.go(AppRoutes.estimatedPrice);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error al buscar vehículo. Intenta de nuevo.'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Scaffold(
      backgroundColor: c.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppSpacing.vGapXxl,
              Center(
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: AppSpacing.borderRadiusLg,
                  ),
                  child: const Icon(
                    Icons.directions_car,
                    size: 40,
                    color: AppColors.primary,
                  ),
                ),
              ),
              AppSpacing.vGapLg,
              Center(
                child: Text(
                  'Vende tu auto al mejor precio',
                  style: AppTypography.headlineMedium,
                  textAlign: TextAlign.center,
                ),
              ),
              AppSpacing.vGapSm,
              Center(
                child: Text(
                  'Ingresa los datos de tu vehículo para obtener una cotización',
                  style: AppTypography.bodyMedium.copyWith(
                    color: c.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              AppSpacing.vGapXxl,
              AppTextField(
                label: 'Placa',
                hint: 'Ej: ABC 123',
                controller: _plateController,
                errorText: _plateError,
                textCapitalization: TextCapitalization.characters,
                prefixIcon: const Icon(Icons.confirmation_number_outlined),
              ),
              AppSpacing.vGapMd,
              AppTextField(
                label: 'Kilometraje',
                hint: 'Ej: 45000',
                controller: _mileageController,
                errorText: _mileageError,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                prefixIcon: const Icon(Icons.speed_outlined),
              ),
              AppSpacing.vGapXl,
              PrimaryButton(
                text: 'Obtener cotización',
                onPressed: _onSearch,
                isLoading: _isLoading,
              ),
              AppSpacing.vGapMd,
              Center(
                child: Text(
                  'Tus datos están seguros y solo se usarán para la subasta',
                  style: AppTypography.caption,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
