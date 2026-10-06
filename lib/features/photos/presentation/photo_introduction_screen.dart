import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/providers/providers.dart';

class PhotoIntroductionScreen extends ConsumerStatefulWidget {
  const PhotoIntroductionScreen({super.key});

  @override
  ConsumerState<PhotoIntroductionScreen> createState() =>
      _PhotoIntroductionScreenState();
}

class _PhotoIntroductionScreenState
    extends ConsumerState<PhotoIntroductionScreen> {
  bool _tipsShown = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_tipsShown) _showTipsDialog();
    });
  }

  void _showTipsDialog() {
    setState(() => _tipsShown = true);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      backgroundColor: Colors.transparent,
      builder: (ctx) => const _PhotoTipsSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final state = ref.watch(vehicleRegistrationProvider);
    final exteriorCount = state.exteriorPhotosMap.length;
    final interiorCount = state.interiorPhotosMap.length;
    const totalPhotos = 17;
    final takenPhotos = exteriorCount + interiorCount;
    final remaining = totalPhotos - takenPhotos;

    final categories = [
      _PhotoCategory(
        title: 'Exterior',
        status: state.photosConfirmed
            ? 'Completado'
            : exteriorCount > 0
                ? '$exteriorCount/8 fotos'
                : 'No empezado',
        completed: state.photosConfirmed,
        onTap: () => context.push(AppRoutes.exteriorPhotos),
      ),
      _PhotoCategory(
        title: 'Interior',
        status: state.interiorPhotosConfirmed
            ? 'Completado'
            : interiorCount > 0
                ? '$interiorCount fotos'
                : 'No empezado',
        completed: state.interiorPhotosConfirmed,
        onTap: () => context.push(AppRoutes.interiorPhotos),
      ),
      _PhotoCategory(
        title: 'Ruedas',
        status: 'No empezado',
        completed: false,
        onTap: () {},
      ),
      _PhotoCategory(
        title: 'Estado de los neumáticos',
        status: 'No empezado',
        completed: false,
        onTap: () {},
      ),
    ];

    return Scaffold(
      backgroundColor: c.background,
      body: Column(
        children: [
          // Header morado
          Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + AppSpacing.md,
              left: AppSpacing.md,
              right: AppSpacing.md,
              bottom: AppSpacing.lg,
            ),
            decoration: const BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(AppSpacing.radiusXl),
                bottomRight: Radius.circular(AppSpacing.radiusXl),
              ),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => context.pop(),
                ),
                const Spacer(),
                Text(
                  'Fotos',
                  style: AppTypography.titleLarge.copyWith(
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.help_outline, color: Colors.white),
                  onPressed: _showTipsDialog,
                ),
              ],
            ),
          ),

          // Categories
          Expanded(
            child: SingleChildScrollView(
              padding: AppSpacing.screenPadding,
              child: Column(
                children: [
                  ...categories.map((cat) => Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                        child: _CategoryCard(category: cat),
                      )),
                  AppSpacing.vGapLg,
                  Text(
                    'Te quedan $remaining fotos por tomar',
                    style: AppTypography.bodyMedium.copyWith(
                      color: c.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PhotoCategory {
  final String title;
  final String status;
  final bool completed;
  final VoidCallback onTap;

  const _PhotoCategory({
    required this.title,
    required this.status,
    required this.completed,
    required this.onTap,
  });
}

class _CategoryCard extends StatelessWidget {
  final _PhotoCategory category;

  const _CategoryCard({required this.category});

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return GestureDetector(
      onTap: category.onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: c.card,
          borderRadius: AppSpacing.borderRadiusMd,
          border: Border.all(
            color: category.completed ? AppColors.success : c.cardBorder,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(category.title, style: AppTypography.titleMedium),
                  AppSpacing.vGapXs,
                  Text(
                    category.status,
                    style: AppTypography.bodySmall.copyWith(
                      color: category.completed
                          ? AppColors.success
                          : c.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            if (category.completed)
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.success,
                ),
                child: const Icon(Icons.check, size: 18, color: Colors.white),
              )
            else
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF292929),
                ),
                child: const Icon(Icons.arrow_forward,
                    size: 18, color: Colors.white),
              ),
          ],
        ),
      ),
    );
  }
}

class _PhotoTipsSheet extends StatelessWidget {
  const _PhotoTipsSheet();

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        color: c.background,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppSpacing.radiusXl),
          topRight: Radius.circular(AppSpacing.radiusXl),
        ),
      ),
      child: Column(
        children: [
          // Close button
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: c.surfaceVariant,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.close, size: 20, color: c.textPrimary),
                ),
              ),
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Antes de tomar fotos de tu carro, necesitarás:',
                    style: AppTypography.headlineSmall,
                  ),
                  AppSpacing.vGapXl,
                  _buildTip(
                    icon: Icons.auto_awesome_outlined,
                    title: 'Un auto limpio y bien cuidado',
                    description: 'Obtén el precio que tu auto merece',
                    colors: c,
                  ),
                  AppSpacing.vGapMd,
                  _buildTip(
                    icon: Icons.open_in_full_outlined,
                    title: 'Espacio para caminar alrededor de tu auto',
                    description:
                        'Los estacionamientos son perfectos para esto.',
                    colors: c,
                  ),
                  AppSpacing.vGapMd,
                  _buildTip(
                    icon: Icons.wb_sunny_outlined,
                    title: 'Luz natural',
                    description:
                        'Toma las fotos mientras todavía haya luz natural.',
                    colors: c,
                  ),
                  AppSpacing.vGapMd,
                  _buildTip(
                    icon: Icons.timer_outlined,
                    title: '10 minutos',
                    description:
                        'Tomará aproximadamente diez minutos tomar las fotos de tu vehículo.',
                    colors: c,
                  ),
                  AppSpacing.vGapXl,
                ],
              ),
            ),
          ),

          // Bottom button
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: SafeArea(
              top: false,
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF292929),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: AppSpacing.borderRadiusMd,
                    ),
                  ),
                  child: Text('Empezar a tomar fotos',
                      style: AppTypography.button
                          .copyWith(color: Colors.white)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTip({
    required IconData icon,
    required String title,
    required String description,
    required AdaptiveColors colors,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: AppSpacing.borderRadiusMd,
          ),
          child: Icon(icon, color: AppColors.primary, size: 24),
        ),
        AppSpacing.hGapMd,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTypography.titleSmall),
              AppSpacing.vGapXxs,
              Text(
                description,
                style: AppTypography.bodySmall.copyWith(
                  color: colors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
