import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/providers/providers.dart';

class CollectionAddressScreen extends ConsumerStatefulWidget {
  const CollectionAddressScreen({super.key});

  @override
  ConsumerState<CollectionAddressScreen> createState() => _CollectionAddressScreenState();
}

class _CollectionAddressScreenState extends ConsumerState<CollectionAddressScreen> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    final address = ref.read(vehicleRegistrationProvider).collectionAddress;
    _controller = TextEditingController(text: address);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;

    return Scaffold(
      backgroundColor: c.background,
      appBar: AppBar(
        title: const Text('Dirección de recolección'),
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
                    '¿Dónde se recogerá el coche?',
                    style: AppTypography.titleLarge.copyWith(
                      color: c.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  AppSpacing.vGapXs,
                  Text(
                    'Ingresa el código postal o la primera línea de la dirección donde recogeremos el coche.',
                    style: AppTypography.bodyMedium.copyWith(
                      color: c.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  AppSpacing.vGapLg,
                  TextField(
                    controller: _controller,
                    style: AppTypography.bodyLarge.copyWith(color: c.textPrimary),
                    onChanged: (_) => setState(() {}),
                    decoration: InputDecoration(
                      hintText: 'Ubicación del vehículo',
                      hintStyle: AppTypography.bodyLarge.copyWith(color: c.textTertiary),
                      filled: true,
                      fillColor: c.surfaceVariant,
                      suffixIcon: Icon(Icons.search, color: c.textTertiary),
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
                  ),
                  AppSpacing.vGapMd,
                  GestureDetector(
                    onTap: () {
                      // TODO: manual address entry flow
                    },
                    child: Text(
                      'Ingresar ubicación manualmente',
                      style: AppTypography.bodyMedium.copyWith(
                        color: c.textSecondary,
                        decoration: TextDecoration.underline,
                        decorationColor: c.textSecondary,
                      ),
                    ),
                  ),
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
                    onPressed: _controller.text.trim().isNotEmpty
                        ? () {
                            final notifier = ref.read(vehicleRegistrationProvider.notifier);
                            notifier.setCollectionAddress(_controller.text.trim());
                            context.push(AppRoutes.confirmAddress);
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
