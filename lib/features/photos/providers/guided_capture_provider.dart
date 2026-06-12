import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_constants.dart';
import '../../../models/photo_position.dart';

class GuidedCaptureState {
  final int currentIndex;
  final Map<String, String> capturedPhotos;
  final bool isCapturing;
  final String? previewPath;
  final String? error;

  const GuidedCaptureState({
    this.currentIndex = 0,
    this.capturedPhotos = const {},
    this.isCapturing = false,
    this.previewPath,
    this.error,
  });

  GuidedCaptureState copyWith({
    int? currentIndex,
    Map<String, String>? capturedPhotos,
    bool? isCapturing,
    String? previewPath,
    String? error,
  }) {
    return GuidedCaptureState(
      currentIndex: currentIndex ?? this.currentIndex,
      capturedPhotos: capturedPhotos ?? this.capturedPhotos,
      isCapturing: isCapturing ?? this.isCapturing,
      previewPath: previewPath,
      error: error,
    );
  }

  PhotoPositionData get currentPosition =>
      AppConstants.photoPositions[currentIndex];

  int get totalPositions => AppConstants.photoPositions.length;

  bool get isLastPosition => currentIndex >= totalPositions - 1;

  bool get isFirstPosition => currentIndex <= 0;

  Set<int> get completedIndices {
    final completed = <int>{};
    for (int i = 0; i < AppConstants.photoPositions.length; i++) {
      final position = AppConstants.photoPositions[i];
      if (capturedPhotos.containsKey(position.id)) {
        completed.add(i);
      }
    }
    return completed;
  }

  int get completedCount => capturedPhotos.length;

  bool get allPhotosCompleted => completedCount >= totalPositions;
}

class GuidedCaptureNotifier extends Notifier<GuidedCaptureState> {
  @override
  GuidedCaptureState build() {
    return const GuidedCaptureState();
  }

  void setCapturing(bool isCapturing) {
    state = state.copyWith(isCapturing: isCapturing);
  }

  void setPreviewPath(String? path) {
    state = state.copyWith(previewPath: path);
  }

  void setError(String? error) {
    state = state.copyWith(error: error);
  }

  void capturePhoto(String positionId, String filePath) {
    final newPhotos = Map<String, String>.from(state.capturedPhotos);
    newPhotos[positionId] = filePath;
    state = state.copyWith(
      capturedPhotos: newPhotos,
      previewPath: null,
    );
  }

  void removePhoto(String positionId) {
    final newPhotos = Map<String, String>.from(state.capturedPhotos);
    newPhotos.remove(positionId);
    state = state.copyWith(capturedPhotos: newPhotos);
  }

  void goToNext() {
    if (!state.isLastPosition) {
      state = state.copyWith(
        currentIndex: state.currentIndex + 1,
        previewPath: null,
      );
    }
  }

  void goToPrevious() {
    if (!state.isFirstPosition) {
      state = state.copyWith(
        currentIndex: state.currentIndex - 1,
        previewPath: null,
      );
    }
  }

  void goToPosition(int index) {
    if (index >= 0 && index < state.totalPositions) {
      state = state.copyWith(
        currentIndex: index,
        previewPath: null,
      );
    }
  }

  void reset() {
    state = const GuidedCaptureState();
  }

  void initializeWithExistingPhotos(Map<String, String> existingPhotos) {
    state = GuidedCaptureState(capturedPhotos: existingPhotos);
  }
}

final guidedCaptureProvider =
    NotifierProvider<GuidedCaptureNotifier, GuidedCaptureState>(
  GuidedCaptureNotifier.new,
);
