import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/providers/providers.dart';

class OwnerNameScreen extends ConsumerStatefulWidget {
  const OwnerNameScreen({super.key});

  @override
  ConsumerState<OwnerNameScreen> createState() => _OwnerNameScreenState();
}

class _OwnerNameScreenState extends ConsumerState<OwnerNameScreen> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    final name = ref.read(vehicleRegistrationProvider).ownerFullName;
    _controller = TextEditingController(text: name);
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
        title: const Text('Tu nombre'),
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
                    'Ingresa tu nombre',
                    style: AppTypography.titleLarge.copyWith(
                      color: c.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  AppSpacing.vGapXs,
                  Text(
                    'Ingresa tu nombre completo, tal como aparece en el V5C.',
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
                      hintText: 'Nombre completo',
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
                  ),
                  AppSpacing.vGapXxl,
                  // Collection info card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    decoration: BoxDecoration(
                      color: c.surfaceVariant,
                      borderRadius: AppSpacing.borderRadiusLg,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '¿No puedes estar en la recolección? No hay problema',
                          style: AppTypography.titleSmall.copyWith(
                            color: c.textPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Puedes hacer que alguien más entregue el coche por ti. Antes de la recolección, necesitarás:',
                          style: AppTypography.bodySmall.copyWith(color: c.textSecondary),
                        ),
                        AppSpacing.vGapLg,
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: c.border,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(Icons.verified_user_outlined, color: c.textSecondary, size: 20),
                            ),
                            const SizedBox(width: AppSpacing.md),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Verificar tu identidad',
                                    style: AppTypography.bodyMedium.copyWith(
                                      color: c.textPrimary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    'Para ayudar a proteger a todos en la venta',
                                    style: AppTypography.bodySmall.copyWith(color: c.textTertiary),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        AppSpacing.vGapMd,
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: c.border,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(Icons.description_outlined, color: c.textSecondary, size: 20),
                            ),
                            const SizedBox(width: AppSpacing.md),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Firmar una Carta de Autorización',
                                    style: AppTypography.bodyMedium.copyWith(
                                      color: c.textPrimary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    'Permitiéndoles entregar el coche. Es una carta digital, nada que escribir o imprimir.',
                                    style: AppTypography.bodySmall.copyWith(color: c.textTertiary),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        AppSpacing.vGapLg,
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () {
                              // TODO: show explanation
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: c.textPrimary,
                              side: BorderSide(color: c.border),
                              shape: RoundedRectangleBorder(
                                borderRadius: AppSpacing.borderRadiusXl,
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                            child: Text(
                              '¿Por qué es necesario?',
                              style: AppTypography.labelLarge.copyWith(color: c.textPrimary),
                            ),
                          ),
                        ),
                      ],
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
                            notifier.setOwnerFullName(_controller.text.trim());
                            notifier.confirmOwnerName();
                            context.push(AppRoutes.collectionAddress);
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
