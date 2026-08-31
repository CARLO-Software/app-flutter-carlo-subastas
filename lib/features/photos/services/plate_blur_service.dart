import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image/image.dart' as img;

class PlateBlurService {
  final _textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

  Future<void> dispose() async {
    await _textRecognizer.close();
  }

  /// Detects license plate text and applies blur over it.
  /// Overwrites the file in place.
  Future<bool> blurPlateInFile(String filePath) async {
    try {
      final inputImage = InputImage.fromFilePath(filePath);
      final recognized = await _textRecognizer.processImage(inputImage);

      final plateBlocks = _findPlateBlocks(recognized);
      if (plateBlocks.isEmpty) return false;

      final bytes = await File(filePath).readAsBytes();
      final blurred = await compute(_blurRegions, _BlurParams(bytes, plateBlocks));
      if (blurred == null) return false;

      await File(filePath).writeAsBytes(blurred);
      return true;
    } catch (e) {
      debugPrint('PlateBlurService error: $e');
      return false;
    }
  }

  /// Heuristic: a plate is a text block with 5-10 chars, mostly alphanumeric,
  /// with a roughly horizontal rectangular bounding box.
  List<_Region> _findPlateBlocks(RecognizedText recognized) {
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
      // ponytail: plates are wide rectangles, aspect 1.5-8
      if (aspect < 1.2 || aspect > 10) continue;

      // Expand region a bit for padding
      regions.add(_Region(
        left: (rect.left - 10).clamp(0, double.infinity).toInt(),
        top: (rect.top - 10).clamp(0, double.infinity).toInt(),
        right: (rect.right + 10).toInt(),
        bottom: (rect.bottom + 10).toInt(),
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

/// Runs in isolate via compute()
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

    // Extract, blur heavily, paste back
    final cropped = img.copyCrop(image, x: left, y: top, width: w, height: h);
    final blurred = img.gaussianBlur(cropped, radius: 25);
    img.compositeImage(image, blurred, dstX: left, dstY: top);
  }

  return Uint8List.fromList(img.encodeJpg(image, quality: 92));
}
