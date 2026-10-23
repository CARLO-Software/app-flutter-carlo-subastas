import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../models/models.dart';
import '../../../shared/providers/providers.dart';

const _headerColor = Color(0xFF6327E2);

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = context.colors;
    final state = ref.watch(vehicleRegistrationProvider);
    final vehicle = state.vehicle;
    final progress = ref.watch(dashboardProgressProvider);
    final formatter = NumberFormat('#,###', 'es_PE');

    final steps = _buildSteps(state);
    final allDone = steps.every((s) => s.completed);
    final nextStep = steps.firstWhere(
      (s) => !s.completed,
      orElse: () => steps.last,
    );

    String bottomLabel;
    String buttonText;
    VoidCallback onPressed;

    if (allDone) {
      bottomLabel = '¡Solo un paso más!';
      buttonText = 'Completar';
      onPressed = () => context.push(AppRoutes.review);
    } else {
      bottomLabel = 'Siguiente: ${nextStep.title}';
      buttonText = progress > 0 ? 'Continuar' : 'Siguiente paso';
      onPressed = () => context.push(nextStep.route);
    }

    // Siempre mostrar opción de vista previa
    final canPreview = progress > 0;

    return Scaffold(
      backgroundColor: c.background,
      body: Column(
        children: [
          // Yellow header
          Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + AppSpacing.sm,
              left: AppSpacing.md,
              right: AppSpacing.md,
              bottom: AppSpacing.md,
            ),
            color: _headerColor,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Valor estimado',
                        style: AppTypography.bodySmall.copyWith(
                          color: Colors.white70,
                        ),
                      ),
                      Text(
                        'S/${formatter.format(vehicle?.estimatedPrice.round() ?? 0)}',
                        style: AppTypography.headlineMedium.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
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
                  ),
                  child: Text(
                    vehicle?.plate ?? '',
                    style: AppTypography.labelMedium.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                AppSpacing.hGapSm,
                GestureDetector(
                  onTap: () => _showUserMenu(context),
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.person_outline,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Body
          Expanded(
            child: SingleChildScrollView(
              padding: AppSpacing.screenPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppSpacing.vGapLg,
                  Text(
                    'Pon tu vehículo a la venta',
                    style: AppTypography.headlineSmall.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  AppSpacing.vGapLg,

                  ...steps.map((step) => Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.md),
                        child: _StepCard(step: step),
                      )),

                  AppSpacing.vGapMd,

                  Center(
                    child: GestureDetector(
                      onTap: () => _showContactPopup(context),
                      child: Text(
                        '¿Necesitas ayuda?',
                        style: AppTypography.titleSmall.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  AppSpacing.vGapMd,
                  if (canPreview)
                    Center(
                      child: GestureDetector(
                        onTap: () => context.push(AppRoutes.review),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.lg,
                            vertical: AppSpacing.sm,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: _headerColor),
                            borderRadius: AppSpacing.borderRadiusMd,
                          ),
                          child: Text(
                            'Ver resumen del perfil',
                            style: AppTypography.titleSmall.copyWith(
                              color: _headerColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  AppSpacing.vGapXl,
                ],
              ),
            ),
          ),

          // Bottom progress bar
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: c.card,
              border: Border(top: BorderSide(color: c.border)),
            ),
            child: SafeArea(
              top: false,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: AppSpacing.borderRadiusFull,
                    child: LinearProgressIndicator(
                      value: progress / 100,
                      backgroundColor: c.surfaceVariant,
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(_headerColor),
                      minHeight: 6,
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
                              '$progress% completado',
                              style: AppTypography.titleSmall.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            AppSpacing.vGapXxs,
                            Text(
                              bottomLabel,
                              style: AppTypography.caption.copyWith(
                                color: c.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: onPressed,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF292929),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          minimumSize: Size.zero,
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.lg,
                            vertical: AppSpacing.sm,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: AppSpacing.borderRadiusMd,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(buttonText,
                                style: AppTypography.buttonSmall
                                    .copyWith(color: Colors.white)),
                            if (allDone) ...[
                              const SizedBox(width: 4),
                              const Icon(Icons.arrow_forward,
                                  size: 16, color: Colors.white),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _openWhatsApp() async {
    final url = Uri.parse('https://wa.me/51934140010?text=${Uri.encodeComponent('Hola, necesito ayuda con el registro de mi vehículo en Carlo.')}');
    await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  void _showContactPopup(BuildContext context) {
    final c = context.colors;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
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
            crossAxisAlignment: CrossAxisAlignment.start,
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
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nuestro horario\nde atención',
                        style: AppTypography.headlineSmall.copyWith(fontWeight: FontWeight.w700),
                      ),
                      AppSpacing.vGapMd,
                      Text(
                        'Estamos disponibles para ayudarte con cualquier duda sobre el registro de tu vehículo.',
                        style: AppTypography.bodyMedium.copyWith(color: c.textSecondary),
                      ),
                      AppSpacing.vGapXxl,
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(AppSpacing.md),
                        decoration: BoxDecoration(
                          color: c.surfaceVariant,
                          borderRadius: AppSpacing.borderRadiusMd,
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                color: const Color(0xFF25D366).withValues(alpha: 0.15),
                                borderRadius: AppSpacing.borderRadiusSm,
                              ),
                              child: const Icon(Icons.chat_outlined, color: Color(0xFF25D366), size: 22),
                            ),
                            AppSpacing.hGapMd,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('WhatsApp', style: AppTypography.titleSmall.copyWith(fontWeight: FontWeight.w700)),
                                  AppSpacing.vGapXxs,
                                  Text('+51 934 140 010', style: AppTypography.bodySmall.copyWith(color: c.textSecondary)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      AppSpacing.vGapLg,
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(AppSpacing.md),
                        decoration: BoxDecoration(
                          color: c.surfaceVariant,
                          borderRadius: AppSpacing.borderRadiusMd,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.schedule, size: 18, color: c.textSecondary),
                                AppSpacing.hGapSm,
                                Text('Horarios', style: AppTypography.titleSmall.copyWith(fontWeight: FontWeight.w700)),
                              ],
                            ),
                            AppSpacing.vGapMd,
                            _ScheduleRow(label: 'Lunes a Viernes', hours: '9:00 am - 5:00 pm', colors: c),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                              child: Divider(height: 1, color: c.border),
                            ),
                            _ScheduleRow(label: 'Sábados', hours: '9:00 am - 12:00 pm', colors: c),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                              child: Divider(height: 1, color: c.border),
                            ),
                            _ScheduleRow(label: 'Domingos y feriados', hours: 'Cerrado', colors: c, closed: true),
                          ],
                        ),
                      ),
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
                      onPressed: () {
                        Navigator.of(ctx).pop();
                        _openWhatsApp();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF292929),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: AppSpacing.borderRadiusXl),
                      ),
                      child: Text(
                        'Contactar por WhatsApp',
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

  void _showUserMenu(BuildContext context) {
    final c = context.colors;
    showModalBottomSheet(
      context: context,
      backgroundColor: c.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppSpacing.radiusXl)),
      ),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
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
                leading: Icon(Icons.person_outline, color: c.textPrimary),
                title: Text('Mi perfil', style: AppTypography.titleSmall),
                onTap: () {
                  Navigator.of(ctx).pop();
                  context.push(AppRoutes.profile);
                },
              ),
              ListTile(
                leading: Icon(Icons.help_outline, color: c.textPrimary),
                title: Text('Ayuda', style: AppTypography.titleSmall),
                onTap: () => Navigator.of(ctx).pop(),
              ),
              ListTile(
                leading: const Icon(Icons.logout, color: AppColors.error),
                title: Text('Cerrar sesión', style: AppTypography.titleSmall.copyWith(color: AppColors.error)),
                onTap: () {
                  Navigator.of(ctx).pop();
                  context.go(AppRoutes.vehicleLookup);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<_DashboardStep> _buildSteps(VehicleRegistrationState state) {
    final exteriorCompleted = state.photosConfirmed &&
        state.conditionDamageConfirmed &&
        state.paintworkConfirmed;

    final exteriorStarted = state.exteriorPhotos.isNotEmpty ||
        state.exteriorPhotosMap.isNotEmpty;

    final interiorCompleted =
        state.interiorPhotosConfirmed && state.brokenFittingsConfirmed;

    final interiorStarted = state.interiorPhotos.isNotEmpty ||
        state.interiorPhotosMap.isNotEmpty;

    final llantasCompleted = state.wheelsPhotosConfirmed &&
        state.tireConditionConfirmed &&
        state.wheelDamageConfirmed;

    final llantasStarted = state.wheelsPhotosMap.isNotEmpty;

    final infoCompleted = state.vehicleDetailsConfirmed &&
        state.extraFeaturesConfirmed &&
        state.keysConfirmed &&
        state.financeConfirmed &&
        state.runningConditionConfirmed &&
        state.mechanicalIssuesConfirmed &&
        state.proofOfPurchaseConfirmed &&
        state.smokingConfirmed &&
        state.privatePlateConfirmed &&
        state.seatMaterialConfirmed &&
        state.toolPackConfirmed &&
        state.lockingWheelNutConfirmed &&
        state.serviceHistoryConfirmed;

    return [
      _DashboardStep(
        title: 'Exterior',
        subtitle: 'Fotos exteriores y daños',
        completed: exteriorCompleted,
        warning: exteriorStarted && !exteriorCompleted
            ? 'Pendiente por completar'
            : null,
        route: AppRoutes.photoIntroduction,
      ),
      _DashboardStep(
        title: 'Interior',
        subtitle: 'Fotos interiores y daños',
        completed: interiorCompleted,
        warning: interiorStarted && !interiorCompleted
            ? 'Pendiente por completar'
            : null,
        route: AppRoutes.interiorPhotos,
      ),
      _DashboardStep(
        title: 'Llantas',
        subtitle: 'Fotos de llantas y daños',
        completed: llantasCompleted,
        warning: llantasStarted && !llantasCompleted
            ? 'Pendiente por completar'
            : null,
        route: AppRoutes.wheelsPhotos,
      ),
      _DashboardStep(
        title: 'Información adicional',
        subtitle: 'Detalles, llaves, financiamiento y más',
        completed: infoCompleted,
        route: AppRoutes.vehicleInfoHub,
      ),
    ];
  }
}

class _DashboardStep {
  final String title;
  final String? subtitle;
  final String? warning;
  final bool completed;
  final String route;

  const _DashboardStep({
    required this.title,
    this.subtitle,
    this.warning,
    required this.completed,
    required this.route,
  });
}

class _ScheduleRow extends StatelessWidget {
  final String label;
  final String hours;
  final AdaptiveColors colors;
  final bool closed;

  const _ScheduleRow({
    required this.label,
    required this.hours,
    required this.colors,
    this.closed = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTypography.bodySmall),
        Text(
          hours,
          style: AppTypography.bodySmall.copyWith(
            fontWeight: FontWeight.w600,
            color: closed ? AppColors.error : colors.textPrimary,
          ),
        ),
      ],
    );
  }
}

class _StepCard extends StatelessWidget {
  final _DashboardStep step;

  const _StepCard({required this.step});

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return GestureDetector(
      onTap: () => context.push(step.route),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.lg,
        ),
        decoration: BoxDecoration(
          color: c.card,
          borderRadius: AppSpacing.borderRadiusLg,
          border: Border.all(color: c.cardBorder),
        ),
        child: Row(
          children: [
            if (step.completed)
              Padding(
                padding: const EdgeInsets.only(right: AppSpacing.sm),
                child: Icon(
                  Icons.check_circle_outline,
                  color: Colors.black87,
                  size: 24,
                ),
              ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    step.title,
                    style: AppTypography.titleMedium.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (step.subtitle != null) ...[
                    AppSpacing.vGapXxs,
                    Text(
                      step.subtitle!,
                      style: AppTypography.bodySmall.copyWith(
                        color: c.textSecondary,
                      ),
                    ),
                  ],
                  if (step.warning != null) ...[
                    AppSpacing.vGapXxs,
                    Row(
                      children: [
                        const Icon(Icons.warning_amber_rounded,
                            size: 16, color: AppColors.error),
                        const SizedBox(width: 4),
                        Text(
                          step.warning!,
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.error,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: c.surfaceVariant,
              ),
              child: Icon(
                Icons.arrow_forward,
                size: 16,
                color: c.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
