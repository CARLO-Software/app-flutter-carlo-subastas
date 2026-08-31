import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_constants.dart';
import '../../core/services/api_client.dart';
import '../../models/models.dart';

enum SubmissionPhase { idle, uploadingPhotos, submittingData, done, error }

class SubmissionProgress {
  final SubmissionPhase phase;
  final int totalPhotos;
  final int uploadedPhotos;
  final String currentPhotoLabel;
  final double currentFileProgress;
  final String? errorMessage;

  const SubmissionProgress({
    this.phase = SubmissionPhase.idle,
    this.totalPhotos = 0,
    this.uploadedPhotos = 0,
    this.currentPhotoLabel = '',
    this.currentFileProgress = 0.0,
    this.errorMessage,
  });

  SubmissionProgress copyWith({
    SubmissionPhase? phase,
    int? totalPhotos,
    int? uploadedPhotos,
    String? currentPhotoLabel,
    double? currentFileProgress,
    String? errorMessage,
  }) {
    return SubmissionProgress(
      phase: phase ?? this.phase,
      totalPhotos: totalPhotos ?? this.totalPhotos,
      uploadedPhotos: uploadedPhotos ?? this.uploadedPhotos,
      currentPhotoLabel: currentPhotoLabel ?? this.currentPhotoLabel,
      currentFileProgress: currentFileProgress ?? this.currentFileProgress,
      errorMessage: errorMessage,
    );
  }
}

class SubmissionNotifier extends Notifier<SubmissionProgress> {
  @override
  SubmissionProgress build() => const SubmissionProgress();

  void reset() => state = const SubmissionProgress();

  Future<bool> submit(VehicleRegistrationState registration) async {
    final api = ref.read(apiClientProvider);

    // Collect all photos to upload: (filePath, category, positionId, label)
    final uploads = <_PhotoUpload>[];

    for (final entry in registration.exteriorPhotosMap.entries) {
      final label = AppConstants.photoPositions
          .where((p) => p.id == entry.key)
          .map((p) => p.name)
          .firstOrNull ?? entry.key;
      uploads.add(_PhotoUpload(entry.value, 'exterior', entry.key, label));
    }

    for (final entry in registration.interiorPhotosMap.entries) {
      uploads.add(_PhotoUpload(entry.value, 'interior', entry.key, entry.key));
    }

    for (final damage in registration.damages) {
      if (damage.photoPath != null) {
        uploads.add(_PhotoUpload(damage.photoPath!, 'damage', damage.id, 'Daño: ${damage.type}'));
      }
    }

    for (var i = 0; i < registration.serviceDocuments.length; i++) {
      uploads.add(_PhotoUpload(registration.serviceDocuments[i], 'service_document', null, 'Documento ${i + 1}'));
    }

    state = SubmissionProgress(
      phase: SubmissionPhase.uploadingPhotos,
      totalPhotos: uploads.length,
    );

    // Upload photos
    final exteriorIds = <String, String>{};
    final interiorIds = <String, String>{};
    final damageIds = <String>[];
    final serviceDocIds = <String>[];
    final damagePhotoMap = <String, String>{}; // damageItem.id → photoId

    try {
      for (var i = 0; i < uploads.length; i++) {
        final upload = uploads[i];
        state = state.copyWith(
          uploadedPhotos: i,
          currentPhotoLabel: upload.label,
          currentFileProgress: 0.0,
        );

        final photoId = await api.uploadPhoto(
          filePath: upload.filePath,
          category: upload.category,
          positionId: upload.positionId,
          onProgress: (sent, total) {
            if (total > 0) {
              state = state.copyWith(currentFileProgress: sent / total);
            }
          },
        );

        switch (upload.category) {
          case 'exterior':
            exteriorIds[upload.positionId!] = photoId;
          case 'interior':
            interiorIds[upload.positionId!] = photoId;
          case 'damage':
            damageIds.add(photoId);
            damagePhotoMap[upload.positionId!] = photoId;
          case 'service_document':
            serviceDocIds.add(photoId);
        }
      }

      state = state.copyWith(
        phase: SubmissionPhase.submittingData,
        uploadedPhotos: uploads.length,
        currentFileProgress: 1.0,
      );

      // Build payload
      final vehicle = registration.vehicle!;
      final payload = <String, dynamic>{
        'vehicle': {
          'plate': vehicle.plate,
          'brand': vehicle.brand,
          'model': vehicle.model,
          'year': vehicle.year,
          'color': vehicle.color,
          'fuelType': vehicle.fuelType,
          'bodyType': vehicle.bodyType,
          'doors': vehicle.doors,
          'transmission': vehicle.transmission,
          'engineSize': vehicle.engineSize,
          'ownership': vehicle.ownership,
          'motExpiry': vehicle.motExpiry,
        },
        'registration': {
          'mileage': registration.mileage,
          'extraFeatures': registration.extraFeatures,
          'numberOfKeys': registration.numberOfKeys,
          'hasFinance': registration.hasFinance,
          'runningCondition': registration.runningCondition?.name,
          'mechanicalIssues': registration.mechanicalIssues,
          'serviceHistoryType': registration.serviceHistoryType?.name,
        },
        'photos': {
          'exterior': exteriorIds,
          'interior': interiorIds,
          'damage': damageIds,
          'serviceDocuments': serviceDocIds,
        },
        'damages': registration.damages.map((d) => {
          'type': d.type,
          'location': d.location,
          'description': d.description,
          'photoId': damagePhotoMap[d.id],
        }).toList(),
      };

      await api.submitRegistration(payload);
      state = state.copyWith(phase: SubmissionPhase.done);
      return true;
    } catch (e) {
      debugPrint('Submission error: $e');
      state = state.copyWith(
        phase: SubmissionPhase.error,
        errorMessage: _mapError(e),
      );
      return false;
    }
  }

  String _mapError(Object e) {
    if (e is DioException) {
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.connectionError:
          return 'Sin conexión a internet. Verifica tu red.';
        case DioExceptionType.sendTimeout:
          return 'La subida tardó demasiado. Verifica tu conexión.';
        case DioExceptionType.receiveTimeout:
          return 'El servidor tardó en responder. Intenta más tarde.';
        default:
          break;
      }
      final status = e.response?.statusCode;
      if (status == 413) return 'Una foto es demasiado grande. Intenta con menor resolución.';
      if (status == 400) return 'Datos inválidos. Revisa la información e intenta de nuevo.';
      if (status == 409) return 'Este vehículo ya fue registrado.';
      if (status != null && status >= 500) return 'Error del servidor. Intenta más tarde.';
    }
    return 'Error inesperado. Intenta de nuevo.';
  }
}

class _PhotoUpload {
  final String filePath;
  final String category;
  final String? positionId;
  final String label;
  const _PhotoUpload(this.filePath, this.category, this.positionId, this.label);
}

final submissionProvider =
    NotifierProvider<SubmissionNotifier, SubmissionProgress>(
  SubmissionNotifier.new,
);
