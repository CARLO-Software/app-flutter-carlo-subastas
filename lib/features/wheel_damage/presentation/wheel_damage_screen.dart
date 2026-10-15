import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/providers/providers.dart';
import '../../../shared/widgets/widgets.dart';

const _wheelPositions = [
  {'id': 'front_left', 'label': 'Delantera izquierda'},
  {'id': 'front_right', 'label': 'Delantera derecha'},
  {'id': 'rear_left', 'label': 'Trasera izquierda'},
  {'id': 'rear_right', 'label': 'Trasera derecha'},
];

class WheelDamageScreen extends ConsumerStatefulWidget {
  const WheelDamageScreen({super.key});

  @override
  ConsumerState<WheelDamageScreen> createState() => _WheelDamageScreenState();
}

class _WheelDamageScreenState extends ConsumerState<WheelDamageScreen> {
  late Map<String, bool> _damageMap;

  @override
  void initState() {
    super.initState();
    final existing = ref.read(vehicleRegistrationProvider).wheelDamageMap;
    _damageMap = Map<String, bool>.from(existing);
    for (final pos in _wheelPositions) {
      _damageMap.putIfAbsent(pos['id']!, () => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final wheelsPhotos = ref.watch(vehicleRegistrationProvider).wheelsPhotosMap;

    return Scaffold(
      backgroundColor: c.background,
      appBar: AppBar(
        title: const Text('Daño en ruedas'),
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
                    title: 'Revisión de ruedas',
                    subtitle: 'Revisa las fotos de cada rueda e indica si tiene daño visible.',
                  ),
                  ..._wheelPositions.map((pos) {
                    final id = pos['id']!;
                    final label = pos['label']!;
                    final photoPath = wheelsPhotos[id];
                    final hasDamage = _damageMap[id] ?? false;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.md),
                      child: Container(
                        decoration: BoxDecoration(
                          color: c.card,
                          borderRadius: AppSpacing.borderRadiusLg,
                          border: Border.all(
                            color: hasDamage ? AppColors.warning : c.cardBorder,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(AppSpacing.radiusLg),
                                topRight: Radius.circular(AppSpacing.radiusLg),
                              ),
                              child: photoPath != null
                                  ? Image.file(
                                      File(photoPath),
                                      height: 180,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) => _placeholder(c),
                                    )
                                  : _placeholder(c),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(AppSpacing.md),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(label, style: AppTypography.titleSmall.copyWith(fontWeight: FontWeight.w600)),
                                        if (hasDamage)
                                          Text(
                                            'Daño reportado',
                                            style: AppTypography.bodySmall.copyWith(color: AppColors.warning),
                                          ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () => setState(() => _damageMap[id] = !hasDamage),
                                    child: Container(
                                      width: 28,
                                      height: 28,
                                      decoration: BoxDecoration(
                                        borderRadius: AppSpacing.borderRadiusSm,
                                        border: Border.all(
                                          color: hasDamage ? AppColors.warning : c.border,
                                          width: 2,
                                        ),
                                        color: hasDamage ? AppColors.warning : Colors.transparent,
                                      ),
                                      child: hasDamage
                                          ? const Icon(Icons.check, size: 18, color: Colors.white)
                                          : null,
                                    ),
                                  ),
                                  AppSpacing.hGapSm,
                                  Text(
                                    'Tiene daño',
                                    style: AppTypography.bodySmall.copyWith(color: c.textSecondary),
                                  ),
                                ],
                              ),
                            ),
                          ],
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
              onPressed: () {
                for (final entry in _damageMap.entries) {
                  ref.read(vehicleRegistrationProvider.notifier).setWheelDamage(entry.key, entry.value);
                }
                ref.read(vehicleRegistrationProvider.notifier).confirmWheelDamage();
                context.pop();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _placeholder(AdaptiveColors c) {
    return Container(
      height: 180,
      width: double.infinity,
      color: c.surfaceVariant,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.image_outlined, size: 48, color: c.textTertiary),
          AppSpacing.vGapSm,
          Text('Sin foto', style: AppTypography.bodySmall.copyWith(color: c.textTertiary)),
        ],
      ),
    );
  }
}
