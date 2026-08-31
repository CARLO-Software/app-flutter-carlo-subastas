import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart' as p;

class PlateBlurService {
  final _textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

  Future<void> dispose() async {
    await _textRecognizer.close();
  }

  /// Detects license plate text and applies blur over it.
  /// Overwrites the file in place.
  /// Uses multi-pass: full image first, then cropped lower half upscaled
  /// to catch plates that are too small for ML Kit at full resolution.
  Future<bool> blurPlateInFile(String filePath) async {
    try {
      // Pass 1: full image
      var regions = await _detectPlateRegions(filePath);

      // Pass 2: crop lower 60%, upscale 2x
      if (regions.isEmpty) {
        regions = await _detectInCroppedZone(filePath, scale: 2.0);
      }

      // Pass 3: crop lower 40%, upscale 3x for very distant plates
      if (regions.isEmpty) {
        regions = await _detectInCroppedZone(filePath, scale: 3.0, cropRatio: 0.6);
      }

      if (regions.isEmpty) return false;

      final bytes = await File(filePath).readAsBytes();
      final blurred = await compute(_blurRegions, _BlurParams(bytes, regions));
      if (blurred == null) return false;

      await File(filePath).writeAsBytes(blurred);
      return true;
    } catch (e) {
      debugPrint('PlateBlurService error: $e');
      return false;
    }
  }

  Future<List<_Region>> _detectPlateRegions(String filePath) async {
    final inputImage = InputImage.fromFilePath(filePath);
    final recognized = await _textRecognizer.processImage(inputImage);
    return _findPlateBlocks(recognized, offsetX: 0, offsetY: 0, scale: 1.0);
  }

  /// Crops the lower portion of the image, upscales, runs detection,
  /// then maps coordinates back to the original image space.
  Future<List<_Region>> _detectInCroppedZone(
    String filePath, {
    double scale = 2.0,
    double cropRatio = 0.4,
  }) async {
    final originalBytes = await File(filePath).readAsBytes();
    final original = await compute(_decodeDimensions, originalBytes);
    if (original == null) return [];

    final cropTop = (original.height * cropRatio).toInt();
    final cropHeight = original.height - cropTop;

    final tempDir = p.dirname(filePath);
    final tempPath = p.join(tempDir, '_plate_detect_${DateTime.now().millisecondsSinceEpoch}.jpg');

    try {
      final cropped = await compute(
        _cropAndUpscale,
        _CropParams(originalBytes, 0, cropTop, original.width, cropHeight, scale),
      );
      if (cropped == null) return [];

      await File(tempPath).writeAsBytes(cropped);

      final inputImage = InputImage.fromFilePath(tempPath);
      final recognized = await _textRecognizer.processImage(inputImage);

      return _findPlateBlocks(
        recognized,
        offsetX: 0,
        offsetY: cropTop,
        scale: 1.0 / scale,
      );
    } finally {
      try {
        await File(tempPath).delete();
      } catch (_) {}
    }
  }

  List<_Region> _findPlateBlocks(
    RecognizedText recognized, {
    required int offsetX,
    required int offsetY,
    required double scale,
  }) {
    final regions = <_Region>[];

    for (final block in recognized.blocks) {
      final text = block.text.replaceAll(RegExp(r'[\s\-]'), '');
      if (text.length < 4 || text.length > 12) continue;

      final alphanumRatio =
          RegExp(r'[A-Z0-9]', caseSensitive: false).allMatches(text).length /
              text.length;
      if (alphanumRatio < 0.7) continue;

      final rect = block.boundingBox;
      final aspect = rect.width / rect.height;
      if (aspect < 1.2 || aspect > 10) continue;

      // Map back to original coordinates
      final padding = 15.0;
      regions.add(_Region(
        left: ((rect.left * scale) + offsetX - padding).clamp(0, double.infinity).toInt(),
        top: ((rect.top * scale) + offsetY - padding).clamp(0, double.infinity).toInt(),
        right: ((rect.right * scale) + offsetX + padding).toInt(),
        bottom: ((rect.bottom * scale) + offsetY + padding).toInt(),
      ));
    }

    return regions;
  }
}

class _Region {
  final int left, top, right, bottom;
  const _Region({
    required this.left,
    required this.top,
    required this.right,
    required this.bottom,
  });
}

class _BlurParams {
  final Uint8List imageBytes;
  final List<_Region> regions;
  _BlurParams(this.imageBytes, this.regions);
}

class _CropParams {
  final Uint8List imageBytes;
  final int x, y, width, height;
  final double upscale;
  _CropParams(this.imageBytes, this.x, this.y, this.width, this.height, this.upscale);
}

class _ImageSize {
  final int width, height;
  _ImageSize(this.width, this.height);
}

_ImageSize? _decodeDimensions(Uint8List bytes) {
  final image = img.decodeImage(bytes);
  if (image == null) return null;
  return _ImageSize(image.width, image.height);
}

Uint8List? _cropAndUpscale(_CropParams p) {
  final image = img.decodeImage(p.imageBytes);
  if (image == null) return null;

  final cropped = img.copyCrop(image,
      x: p.x, y: p.y, width: p.width, height: p.height);
  final upscaled = img.copyResize(cropped,
      width: (p.width * p.upscale).toInt(),
      height: (p.height * p.upscale).toInt(),
      interpolation: img.Interpolation.cubic);

  return Uint8List.fromList(img.encodeJpg(upscaled, quality: 90));
}

Uint8List? _blurRegions(_BlurParams params) {
  final image = img.decodeImage(params.imageBytes);
  if (image == null) return null;

  for (final region in params.regions) {
    final left = region.left.clamp(0, image.width - 1);
    final top = region.top.clamp(0, image.height - 1);
    final right = region.right.clamp(0, image.width);
    final bottom = region.bottom.clamp(0, image.height);
    final w = right - left;
    final h = bottom - top;
    if (w <= 0 || h <= 0) continue;

    final cropped = img.copyCrop(image, x: left, y: top, width: w, height: h);
    final blurred = img.gaussianBlur(cropped, radius: 25);
    img.compositeImage(image, blurred, dstX: left, dstY: top);
  }

  return Uint8List.fromList(img.encodeJpg(image, quality: 92));
}
