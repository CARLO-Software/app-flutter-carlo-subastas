import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_routes.dart';
import '../../../core/services/auth_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../providers/registered_vehicles_provider.dart';

const _headerColor = Color(0xFF6327E2);

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = context.colors;
    final vehiclesAsync = ref.watch(registeredVehiclesProvider);

    return Scaffold(
      backgroundColor: c.background,
      appBar: AppBar(
        backgroundColor: _headerColor,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            ClipRRect(
              borderRadius: AppSpacing.borderRadiusSm,
              child: Image.asset(
                'assets/images/logo.png',
                width: 32,
                height: 32,
                fit: BoxFit.cover,
              ),
            ),
            AppSpacing.hGapSm,
            Text(
              'Carlo Subastas',
              style: AppTypography.titleMedium.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
      drawer: _buildDrawer(context, ref, c),
      body: vehiclesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator(color: _headerColor)),
        error: (_, __) => _buildEmptyState(context, c),
        data: (vehicles) => vehicles.isEmpty
            ? _buildEmptyState(context, c)
            : _buildVehicleList(context, c, vehicles),
      ),
      floatingActionButton: vehiclesAsync.valueOrNull?.isNotEmpty == true
          ? FloatingActionButton.extended(
              onPressed: () => context.push(AppRoutes.vehicleLookup),
              backgroundColor: _headerColor,
              foregroundColor: Colors.white,
              icon: const Icon(Icons.add),
              label: const Text('Nuevo vehículo'),
            )
          : null,
    );
  }

  Widget _buildDrawer(BuildContext context, WidgetRef ref, AdaptiveColors c) {
    final user = ref.watch(currentUserProvider);
    return Drawer(
      backgroundColor: c.surface,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: const BoxDecoration(
                color: _headerColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        (user?.name ?? 'U').substring(0, 1).toUpperCase(),
                        style: AppTypography.headlineSmall.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  AppSpacing.vGapMd,
                  Text(
                    user?.name ?? 'Usuario',
                    style: AppTypography.titleMedium.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  AppSpacing.vGapXxs,
                  Text(
                    user?.email ?? '',
                    style: AppTypography.bodySmall.copyWith(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            AppSpacing.vGapSm,
            _DrawerItem(
              icon: Icons.add_circle_outline,
              label: 'Registrar vehículo',
              onTap: () {
                Navigator.of(context).pop();
                context.push(AppRoutes.vehicleLookup);
              },
            ),
            _DrawerItem(
              icon: Icons.directions_car_outlined,
              label: 'Mis vehículos',
              selected: true,
              onTap: () => Navigator.of(context).pop(),
            ),
            _DrawerItem(
              icon: Icons.gavel_outlined,
              label: 'Mis subastas',
              onTap: () {
                Navigator.of(context).pop();
                _showComingSoon(context);
              },
            ),
            _DrawerItem(
              icon: Icons.person_outline,
              label: 'Mi perfil',
              onTap: () {
                Navigator.of(context).pop();
                context.push(AppRoutes.profile);
              },
            ),
            const Spacer(),
            const Divider(height: 1),
            _DrawerItem(
              icon: Icons.logout,
              label: 'Cerrar sesión',
              color: AppColors.error,
              onTap: () {
                ref.read(authServiceProvider).logout();
                ref.read(currentUserProvider.notifier).state = null;
                Navigator.of(context).pop();
                context.go(AppRoutes.auth);
              },
            ),
            AppSpacing.vGapSm,
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, AdaptiveColors c) {
    return Center(
      child: Padding(
        padding: AppSpacing.screenPadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: _headerColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.directions_car_outlined,
                size: 40,
                color: _headerColor,
              ),
            ),
            AppSpacing.vGapLg,
            Text(
              'Sin vehículos registrados',
              style: AppTypography.titleLarge.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            AppSpacing.vGapSm,
            Text(
              'Agrega tu primer vehículo para ponerlo\na la venta en subasta.',
              textAlign: TextAlign.center,
              style: AppTypography.bodyMedium.copyWith(
                color: c.textSecondary,
              ),
            ),
            AppSpacing.vGapXl,
            ElevatedButton.icon(
              onPressed: () => context.push(AppRoutes.vehicleLookup),
              icon: const Icon(Icons.add),
              label: const Text('Registrar vehículo'),
              style: ElevatedButton.styleFrom(
                backgroundColor: _headerColor,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.md,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: AppSpacing.borderRadiusMd,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVehicleList(
    BuildContext context,
    AdaptiveColors c,
    List<RegisteredVehicle> vehicles,
  ) {
    return ListView.builder(
      padding: AppSpacing.screenPadding,
      itemCount: vehicles.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.lg),
            child: Text(
              'Mis vehículos',
              style: AppTypography.headlineSmall.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          );
        }
        final vehicle = vehicles[index - 1];
        return _VehicleCard(vehicle: vehicle);
      },
    );
  }

  void _showComingSoon(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Próximamente: seguimiento de subastas en vivo'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final Color? color;
  final VoidCallback onTap;

  const _DrawerItem({
    required this.icon,
    required this.label,
    this.selected = false,
    this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final itemColor = color ?? (selected ? _headerColor : c.textPrimary);

    return ListTile(
      leading: Icon(icon, color: itemColor, size: 22),
      title: Text(
        label,
        style: AppTypography.titleSmall.copyWith(
          color: itemColor,
          fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
        ),
      ),
      selected: selected,
      selectedTileColor: _headerColor.withValues(alpha: 0.08),
      shape: RoundedRectangleBorder(borderRadius: AppSpacing.borderRadiusSm),
      contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      onTap: onTap,
    );
  }
}

class _VehicleCard extends StatelessWidget {
  final RegisteredVehicle vehicle;

  const _VehicleCard({required this.vehicle});

  @override
  Widget build(BuildContext context) {
    final c = context.colors;

    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: c.card,
        borderRadius: AppSpacing.borderRadiusLg,
        border: Border.all(color: c.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      vehicle.vehicleLabel,
                      style: AppTypography.titleMedium.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (vehicle.identifier.isNotEmpty) ...[
                      AppSpacing.vGapXxs,
                      Text(
                        vehicle.identifier,
                        style: AppTypography.bodySmall.copyWith(
                          color: c.textSecondary,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.xxs,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: AppSpacing.borderRadiusSm,
                  border: Border.all(color: c.border),
                ),
                child: Text(
                  vehicle.plate,
                  style: AppTypography.labelMedium.copyWith(
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ],
          ),
          AppSpacing.vGapMd,
          _StatusChip(label: vehicle.statusLabel, status: vehicle.status),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String label;
  final AuctionStatus status;

  const _StatusChip({required this.label, required this.status});

  @override
  Widget build(BuildContext context) {
    final (bg, fg) = switch (status) {
      AuctionStatus.draft => (
          const Color(0xFFF3F4F6),
          AppColors.statusDraft,
        ),
      AuctionStatus.submitted => (
          const Color(0xFFDBEAFE),
          AppColors.statusSubmitted,
        ),
      AuctionStatus.inReview => (
          const Color(0xFFFEF3C7),
          AppColors.statusUnderReview,
        ),
      AuctionStatus.live => (
          const Color(0xFFEDE9FE),
          AppColors.statusPublished,
        ),
      AuctionStatus.sold => (
          const Color(0xFFD1FAE5),
          AppColors.statusApproved,
        ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xxs,
      ),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: AppSpacing.borderRadiusFull,
      ),
      child: Text(
        label,
        style: AppTypography.labelSmall.copyWith(
          color: fg,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
