import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/providers/providers.dart';

class ConfirmAddressScreen extends ConsumerStatefulWidget {
  const ConfirmAddressScreen({super.key});

  @override
  ConsumerState<ConfirmAddressScreen> createState() => _ConfirmAddressScreenState();
}

class _ConfirmAddressScreenState extends ConsumerState<ConfirmAddressScreen> {
  late final TextEditingController _line1;
  late final TextEditingController _line2;
  late final TextEditingController _line3;
  late final TextEditingController _city;
  late final TextEditingController _postcode;

  @override
  void initState() {
    super.initState();
    final s = ref.read(vehicleRegistrationProvider);
    _line1 = TextEditingController(text: s.collectionAddressLine1);
    _line2 = TextEditingController(text: s.collectionAddressLine2);
    _line3 = TextEditingController(text: s.collectionAddressLine3);
    _city = TextEditingController(text: s.collectionCity);
    _postcode = TextEditingController(text: s.collectionPostcode);
  }

  @override
  void dispose() {
    _line1.dispose();
    _line2.dispose();
    _line3.dispose();
    _city.dispose();
    _postcode.dispose();
    super.dispose();
  }

  bool get _isValid =>
      _line1.text.trim().isNotEmpty &&
      _line2.text.trim().isNotEmpty &&
      _city.text.trim().isNotEmpty &&
      _postcode.text.trim().isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;

    return Scaffold(
      backgroundColor: c.background,
      appBar: AppBar(
        title: const Text('Confirmar dirección'),
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
                    'Confirma la dirección de recolección',
                    style: AppTypography.titleLarge.copyWith(
                      color: c.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  AppSpacing.vGapXs,
                  Text(
                    'Tómate un momento para revisar la dirección y asegurarte de que sea correcta antes de continuar.',
                    style: AppTypography.bodyMedium.copyWith(
                      color: c.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  AppSpacing.vGapLg,
                  _buildField(c, _line1, 'Nombre de la calle o zona'),
                  AppSpacing.vGapMd,
                  _buildField(c, _line2, 'Número y calle'),
                  AppSpacing.vGapMd,
                  _buildField(c, _line3, 'Línea 3 (opcional)'),
                  AppSpacing.vGapMd,
                  _buildField(c, _city, 'Ciudad'),
                  AppSpacing.vGapMd,
                  _buildField(c, _postcode, 'Código postal'),
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
                    onPressed: _isValid
                        ? () {
                            final notifier = ref.read(vehicleRegistrationProvider.notifier);
                            notifier.setCollectionAddressDetails(
                              line1: _line1.text.trim(),
                              line2: _line2.text.trim(),
                              line3: _line3.text.trim(),
                              city: _city.text.trim(),
                              postcode: _postcode.text.trim(),
                            );
                            notifier.confirmCollectionAddress();
                            context.push(AppRoutes.confirmPhone);
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: AppColors.primary.withValues(alpha: 0.3),
                      disabledForegroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: AppSpacing.borderRadiusXl,
                      ),
                    ),
                    child: Text(
                      'Confirmar dirección',
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

  Widget _buildField(AdaptiveColors c, TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      style: AppTypography.bodyLarge.copyWith(color: c.textPrimary),
      onChanged: (_) => setState(() {}),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: AppTypography.bodyLarge.copyWith(color: c.textTertiary),
        filled: true,
        fillColor: c.surfaceVariant,
        border: OutlineInputBorder(
          borderRadius: AppSpacing.borderRadiusLg,
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppSpacing.borderRadiusLg,
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
      ),
    );
  }
}
