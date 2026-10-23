import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/providers/providers.dart';
import '../../../shared/widgets/widgets.dart';
import '../data/mock_vehicle_repository.dart';
import 'estimated_price_screen.dart';

class VehicleResultScreen extends ConsumerStatefulWidget {
  const VehicleResultScreen({super.key});

  @override
  ConsumerState<VehicleResultScreen> createState() =>
      _VehicleResultScreenState();
}

class _VehicleResultScreenState extends ConsumerState<VehicleResultScreen> {
  final _mileageController = TextEditingController();
  bool _showHighMileageWarning = false;
  String? _mileageError;

  static const double _highMileageThreshold = 25000;

  @override
  void dispose() {
    _mileageController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    final text = _mileageController.text.replaceAll(',', '').trim();
    if (text.isEmpty) {
      setState(() => _mileageError = 'Ingresa el kilometraje');
      return;
    }
    final mileage = double.tryParse(text);
    if (mileage == null || mileage < 0) {
      setState(() => _mileageError = 'Ingresa un kilometraje válido');
      return;
    }
    setState(() => _mileageError = null);

    if (mileage >= _highMileageThreshold && !_showHighMileageWarning) {
      setState(() => _showHighMileageWarning = true);
      return;
    }

    final price = mockVehicleRepository.estimatePrice(mileage);
    final notifier = ref.read(vehicleRegistrationProvider.notifier);
    notifier.setMileage(mileage);
    final vehicle = ref.read(vehicleProvider);
    if (vehicle != null) {
      notifier.setVehicle(vehicle.copyWith(
        mileage: mileage,
        estimatedPrice: price,
      ));
    }
    if (mounted) showEstimatedPricePopup(context, ref);
  }

  Future<void> _onNotMyCar() async {
    final vehicle = ref.read(vehicleProvider);
    final plate = vehicle?.plate ?? '';
    final message = Uri.encodeComponent(
      'Hola, busqué la placa $plate pero el vehículo mostrado no es el mío. ¿Pueden ayudarme?',
    );
    final url = Uri.parse('https://wa.me/51934140010?text=$message');
    await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final vehicle = ref.watch(vehicleProvider);
    if (vehicle == null) return const SizedBox.shrink();

    return Scaffold(
      backgroundColor: c.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: c.textPrimary),
          onPressed: () => context.go(AppRoutes.vehicleLookup),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.screenPadding,
          child: Column(
            children: [
              // High mileage warning banner
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                child: _showHighMileageWarning
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.md),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.md,
                            vertical: AppSpacing.sm + 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.info,
                            borderRadius: AppSpacing.borderRadiusMd,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Tu kilometraje luce alto, ¿estás seguro?',
                                  style: AppTypography.bodySmall.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () => setState(
                                    () => _showHighMileageWarning = false),
                                child: const Icon(Icons.close,
                                    color: Colors.white, size: 20),
                              ),
                            ],
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),

              // Vehicle info card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  color: c.surface,
                  borderRadius: AppSpacing.borderRadiusLg,
                  border: Border.all(color: c.border),
                  boxShadow: [
                    BoxShadow(
                      color: c.shadow,
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Plate badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.sm,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: AppSpacing.borderRadiusSm,
                      ),
                      child: Text(
                        vehicle.plate,
                        style: AppTypography.titleMedium.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                    AppSpacing.vGapMd,

                    // Vehicle name
                    Text(
                      '${vehicle.brand} ${vehicle.model}',
                      style: AppTypography.titleLarge.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    AppSpacing.vGapXs,

                    // Vehicle details
                    Text(
                      '${vehicle.year} · ${vehicle.color} · ${vehicle.bodyType} · ${vehicle.fuelType}',
                      style: AppTypography.bodyMedium.copyWith(
                        color: c.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    AppSpacing.vGapMd,

                    // "Not my car" link
                    GestureDetector(
                      onTap: _onNotMyCar,
                      child: Text(
                        'Ese no es mi carro',
                        style: AppTypography.bodyMedium.copyWith(
                          color: AppColors.info,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.info,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              AppSpacing.vGapXxl,

              // Mileage input
              AppTextField(
                label: 'Ingresa kilometraje',
                hint: 'Ej: 45000',
                controller: _mileageController,
                errorText: _mileageError,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[\d.]')),
                ],
                prefixIcon: const Icon(Icons.speed_outlined),
              ),

              AppSpacing.vGapXl,

              PrimaryButton(
                text: _showHighMileageWarning ? 'Confirmar' : 'Enviar',
                onPressed: _onSubmit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
