import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/providers/providers.dart';

const _wheelPositions = [
  {'id': 'front_left', 'label': 'Conductor delantera'},
  {'id': 'front_right', 'label': 'Copiloto delantera'},
  {'id': 'rear_left', 'label': 'Conductor trasera'},
  {'id': 'rear_right', 'label': 'Copiloto trasera'},
];

class WheelDamageScreen extends ConsumerStatefulWidget {
  const WheelDamageScreen({super.key});

  @override
  ConsumerState<WheelDamageScreen> createState() => _WheelDamageScreenState();
}

class _WheelDamageScreenState extends ConsumerState<WheelDamageScreen> {
  late final Set<String> _damaged;

  @override
  void initState() {
    super.initState();
    final map = ref.read(vehicleRegistrationProvider).wheelDamageMap;
    _damaged = map.entries.where((e) => e.value).map((e) => e.key).toSet();
  }

  @override
  Widget build(BuildContext context) {
    final wheelsPhotos = ref.watch(vehicleRegistrationProvider.select((s) => s.wheelsPhotosMap));

    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E1E),
        foregroundColor: Colors.white,
        titleTextStyle: AppTypography.titleLarge.copyWith(color: Colors.white),
        iconTheme: const IconThemeData(color: Colors.white),
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
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '¿Hay alguna rueda de aleación rayada, rozada o dañada?',
                    style: AppTypography.titleLarge.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  AppSpacing.vGapXs,
                  Text(
                    'Selecciona las ruedas con daño visible',
                    style: AppTypography.bodyMedium.copyWith(color: Colors.white54),
                  ),
                  AppSpacing.vGapXxl,
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.85,
                      crossAxisSpacing: AppSpacing.md,
                      mainAxisSpacing: AppSpacing.md,
                    ),
                    itemCount: _wheelPositions.length,
                    itemBuilder: (context, index) {
                      final pos = _wheelPositions[index];
                      final id = pos['id']!;
                      final label = pos['label']!;
                      final photoPath = wheelsPhotos[id];
                      final isSelected = _damaged.contains(id);

                      return GestureDetector(
                        onTap: () => setState(() {
                          if (isSelected) {
                            _damaged.remove(id);
                          } else {
                            _damaged.add(id);
                          }
                        }),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF2A2A2A),
                            borderRadius: AppSpacing.borderRadiusLg,
                            border: Border.all(
                              color: isSelected ? AppColors.warning : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(AppSpacing.radiusLg),
                                  ),
                                  child: photoPath != null
                                      ? Image.file(
                                          File(photoPath),
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                          cacheWidth: 300,
                                          errorBuilder: (_, __, ___) => _placeholder(),
                                        )
                                      : _placeholder(),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppSpacing.sm,
                                  vertical: AppSpacing.sm,
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        label,
                                        style: AppTypography.labelSmall.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(
                                          color: isSelected ? AppColors.warning : Colors.white38,
                                          width: 2,
                                        ),
                                        color: isSelected ? AppColors.warning : Colors.transparent,
                                      ),
                                      child: isSelected
                                          ? const Icon(Icons.check, size: 16, color: Colors.white)
                                          : null,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: const Color(0xFF1E1E1E),
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      for (final pos in _wheelPositions) {
                        final id = pos['id']!;
                        ref.read(vehicleRegistrationProvider.notifier).setWheelDamage(id, _damaged.contains(id));
                      }
                      ref.read(vehicleRegistrationProvider.notifier).confirmWheelDamage();
                      context.push(AppRoutes.tirePhotos);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: AppSpacing.borderRadiusXl,
                      ),
                    ),
                    child: Text(
                      _damaged.isEmpty ? 'Ninguna tiene daño' : 'Continuar',
                      style: AppTypography.button.copyWith(color: Colors.black),
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

  Widget _placeholder() {
    return Container(
      color: const Color(0xFF3A3A3A),
      child: const Center(
        child: Icon(Icons.image_outlined, size: 40, color: Colors.white24),
      ),
    );
  }
}
