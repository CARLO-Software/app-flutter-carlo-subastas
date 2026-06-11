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
  ConsumerState<VehicleLookupScreen> createState() => _VehicleLookupScreenState();
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
        _plateError = 'Please enter your registration plate';
        isValid = false;
      }

      if (_mileageController.text.trim().isEmpty) {
        _mileageError = 'Please enter your mileage';
        isValid = false;
      } else {
        final mileage = int.tryParse(_mileageController.text.replaceAll(',', ''));
        if (mileage == null || mileage < 0) {
          _mileageError = 'Please enter a valid mileage';
          isValid = false;
        }
      }
    });
    return isValid;
  }

  Future<void> _onConfirm() async {
    if (!_validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final mileage = int.parse(_mileageController.text.replaceAll(',', ''));
      final vehicle = await mockVehicleRepository.lookupVehicle(
        _plateController.text.trim(),
        mileage,
      );

      if (vehicle != null && mounted) {
        ref.read(vehicleRegistrationProvider.notifier).setVehicle(vehicle);
        ref.read(vehicleRegistrationProvider.notifier).setMileage(mileage);
        context.go(AppRoutes.dashboard);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to lookup vehicle. Please try again.'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
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
                  'Enter Your Vehicle Details',
                  style: AppTypography.headlineMedium,
                  textAlign: TextAlign.center,
                ),
              ),
              AppSpacing.vGapSm,
              Center(
                child: Text(
                  'We\'ll find your vehicle and give you an estimated auction value',
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              AppSpacing.vGapXxl,
              AppTextField(
                label: 'Registration Plate',
                hint: 'e.g. ABC 123',
                controller: _plateController,
                errorText: _plateError,
                textCapitalization: TextCapitalization.characters,
                prefixIcon: const Icon(Icons.confirmation_number_outlined),
              ),
              AppSpacing.vGapMd,
              AppTextField(
                label: 'Mileage',
                hint: 'e.g. 45000',
                controller: _mileageController,
                errorText: _mileageError,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                prefixIcon: const Icon(Icons.speed_outlined),
              ),
              AppSpacing.vGapXl,
              PrimaryButton(
                text: 'Confirm',
                onPressed: _onConfirm,
                isLoading: _isLoading,
              ),
              AppSpacing.vGapMd,
              Center(
                child: Text(
                  'Your data is secure and will only be used for auction purposes',
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
