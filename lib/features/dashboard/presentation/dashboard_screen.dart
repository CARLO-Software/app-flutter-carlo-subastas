import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/providers/providers.dart';
import '../../../shared/widgets/widgets.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = context.colors;
    final registrationState = ref.watch(vehicleRegistrationProvider);
    final vehicle = registrationState.vehicle;
    final progress = ref.watch(progressPercentageProvider);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go(AppRoutes.vehicleLookup),
        ),
        title: Text(
          vehicle?.plate ?? 'Vehículo',
          style: AppTypography.titleLarge,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              _showMenu(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: AppSpacing.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Estimated Value Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.primaryLight],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: AppSpacing.borderRadiusLg,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Valor Estimado de Subasta',
                    style: AppTypography.labelMedium.copyWith(
                      color: c.textOnPrimary.withValues(alpha: 0.8),
                    ),
                  ),
                  AppSpacing.vGapSm,
                  Text(
                    'S/ 45,000 - S/ 52,000',
                    style: AppTypography.headlineMedium.copyWith(
                      color: c.textOnPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  AppSpacing.vGapMd,
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Progreso',
                              style: AppTypography.labelSmall.copyWith(
                                color: c.textOnPrimary.withValues(alpha: 0.8),
                              ),
                            ),
                            AppSpacing.vGapXs,
                            ClipRRect(
                              borderRadius: AppSpacing.borderRadiusFull,
                              child: LinearProgressIndicator(
                                value: progress / 100,
                                backgroundColor:
                                    c.textOnPrimary.withValues(alpha: 0.3),
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  c.textOnPrimary,
                                ),
                                minHeight: 8,
                              ),
                            ),
                          ],
                        ),
                      ),
                      AppSpacing.hGapMd,
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md,
                          vertical: AppSpacing.xs,
                        ),
                        decoration: BoxDecoration(
                          color: c.textOnPrimary.withValues(alpha: 0.2),
                          borderRadius: AppSpacing.borderRadiusFull,
                        ),
                        child: Text(
                          '$progress%',
                          style: AppTypography.titleMedium.copyWith(
                            color: c.textOnPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            AppSpacing.vGapLg,

            // Vehicle Summary
            if (vehicle != null) ...[
              const SectionHeader(
                title: 'Tu Vehículo',
              ),
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: c.card,
                  borderRadius: AppSpacing.borderRadiusMd,
                  border: Border.all(color: c.cardBorder),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: c.surfaceVariant,
                        borderRadius: AppSpacing.borderRadiusSm,
                      ),
                      child: const Icon(
                        Icons.directions_car,
                        size: 32,
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
                            style: AppTypography.titleMedium,
                          ),
                          AppSpacing.vGapXs,
                          Text(
                            '${vehicle.year} | ${vehicle.color} | ${vehicle.fuelType}',
                            style: AppTypography.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    StatusBadge(status: registrationState.submissionStatus),
                  ],
                ),
              ),
              AppSpacing.vGapLg,
            ],

            // Progress Cards
            const SectionHeader(
              title: 'Pasos de Registro',
              subtitle: 'Completa todos los pasos para enviar tu vehículo',
            ),
            ProgressCard(
              title: 'Información del Vehículo',
              subtitle: 'Revisa y confirma los detalles de tu vehículo',
              icon: Icons.directions_car_outlined,
              isCompleted: registrationState.vehicleDetailsConfirmed,
              onTap: () => context.push(AppRoutes.vehicleDetails),
            ),
            AppSpacing.vGapMd,
            ProgressCard(
              title: 'Fotos Exteriores',
              subtitle: 'Toma fotos del exterior del vehículo',
              icon: Icons.camera_alt_outlined,
              isCompleted: registrationState.photosConfirmed,
              onTap: () => context.push(AppRoutes.photoIntroduction),
            ),
            AppSpacing.vGapMd,
            ProgressCard(
              title: 'Fotos Interiores',
              subtitle: 'Toma fotos del interior del vehículo',
              icon: Icons.chair_outlined,
              isCompleted: registrationState.interiorPhotosConfirmed,
              onTap: () => context.push(AppRoutes.interiorPhotos),
            ),
            AppSpacing.vGapMd,
            ProgressCard(
              title: 'Condición y Daños',
              subtitle: 'Reporta cualquier daño en tu vehículo',
              icon: Icons.report_problem_outlined,
              isCompleted: registrationState.conditionDamageConfirmed,
              onTap: () => context.push(AppRoutes.conditionDamage),
            ),
            AppSpacing.vGapMd,
            ProgressCard(
              title: 'Historial de Servicio',
              subtitle: 'Sube tus registros de servicio',
              icon: Icons.history_outlined,
              isCompleted: registrationState.serviceHistoryConfirmed,
              onTap: () => context.push(AppRoutes.serviceHistory),
            ),
            AppSpacing.vGapXl,
            PrimaryButton(
              text: 'Revisar y Enviar',
              onPressed: () => context.push(AppRoutes.review),
            ),
            AppSpacing.vGapMd,
          ],
        ),
      ),
    );
  }

  void _showMenu(BuildContext context) {
    final c = context.colors;
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppSpacing.radiusLg),
          topRight: Radius.circular(AppSpacing.radiusLg),
        ),
      ),
      builder: (context) => Container(
        padding: AppSpacing.screenPadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: c.border,
                borderRadius: AppSpacing.borderRadiusFull,
              ),
            ),
            AppSpacing.vGapLg,
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text('Panel'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.check_circle_outline),
              title: const Text('Revisar y Enviar'),
              onTap: () {
                Navigator.pop(context);
                context.push(AppRoutes.review);
              },
            ),
            ListTile(
              leading: const Icon(Icons.track_changes_outlined),
              title: const Text('Estado del Envío'),
              onTap: () {
                Navigator.pop(context);
                context.push(AppRoutes.submissionStatus);
              },
            ),
            AppSpacing.vGapMd,
          ],
        ),
      ),
    );
  }
}
