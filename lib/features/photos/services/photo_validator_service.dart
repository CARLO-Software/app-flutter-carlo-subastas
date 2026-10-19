import 'package:flutter/foundation.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class PhotoValidationFeedback {
  final bool isValid;
  final String? shortMessage;
  final String? detail;

  const PhotoValidationFeedback({required this.isValid, this.shortMessage, this.detail});

  factory PhotoValidationFeedback.valid() => const PhotoValidationFeedback(isValid: true);
}

class PhotoValidatorService {
  final GenerativeModel _model;

  PhotoValidatorService({required String apiKey})
      : _model = GenerativeModel(model: 'gemini-2.5-flash', apiKey: apiKey);

  Future<PhotoValidationFeedback> validate({
    required Uint8List imageBytes,
    required String expectedSubject,
  }) async {
    try {
      final response = await _model.generateContent([
        Content.multi([
          TextPart('''
Analiza esta foto. Se espera que muestre: $expectedSubject.

Responde EXACTAMENTE en este formato (sin markdown):
CORRECTO
o
INCORRECTO|resumen corto (max 8 palabras)|detalle explicativo (1-2 oraciones)

Ejemplos de respuesta:
CORRECTO
INCORRECTO|Vehículo fuera del encuadre|El vehículo no está centrado en la imagen. Asegúrate de que el vehículo completo sea visible dentro del marco.
INCORRECTO|No se detecta llanta|La imagen no muestra una llanta de vehículo. Acerca la cámara a la llanta.
'''),
          DataPart('image/jpeg', imageBytes),
        ]),
      ]);

      final text = response.text?.trim() ?? '';
      debugPrint('>>> PhotoValidator response: $text');

      if (text.toUpperCase().startsWith('CORRECTO')) {
        return PhotoValidationFeedback.valid();
      }

      final parts = text.replaceFirst(RegExp(r'^INCORRECTO\|?', caseSensitive: false), '').split('|');
      final short = parts.isNotEmpty && parts[0].isNotEmpty ? parts[0].trim() : 'Foto no válida';
      final detail = parts.length > 1 ? parts[1].trim() : short;

      return PhotoValidationFeedback(isValid: false, shortMessage: short, detail: detail);
    } catch (e) {
      debugPrint('>>> PhotoValidator error: $e');
      return PhotoValidationFeedback.valid();
    }
  }
}
