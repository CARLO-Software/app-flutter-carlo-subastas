import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../shared/providers/providers.dart';
import '../../../shared/widgets/widgets.dart';
import '../widgets/widgets.dart';

class ExteriorPhotosScreen extends ConsumerStatefulWidget {
  const ExteriorPhotosScreen({super.key});

  @override
  ConsumerState<ExteriorPhotosScreen> createState() => _ExteriorPhotosScreenState();
}

class _ExteriorPhotosScreenState extends ConsumerState<ExteriorPhotosScreen> {
  final Map<String, bool> _photosTaken = {};

  @override
  void initState() {
    super.initState();
    for (final photoType in AppConstants.exteriorPhotoTypes) {
      _photosTaken[photoType] = false;
    }
  }

  void _simulateTakePhoto(String photoType) {
    setState(() {
      _photosTaken[photoType] = !(_photosTaken[photoType] ?? false);
    });

    if (_photosTaken[photoType] == true) {
      ref.read(vehicleRegistrationProvider.notifier).addExteriorPhoto(photoType);
    } else {
      ref.read(vehicleRegistrationProvider.notifier).removeExteriorPhoto(photoType);
    }
  }

  int get _photosTakenCount => _photosTaken.values.where((taken) => taken).length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Exterior Photos'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Column(
        children: [
          // Progress indicator
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            color: AppColors.surfaceVariant,
            child: Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: AppSpacing.borderRadiusFull,
                    child: LinearProgressIndicator(
                      value: _photosTakenCount / AppConstants.exteriorPhotoTypes.length,
                      backgroundColor: AppColors.border,
                      valueColor: const AlwaysStoppedAnimation<Color>(AppColors.success),
                      minHeight: 8,
                    ),
                  ),
                ),
                AppSpacing.hGapMd,
                Text(
                  '$_photosTakenCount/${AppConstants.exteriorPhotoTypes.length}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: AppSpacing.screenPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionHeader(
                    title: 'Take Exterior Photos',
                    subtitle: 'Tap each card to simulate taking a photo',
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1,
                      crossAxisSpacing: AppSpacing.md,
                      mainAxisSpacing: AppSpacing.md,
                    ),
                    itemCount: AppConstants.exteriorPhotoTypes.length,
                    itemBuilder: (context, index) {
                      final photoType = AppConstants.exteriorPhotoTypes[index];
                      return PhotoCard(
                        title: photoType,
                        imagePath: _photosTaken[photoType] == true ? 'mock_path' : null,
                        onTap: () => _simulateTakePhoto(photoType),
                      );
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
              text: 'Continue',
              isEnabled: _photosTakenCount >= 4,
              onPressed: _photosTakenCount >= 4
                  ? () {
                      ref.read(vehicleRegistrationProvider.notifier).confirmPhotos();
                      context.go(AppRoutes.dashboard);
                    }
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
