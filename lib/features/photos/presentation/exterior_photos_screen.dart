import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/providers/providers.dart';
import '../../../shared/widgets/widgets.dart';
import '../providers/guided_capture_provider.dart';
import '../services/angle_validator_service.dart';
import '../widgets/widgets.dart';

class ExteriorPhotosScreen extends ConsumerStatefulWidget {
  const ExteriorPhotosScreen({super.key});

  @override
  ConsumerState<ExteriorPhotosScreen> createState() => _ExteriorPhotosScreenState();
}

class _ExteriorPhotosScreenState extends ConsumerState<ExteriorPhotosScreen> {
  AngleValidatorService? _validator;
  bool _isValidating = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _showIntroPopup());
  }

  static const _exteriorSections = [
    {'name': 'Lado del conductor', 'reference': 'assets/images/exterior/exterior-lado-izquierdo.webp', 'instructions': ''},
    {'name': 'Lado del copiloto', 'reference': 'assets/images/exterior/exterior-lado-derecho.webp', 'instructions': ''},
    {'name': 'Lado trasero', 'reference': 'assets/images/exterior/exterior-trasero.webp', 'instructions': ''},
    {'name': 'Lado frontal', 'reference': 'assets/images/exterior/exterior-frontal.webp', 'instructions': ''},
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
                        'Fotos exteriores',
                        style: AppTypography.headlineSmall.copyWith(fontWeight: FontWeight.w700),
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
                                Icon(Icons.check_circle_outline, size: 18, color: c.textPrimary),
                                AppSpacing.hGapSm,
                                Expanded(
                                  child: Text(
                                    'Toma las fotos a unos 3 metros de distancia del vehículo.',
                                    style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                            AppSpacing.vGapSm,
                            Row(
                              children: [
                                Icon(Icons.check_circle_outline, size: 18, color: c.textPrimary),
                                AppSpacing.hGapSm,
                                Expanded(
                                  child: Text(
                                    'Asegúrate de que todo el vehículo esté visible en la foto.',
                                    style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      AppSpacing.vGapXxl,
                      ..._exteriorSections.map((section) => Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.xxl),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              section['name']!,
                              style: AppTypography.titleMedium.copyWith(fontWeight: FontWeight.w700),
                            ),
                            if (section['instructions']!.isNotEmpty) ...[
                              AppSpacing.vGapXs,
                              Text(
                                section['instructions']!,
                                style: AppTypography.bodySmall.copyWith(color: c.textSecondary),
                              ),
                            ],
                            AppSpacing.vGapMd,
                            ClipRRect(
                              borderRadius: AppSpacing.borderRadiusMd,
                              child: Image.asset(
                                section['reference']!,
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

  final Map<String, PhotoValidationStatus> _validationStatus = {};
  final Map<String, String> _validationFeedback = {};
  final Map<String, bool> _isAiFeedback = {};

  AngleValidatorService get validator {
    _validator ??= AngleValidatorService(apiKey: AppConstants.geminiApiKey);
    return _validator!;
  }

  Future<void> _validateAllPhotos() async {
    final photos = ref.read(vehicleRegistrationProvider).exteriorPhotosMap;
    if (photos.isEmpty) return;

    setState(() => _isValidating = true);

    final photosToValidate = AppConstants.photoPositions
        .where((p) => photos.containsKey(p.id))
        .where((p) => _validationStatus[p.id] != PhotoValidationStatus.valid)
        .toList();

    if (photosToValidate.isEmpty) {
      setState(() => _isValidating = false);
      ref.read(vehicleRegistrationProvider.notifier).confirmPhotos();
      context.go(AppRoutes.dashboard);
      return;
    }

    for (var i = 0; i < photosToValidate.length; i++) {
      final position = photosToValidate[i];
      final path = photos[position.id]!;

      setState(() {
        _validationStatus[position.id] = PhotoValidationStatus.validating;
      });

      try {
        final bytes = await File(path).readAsBytes();
        final result = await validator.validateAngle(
          imageBytes: bytes,
          expectedAngle: position.angle,
        );

        if (!mounted) return;

        setState(() {
          if (result.isValid) {
            _validationStatus[position.id] = PhotoValidationStatus.valid;
            _validationFeedback.remove(position.id);
            _isAiFeedback.remove(position.id);
          } else {
            _validationStatus[position.id] = PhotoValidationStatus.invalid;
            _validationFeedback[position.id] = result.feedback ?? 'Ángulo incorrecto';
            _isAiFeedback[position.id] = result.isAiFeedback;
          }
        });
      } catch (e) {
        if (!mounted) return;
        setState(() {
          _validationStatus[position.id] = PhotoValidationStatus.valid;
        });
      }

      if (i < photosToValidate.length - 1) {
        await Future.delayed(const Duration(seconds: 2));
      }
    }

    if (!mounted) return;
    setState(() => _isValidating = false);

    final hasInvalid = _validationStatus.values.contains(PhotoValidationStatus.invalid);
    if (!hasInvalid) {
      ref.read(vehicleRegistrationProvider.notifier).confirmPhotos();
      context.push(AppRoutes.conditionDamage);
    }
  }

  Future<void> _retakePhoto(String positionId) async {
    ref.read(vehicleRegistrationProvider.notifier).removeExteriorPhotoByPosition(positionId);
    setState(() {
      _validationStatus.remove(positionId);
      _validationFeedback.remove(positionId);
      _isAiFeedback.remove(positionId);
    });

    final index = AppConstants.photoPositions.indexWhere((p) => p.id == positionId);
    if (index >= 0) {
      ref.read(guidedCaptureProvider.notifier).initializeWithExistingPhotos(
        ref.read(vehicleRegistrationProvider).exteriorPhotosMap,
      );
      ref.read(guidedCaptureProvider.notifier).goToPosition(index);
      await context.push(AppRoutes.guidedCapture);

      // After returning from capture, validate the retaken photo
      if (mounted) {
        _validateSinglePhoto(positionId);
      }
    }
  }

  Future<void> _validateSinglePhoto(String positionId) async {
    final photos = ref.read(vehicleRegistrationProvider).exteriorPhotosMap;
    final path = photos[positionId];
    if (path == null) return;

    final position = AppConstants.photoPositions.firstWhere((p) => p.id == positionId);

    setState(() {
      _validationStatus[positionId] = PhotoValidationStatus.validating;
    });

    try {
      final bytes = await File(path).readAsBytes();
      final result = await validator.validateAngle(
        imageBytes: bytes,
        expectedAngle: position.angle,
      );

      if (!mounted) return;

      setState(() {
        if (result.isValid) {
          _validationStatus[positionId] = PhotoValidationStatus.valid;
          _validationFeedback.remove(positionId);
          _isAiFeedback.remove(positionId);
        } else {
          _validationStatus[positionId] = PhotoValidationStatus.invalid;
          _validationFeedback[positionId] = result.feedback ?? 'Ángulo incorrecto';
          _isAiFeedback[positionId] = result.isAiFeedback;
        }
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _validationStatus[positionId] = PhotoValidationStatus.valid;
      });
    }

    _navigateIfAllValid();
  }

  void _acceptPhoto(String positionId) {
    setState(() {
      _validationStatus[positionId] = PhotoValidationStatus.valid;
      _validationFeedback.remove(positionId);
      _isAiFeedback.remove(positionId);
    });
    _navigateIfAllValid();
  }

  void _navigateIfAllValid() {
    final photos = ref.read(vehicleRegistrationProvider).exteriorPhotosMap;
    final allValidated = AppConstants.photoPositions
        .where((p) => photos.containsKey(p.id))
        .every((p) => _validationStatus[p.id] == PhotoValidationStatus.valid);

    if (allValidated && photos.isNotEmpty) {
      ref.read(vehicleRegistrationProvider.notifier).confirmPhotos();
      context.push(AppRoutes.conditionDamage);
    }
  }

  void _startGuidedCapture() {
    ref.read(guidedCaptureProvider.notifier).initializeWithExistingPhotos(
      ref.read(vehicleRegistrationProvider).exteriorPhotosMap,
    );
    context.push(AppRoutes.guidedCapture);
  }

  void _onPhotoCardTap(String positionId) {
    final hasPhoto = ref.read(vehicleRegistrationProvider).exteriorPhotosMap.containsKey(positionId);

    if (hasPhoto) {
      _showPhotoOptions(positionId);
    } else {
      final index = AppConstants.photoPositions.indexWhere((p) => p.id == positionId);
      if (index >= 0) {
        ref.read(guidedCaptureProvider.notifier).goToPosition(index);
        context.push(AppRoutes.guidedCapture);
      }
    }
  }

  void _showPhotoOptions(String positionId) {
    final photoPath = ref.read(vehicleRegistrationProvider).exteriorPhotosMap[positionId];
    if (photoPath == null) return;

    showModalBottomSheet(
      context: context,
      backgroundColor: context.colors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppSpacing.radiusLg)),
      ),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.fullscreen),
                title: const Text('Ver foto completa'),
                onTap: () {
                  Navigator.pop(ctx);
                  _showFullPhoto(photoPath, positionId);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt_outlined),
                title: const Text('Volver a tomar foto'),
                onTap: () {
                  Navigator.pop(ctx);
                  _retakePhoto(positionId);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showFullPhoto(String photoPath, String positionId) {
    final positionName = AppConstants.photoPositions
        .firstWhere((p) => p.id == positionId)
        .name;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            title: Text(positionName),
          ),
          body: Center(
            child: InteractiveViewer(
              minScale: 0.5,
              maxScale: 4.0,
              child: Image.file(
                File(photoPath),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool get _hasInvalidPhotos =>
      _validationStatus.values.contains(PhotoValidationStatus.invalid);

  int get _photosTakenCount {
    return ref.watch(vehicleRegistrationProvider.select((s) => s.exteriorPhotosMap)).length;
  }

  @override
  Widget build(BuildContext context) {
    final exteriorPhotosMap = ref.watch(vehicleRegistrationProvider.select((s) => s.exteriorPhotosMap));
    final totalPhotos = AppConstants.photoPositions.length;

    final c = context.colors;
    return Scaffold(
      backgroundColor: c.background,
      appBar: AppBar(
        title: const Text('Fotos Exteriores'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go(AppRoutes.dashboard),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: _showIntroPopup,
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            color: c.surfaceVariant,
            child: Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: AppSpacing.borderRadiusFull,
                    child: LinearProgressIndicator(
                      value: _photosTakenCount / totalPhotos,
                      backgroundColor: c.border,
                      valueColor: const AlwaysStoppedAnimation<Color>(AppColors.success),
                      minHeight: 8,
                    ),
                  ),
                ),
                AppSpacing.hGapMd,
                Text(
                  '$_photosTakenCount/$totalPhotos',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: c.textSecondary,
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
                  GestureDetector(
                    onTap: _startGuidedCapture,
                    child: Container(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                          AppSpacing.hGapMd,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Iniciar Captura Guiada',
                                  style: AppTypography.titleMedium.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                AppSpacing.vGapXxs,
                                Text(
                                  'Te guiaremos en cada ángulo',
                                  style: AppTypography.bodySmall.copyWith(
                                    color: Colors.white.withValues(alpha: 0.9),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ),
                  AppSpacing.vGapLg,
                  const SectionHeader(
                    title: 'Vista General de Fotos',
                    subtitle: 'Toca cualquier foto para capturar o retomar',
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
                    itemCount: AppConstants.photoPositions.length,
                    itemBuilder: (context, index) {
                      final position = AppConstants.photoPositions[index];
                      final photoPath = exteriorPhotosMap[position.id];
                      return PhotoCard(
                        title: position.name,
                        imagePath: photoPath,
                        angle: position.angle,
                        onTap: () => _onPhotoCardTap(position.id),
                        validationStatus: _validationStatus[position.id] ?? PhotoValidationStatus.none,
                        validationFeedback: _validationFeedback[position.id],
                        isAiFeedback: _isAiFeedback[position.id] ?? true,
                        onRetake: () => _retakePhoto(position.id),
                        onAccept: () => _acceptPhoto(position.id),
                      );
                    },
                  ),
                  AppSpacing.vGapLg,
                ],
              ),
            ),
          ),
          BottomActionBar(
            child: PrimaryButton(
              text: _isValidating ? 'Validando fotos...' : _hasInvalidPhotos ? 'Corrige las fotos marcadas' : 'Continuar',
              isEnabled: _photosTakenCount >= 4 && !_isValidating && !_hasInvalidPhotos,
              onPressed: _photosTakenCount >= 4 && !_isValidating && !_hasInvalidPhotos
                  ? _validateAllPhotos
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
