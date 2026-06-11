import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../models/models.dart';
import '../../../shared/providers/providers.dart';
import '../../../shared/widgets/widgets.dart';

class ConditionDamageScreen extends ConsumerStatefulWidget {
  const ConditionDamageScreen({super.key});

  @override
  ConsumerState<ConditionDamageScreen> createState() => _ConditionDamageScreenState();
}

class _ConditionDamageScreenState extends ConsumerState<ConditionDamageScreen> {
  String? _selectedDamageType;
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _uuid = const Uuid();

  @override
  void dispose() {
    _locationController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _addDamage() {
    if (_selectedDamageType == null || _locationController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select damage type and location'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    final damage = DamageItem(
      id: _uuid.v4(),
      type: _selectedDamageType!,
      location: _locationController.text,
      description: _descriptionController.text.isNotEmpty
          ? _descriptionController.text
          : null,
    );

    ref.read(vehicleRegistrationProvider.notifier).addDamage(damage);

    setState(() {
      _selectedDamageType = null;
      _locationController.clear();
      _descriptionController.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Damage added'),
        backgroundColor: AppColors.success,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final registrationState = ref.watch(vehicleRegistrationProvider);
    final damages = registrationState.damages;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Condition & Damage'),
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
                    title: 'Report any damage',
                    subtitle: 'Add any scratches, dents, or paint damage',
                  ),

                  // Damage type selection
                  Text(
                    'Type of Damage',
                    style: AppTypography.labelLarge.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  AppSpacing.vGapSm,
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: AppConstants.damageTypes.map((type) {
                      final isSelected = _selectedDamageType == type;
                      return SelectableChip(
                        label: type,
                        isSelected: isSelected,
                        onTap: () {
                          setState(() {
                            _selectedDamageType = isSelected ? null : type;
                          });
                        },
                      );
                    }).toList(),
                  ),
                  AppSpacing.vGapMd,

                  // Location
                  AppTextField(
                    label: 'Location',
                    hint: 'e.g. Front bumper, Driver door',
                    controller: _locationController,
                  ),
                  AppSpacing.vGapMd,

                  // Description
                  AppTextField(
                    label: 'Description (Optional)',
                    hint: 'Add more details about the damage',
                    controller: _descriptionController,
                    maxLines: 3,
                  ),
                  AppSpacing.vGapMd,

                  SecondaryButton(
                    text: 'Add Damage',
                    icon: Icons.add,
                    onPressed: _addDamage,
                  ),
                  AppSpacing.vGapLg,

                  // Damage list
                  if (damages.isNotEmpty) ...[
                    Text(
                      'Reported Damages (${damages.length})',
                      style: AppTypography.titleMedium,
                    ),
                    AppSpacing.vGapMd,
                    ...damages.map((damage) => Container(
                          margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                          padding: const EdgeInsets.all(AppSpacing.md),
                          decoration: BoxDecoration(
                            color: AppColors.surfaceVariant,
                            borderRadius: AppSpacing.borderRadiusMd,
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: AppColors.warningLight,
                                  borderRadius: AppSpacing.borderRadiusSm,
                                ),
                                child: const Icon(
                                  Icons.warning_amber,
                                  color: AppColors.warning,
                                  size: 20,
                                ),
                              ),
                              AppSpacing.hGapMd,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      damage.type,
                                      style: AppTypography.titleSmall,
                                    ),
                                    Text(
                                      damage.location,
                                      style: AppTypography.bodySmall,
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete_outline,
                                  color: AppColors.error,
                                ),
                                onPressed: () {
                                  ref
                                      .read(vehicleRegistrationProvider.notifier)
                                      .removeDamage(damage.id);
                                },
                              ),
                            ],
                          ),
                        )),
                  ] else
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: AppColors.successLight,
                        borderRadius: AppSpacing.borderRadiusMd,
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.check_circle,
                            color: AppColors.success,
                          ),
                          AppSpacing.hGapSm,
                          const Expanded(
                            child: Text(
                              'No damage reported. Continue if your vehicle has no damage.',
                              style: TextStyle(
                                color: AppColors.success,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  AppSpacing.vGapLg,
                ],
              ),
            ),
          ),
          Container(
            padding: AppSpacing.screenPadding,
            decoration: BoxDecoration(
              color: AppColors.surface,
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadow,
                  blurRadius: 8,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: PrimaryButton(
              text: 'Continue',
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
