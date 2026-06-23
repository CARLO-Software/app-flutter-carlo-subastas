import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:google_mlkit_object_detection/google_mlkit_object_detection.dart';

class VehicleDetectorService {
  late final ObjectDetector _detector;
  bool _isProcessing = false;

  VehicleDetectorService() {
    _detector = ObjectDetector(
      options: ObjectDetectorOptions(
        mode: DetectionMode.stream,
        classifyObjects: true,
        multipleObjects: false,
      ),
    );
  }

  Future<VehicleDetectionResult> processImage(CameraImage image, CameraDescription camera) async {
    if (_isProcessing) return VehicleDetectionResult.none();
    _isProcessing = true;

    try {
      final inputImage = _convertCameraImage(image, camera);
      if (inputImage == null) return VehicleDetectionResult.none();

      final objects = await _detector.processImage(inputImage);
      debugPrint('ML Kit detected ${objects.length} objects');

      // ponytail: base model detects objects without labels, use largest object as "vehicle"
      if (objects.isEmpty) {
        return VehicleDetectionResult.none();
      }

      // Pick the largest detected object
      final vehicle = objects.reduce((a, b) =>
        (a.boundingBox.width * a.boundingBox.height) >
        (b.boundingBox.width * b.boundingBox.height) ? a : b
      );

      final imageWidth = image.width.toDouble();
      final imageHeight = image.height.toDouble();
      final box = vehicle.boundingBox;

      // Check if vehicle is centered (within 25% of center)
      final centerX = (box.left + box.right) / 2 / imageWidth;
      final centerY = (box.top + box.bottom) / 2 / imageHeight;
      final isCentered = (centerX - 0.5).abs() < 0.25 && (centerY - 0.5).abs() < 0.25;

      // Check if vehicle fills enough of frame (at least 10%)
      final coverage = (box.width * box.height) / (imageWidth * imageHeight);
      final isGoodSize = coverage > 0.10 && coverage < 0.95;

      // Debug logs
      debugPrint('>>> centerX: ${centerX.toStringAsFixed(2)}, centerY: ${centerY.toStringAsFixed(2)}, coverage: ${(coverage * 100).toStringAsFixed(1)}%');
      debugPrint('>>> isCentered: $isCentered, isGoodSize: $isGoodSize, isAligned: ${isCentered && isGoodSize}');

      return VehicleDetectionResult(
        detected: true,
        isAligned: isCentered && isGoodSize,
        boundingBox: box,
        coverage: coverage,
      );
    } finally {
      _isProcessing = false;
    }
  }

  InputImage? _convertCameraImage(CameraImage image, CameraDescription camera) {
    final rotation = InputImageRotationValue.fromRawValue(camera.sensorOrientation);
    if (rotation == null) return null;

    // Android uses YUV_420_888, need to convert to NV21
    final nv21Bytes = _yuv420ToNv21(image);

    return InputImage.fromBytes(
      bytes: nv21Bytes,
      metadata: InputImageMetadata(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        rotation: rotation,
        format: InputImageFormat.nv21,
        bytesPerRow: image.planes.first.bytesPerRow,
      ),
    );
  }

  Uint8List _yuv420ToNv21(CameraImage image) {
    final width = image.width;
    final height = image.height;
    final yPlane = image.planes[0];
    final uPlane = image.planes[1];
    final vPlane = image.planes[2];

    final nv21 = Uint8List(width * height * 3 ~/ 2);

    // Copy Y plane
    int index = 0;
    for (int row = 0; row < height; row++) {
      for (int col = 0; col < width; col++) {
        nv21[index++] = yPlane.bytes[row * yPlane.bytesPerRow + col];
      }
    }

    // Interleave V and U planes (NV21 = VUVU...)
    final uvHeight = height ~/ 2;
    final uvWidth = width ~/ 2;
    for (int row = 0; row < uvHeight; row++) {
      for (int col = 0; col < uvWidth; col++) {
        final vIndex = row * vPlane.bytesPerRow + col * vPlane.bytesPerPixel!;
        final uIndex = row * uPlane.bytesPerRow + col * uPlane.bytesPerPixel!;
        nv21[index++] = vPlane.bytes[vIndex];
        nv21[index++] = uPlane.bytes[uIndex];
      }
    }

    return nv21;
  }

  void dispose() {
    _detector.close();
  }
}

class VehicleDetectionResult {
  final bool detected;
  final bool isAligned;
  final Rect boundingBox;
  final double coverage;

  VehicleDetectionResult({
    required this.detected,
    required this.isAligned,
    required this.boundingBox,
    required this.coverage,
  });

  factory VehicleDetectionResult.none() => VehicleDetectionResult(
    detected: false,
    isAligned: false,
    boundingBox: Rect.zero,
    coverage: 0,
  );
}
