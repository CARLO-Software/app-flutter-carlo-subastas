import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../shared/providers/providers.dart';
import '../../../shared/widgets/widgets.dart';

class KeysScreen extends ConsumerWidget {
  const KeysScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registrationState = ref.watch(vehicleRegistrationProvider);
    final selectedKeys = registrationState.numberOfKeys;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Keys'),
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
                    title: 'How many keys do you have?',
                    subtitle: 'Select the number of keys that come with your vehicle',
                  ),
                  SelectableOptionCard(
                    title: '1 Key',
                    subtitle: 'One original key',
                    icon: Icons.key,
                    isSelected: selectedKeys == 1,
                    onTap: () {
                      ref.read(vehicleRegistrationProvider.notifier).setNumberOfKeys(1);
                    },
                  ),
                  AppSpacing.vGapMd,
                  SelectableOptionCard(
                    title: '2 Keys',
                    subtitle: 'Two original keys',
                    icon: Icons.key,
                    isSelected: selectedKeys == 2,
                    onTap: () {
                      ref.read(vehicleRegistrationProvider.notifier).setNumberOfKeys(2);
                    },
                  ),
                  AppSpacing.vGapMd,
                  SelectableOptionCard(
                    title: '3+ Keys',
                    subtitle: 'Three or more original keys',
                    icon: Icons.key,
                    isSelected: selectedKeys >= 3,
                    onTap: () {
                      ref.read(vehicleRegistrationProvider.notifier).setNumberOfKeys(3);
                    },
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
              text: 'Next',
              onPressed: () {
                ref.read(vehicleRegistrationProvider.notifier).confirmKeys();
                context.push(AppRoutes.finance);
              },
            ),
          ),
        ],
      ),
    );
  }
}
