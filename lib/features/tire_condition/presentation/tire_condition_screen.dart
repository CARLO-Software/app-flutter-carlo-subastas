import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/providers/providers.dart';
import '../../../shared/widgets/widgets.dart';

const _tireOptions = [
  {
    'id': 'good',
    'title': 'Buen estado',
    'subtitle': 'Profundidad de banda mayor a 3mm, sin desgaste irregular',
    'icon': Icons.check_circle_outline,
  },
  {
    'id': 'fair',
    'title': 'Estado aceptable',
    'subtitle': 'Algo de desgaste pero aún dentro de lo seguro',
    'icon': Icons.remove_circle_outline,
  },
  {
    'id': 'poor',
    'title': 'Necesitan reemplazo',
    'subtitle': 'Banda de rodadura baja o desgaste irregular visible',
    'icon': Icons.cancel_outlined,
  },
];

class TireConditionScreen extends ConsumerStatefulWidget {
  const TireConditionScreen({super.key});

  @override
  ConsumerState<TireConditionScreen> createState() => _TireConditionScreenState();
}

class _TireConditionScreenState extends ConsumerState<TireConditionScreen> {
  String? _selected;

  @override
  void initState() {
    super.initState();
    _selected = ref.read(vehicleRegistrationProvider).tireCondition;
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;

    return Scaffold(
      backgroundColor: c.background,
      appBar: AppBar(
        title: const Text('Estado de Neumáticos'),
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
                    title: 'Estado de los neumáticos',
                    subtitle: 'Cuál es el estado general de los neumáticos de tu vehículo?',
                  ),
                  ..._tireOptions.map((option) {
                    final id = option['id'] as String;
                    final isSelected = _selected == id;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.md),
                      child: GestureDetector(
                        onTap: () => setState(() => _selected = id),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(AppSpacing.md),
                          decoration: BoxDecoration(
                            color: c.card,
                            borderRadius: AppSpacing.borderRadiusMd,
                            border: Border.all(
                              color: isSelected ? AppColors.primary : c.cardBorder,
                              width: isSelected ? 2 : 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? AppColors.primary.withValues(alpha: 0.1)
                                      : c.surfaceVariant,
                                  borderRadius: AppSpacing.borderRadiusSm,
                                ),
                                child: Icon(
                                  option['icon'] as IconData,
                                  color: isSelected ? AppColors.primary : c.textSecondary,
                                  size: 22,
                                ),
                              ),
                              AppSpacing.hGapMd,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      option['title'] as String,
                                      style: AppTypography.titleSmall.copyWith(
                                        color: isSelected ? AppColors.primary : c.textPrimary,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    AppSpacing.vGapXxs,
                                    Text(
                                      option['subtitle'] as String,
                                      style: AppTypography.bodySmall.copyWith(
                                        color: c.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: isSelected ? AppColors.primary : c.border,
                                    width: 2,
                                  ),
                                ),
                                child: isSelected
                                    ? Center(
                                        child: Container(
                                          width: 12,
                                          height: 12,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColors.primary,
                                          ),
                                        ),
                                      )
                                    : null,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                  AppSpacing.vGapMd,
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.05),
                      borderRadius: AppSpacing.borderRadiusMd,
                      border: Border.all(
                        color: AppColors.primary.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.info_outline, color: AppColors.primary, size: 20),
                        AppSpacing.hGapSm,
                        Expanded(
                          child: Text(
                            'El estado de los neumáticos puede afectar el valor de subasta de tu vehículo.',
                            style: AppTypography.bodySmall.copyWith(
                              color: c.textSecondary,
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
          BottomActionBar(
            child: PrimaryButton(
              text: 'Confirmar',
              isEnabled: _selected != null,
              onPressed: _selected != null
                  ? () {
                      ref.read(vehicleRegistrationProvider.notifier).setTireCondition(_selected!);
                      ref.read(vehicleRegistrationProvider.notifier).confirmTireCondition();
                      context.pop();
                    }
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
