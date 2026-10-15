import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/providers/providers.dart';
import '../../../shared/widgets/widgets.dart';

const _seatOptions = [
  {'id': 'cloth', 'title': 'Tela', 'icon': Icons.chair_outlined},
  {'id': 'faux_leather', 'title': 'Cuero sintético', 'icon': Icons.chair_alt},
  {'id': 'half_leather', 'title': 'Medio cuero', 'icon': Icons.event_seat_outlined},
  {'id': 'half_suede', 'title': 'Medio gamuza', 'icon': Icons.event_seat},
  {'id': 'leather', 'title': 'Cuero', 'icon': Icons.airline_seat_recline_extra},
  {'id': 'suede', 'title': 'Gamuza', 'icon': Icons.airline_seat_legroom_extra},
];

class SeatMaterialScreen extends ConsumerStatefulWidget {
  const SeatMaterialScreen({super.key});

  @override
  ConsumerState<SeatMaterialScreen> createState() => _SeatMaterialScreenState();
}

class _SeatMaterialScreenState extends ConsumerState<SeatMaterialScreen> {
  String? _selected;

  @override
  void initState() {
    super.initState();
    _selected = ref.read(vehicleRegistrationProvider).seatMaterial;
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;

    return Scaffold(
      backgroundColor: c.background,
      appBar: AppBar(
        title: const Text('Material de los asientos'),
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
                    title: 'Material de los asientos',
                    subtitle: '¿De qué material son los asientos de tu vehículo?',
                  ),
                  ..._seatOptions.map((option) {
                    final id = option['id'] as String;
                    final isSelected = _selected == id;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
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
                                child: Text(
                                  option['title'] as String,
                                  style: AppTypography.titleSmall.copyWith(
                                    color: isSelected ? AppColors.primary : c.textPrimary,
                                    fontWeight: FontWeight.w600,
                                  ),
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
                      ref.read(vehicleRegistrationProvider.notifier).setSeatMaterial(_selected!);
                      ref.read(vehicleRegistrationProvider.notifier).confirmSeatMaterial();
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
