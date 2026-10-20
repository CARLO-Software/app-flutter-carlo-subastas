import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/providers/providers.dart';
import '../../../shared/widgets/widgets.dart';

class ConditionDamageScreen extends ConsumerStatefulWidget {
  const ConditionDamageScreen({super.key});

  @override
  ConsumerState<ConditionDamageScreen> createState() => _ConditionDamageScreenState();
}

class _ConditionDamageScreenState extends ConsumerState<ConditionDamageScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _showIntroPopup());
  }

  static const _damageExamples = [
    {
      'image': 'assets/images/condicion-danos/condicion-abolladura.jpeg',
      'title': 'Abolladura',
      'description': 'Hundimiento en el panel lateral de la puerta causado por un impacto. Requiere trabajo de desabollado y posible repintado de la zona afectada.',
    },
    {
      'image': 'assets/images/condicion-danos/condicion-quine.jpeg',
      'title': 'Quiñe',
      'description': 'Desconche de pintura en el borde de la puerta por golpe menor. Se repara con retoque de pintura o repintado parcial del panel.',
    },
    {
      'image': 'assets/images/condicion-danos/condicion-rayadura.jpeg',
      'title': 'Rayadura en parachoques',
      'description': 'Rayas superficiales en el parachoques delantero por roce. Se corrige con pulido profesional o repintado si es profunda.',
    },
    {
      'image': 'assets/images/condicion-danos/condicion-rayadura-3.jpeg',
      'title': 'Rayadura en carrocería',
      'description': 'Rayas y marcas de roce en el parachoques trasero. Requiere pulido o repintado dependiendo de la profundidad del daño.',
    },
    {
      'image': 'assets/images/condicion-danos/condicion-rayadura-faro.jpeg',
      'title': 'Rayadura en faro',
      'description': 'Rayas y opacidad en la mica del faro delantero por desgaste. Se restaura con kit de pulido de faros o reemplazo de la mica.',
    },
    {
      'image': 'assets/images/condicion-danos/condicion-rajado-faro.jpeg',
      'title': 'Faro rajado',
      'description': 'Rajadura visible en la mica del faro trasero. Requiere reemplazo completo del faro ya que no se puede reparar.',
    },
    {
      'image': 'assets/images/condicion-danos/condicion-pintura.jpeg',
      'title': 'Pintura desgastada',
      'description': 'Decoloración y desgaste de la pintura en la puerta por exposición solar. Necesita lijado y repintado completo del panel.',
    },
    {
      'image': 'assets/images/condicion-danos/condicion-pintura-reventada.jpeg',
      'title': 'Pintura reventada',
      'description': 'Pintura levantada y descascarada en el parachoques, exponiendo la base. Requiere lijado, preparación y repintado de la zona.',
    },
    {
      'image': 'assets/images/condicion-danos/condicion-desgaste-llantas.jpeg',
      'title': 'Desgaste de llantas',
      'description': 'Llanta con banda de rodamiento severamente gastada y agrietada. Requiere reemplazo inmediato por seguridad.',
    },
    {
      'image': 'assets/images/condicion-danos/condicion-descuadrado.jpeg',
      'title': 'Panel descuadrado',
      'description': 'Desalineación del parachoques trasero respecto a la carrocería. Indica un golpe previo; requiere alineación o reemplazo del panel.',
    },
  ];

  void _showIntroPopup() {
    final c = context.colors;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      builder: (ctx) => FractionallySizedBox(
        heightFactor: 0.96,
        child: Container(
          decoration: BoxDecoration(
            color: c.surface,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(AppSpacing.radiusXl),
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.lg, AppSpacing.lg, 0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () => Navigator.of(ctx).pop(),
                    child: Text(
                      'Cerrar',
                      style: AppTypography.bodyMedium.copyWith(fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tipos de daños',
                        style: AppTypography.headlineSmall.copyWith(fontWeight: FontWeight.w700),
                      ),
                      AppSpacing.vGapSm,
                      Text(
                        'Estos son ejemplos de los daños más comunes que debes reportar en tu vehículo.',
                        style: AppTypography.bodyMedium.copyWith(color: c.textSecondary),
                      ),
                      AppSpacing.vGapXxl,
                      ..._damageExamples.map((example) => Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.xxl),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              example['title']!,
                              style: AppTypography.titleMedium.copyWith(fontWeight: FontWeight.w700),
                            ),
                            AppSpacing.vGapXs,
                            Text(
                              example['description']!,
                              style: AppTypography.bodySmall.copyWith(color: c.textSecondary),
                            ),
                            AppSpacing.vGapMd,
                            ClipRRect(
                              borderRadius: AppSpacing.borderRadiusMd,
                              child: Image.asset(
                                example['image']!,
                                width: double.infinity,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      )),
                    ],
                  ),
                ),
              ),
              SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(ctx).pop(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF292929),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: AppSpacing.borderRadiusXl),
                      ),
                      child: Text(
                        'OK, entendido',
                        style: AppTypography.button.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final registrationState = ref.watch(vehicleRegistrationProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Condición y Daños'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: AppSpacing.screenPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionHeader(
                    title: 'Inspección del vehículo',
                    subtitle: 'Completa cada sección para reportar el estado del vehículo',
                  ),
                  _ConditionSubItem(
                    title: 'Problemas de pintura',
                    subtitle: 'Marca rayones, descascarados, etc.',
                    icon: Icons.format_paint_outlined,
                    completed: registrationState.paintworkConfirmed,
                    onTap: () => context.push(AppRoutes.paintworkProblems),
                  ),
                  AppSpacing.vGapSm,
                  _ConditionSubItem(
                    title: 'Accesorios rotos o faltantes',
                    subtitle: 'Manijas, luces, molduras',
                    icon: Icons.broken_image_outlined,
                    completed: registrationState.brokenFittingsConfirmed,
                    onTap: () => context.push(AppRoutes.brokenFittings),
                  ),
                  AppSpacing.vGapSm,
                  _ConditionSubItem(
                    title: 'Daño en ruedas',
                    subtitle: 'Revisa el estado de cada rueda',
                    icon: Icons.tire_repair_outlined,
                    completed: registrationState.wheelDamageConfirmed,
                    onTap: () => context.push(AppRoutes.wheelDamage),
                  ),
                  AppSpacing.vGapLg,
                ],
              ),
            ),
          ),
          BottomActionBar(
            child: PrimaryButton(
              text: 'Continuar',
              onPressed: () {
                ref.read(vehicleRegistrationProvider.notifier).confirmConditionDamage();
                context.go(AppRoutes.dashboard);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ConditionSubItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool completed;
  final VoidCallback onTap;

  const _ConditionSubItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.completed,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: c.card,
          borderRadius: AppSpacing.borderRadiusMd,
          border: Border.all(
            color: completed ? AppColors.success : c.cardBorder,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: completed
                    ? AppColors.success.withValues(alpha: 0.1)
                    : c.surfaceVariant,
                borderRadius: AppSpacing.borderRadiusSm,
              ),
              child: Icon(
                icon,
                color: completed ? AppColors.success : c.textSecondary,
                size: 22,
              ),
            ),
            AppSpacing.hGapMd,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTypography.titleSmall),
                  AppSpacing.vGapXxs,
                  Text(
                    subtitle,
                    style: AppTypography.bodySmall.copyWith(color: c.textSecondary),
                  ),
                ],
              ),
            ),
            if (completed)
              Container(
                width: 28,
                height: 28,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.success,
                ),
                child: const Icon(Icons.check, size: 16, color: Colors.white),
              )
            else
              Icon(Icons.chevron_right, color: c.textTertiary),
          ],
        ),
      ),
    );
  }
}
