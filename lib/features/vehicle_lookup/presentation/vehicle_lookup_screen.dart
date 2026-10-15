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

class _PlateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final raw = newValue.text.replaceAll('-', '').toUpperCase();
    if (raw.length > 6) {
      return oldValue;
    }
    final buffer = StringBuffer();
    for (int i = 0; i < raw.length; i++) {
      if (i == 3) buffer.write('-');
      buffer.write(raw[i]);
    }
    final formatted = buffer.toString();
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

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
            double.tryParse(_mileageController.text.replaceAll(',', ''));
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
      final mileage = double.parse(_mileageController.text.replaceAll(',', ''));
      final plate = _plateController.text.replaceAll('-', '').trim();
      final vehicle = await mockVehicleRepository.lookupVehicle(
        plate,
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
                hint: 'Ej: AB2-12C',
                controller: _plateController,
                errorText: _plateError,
                textCapitalization: TextCapitalization.characters,
                inputFormatters: [_PlateInputFormatter()],
                prefixIcon: const Icon(Icons.confirmation_number_outlined),
              ),
              AppSpacing.vGapMd,
              AppTextField(
                label: 'Kilometraje',
                hint: 'Ej: 45000.5',
                controller: _mileageController,
                errorText: _mileageError,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[\d.]')),
                ],
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
