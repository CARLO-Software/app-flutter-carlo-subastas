import 'package:flutter/foundation.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

import '../../../models/photo_position.dart';

class AngleValidationResult {
  final bool isValid;
  final String? feedback;
  final double confidence;
  /// true = la IA analizó la foto y encontró un problema
  /// false = error técnico (red, API key, timeout) que no es culpa del usuario
  final bool isAiFeedback;

  const AngleValidationResult({
    required this.isValid,
    this.feedback,
    this.confidence = 0.0,
    this.isAiFeedback = false,
  });

  factory AngleValidationResult.valid() => const AngleValidationResult(
    isValid: true,
    confidence: 1.0,
  );

  /// Resultado de la IA: el ángulo o contenido de la foto no es correcto
  factory AngleValidationResult.invalid(String feedback) => AngleValidationResult(
    isValid: false,
    feedback: feedback,
    isAiFeedback: true,
  );

  /// Error técnico: no se pudo contactar la IA (red, API, etc.)
  factory AngleValidationResult.error(String feedback) => AngleValidationResult(
    isValid: false,
    feedback: feedback,
    isAiFeedback: false,
  );
}

class AngleValidatorService {
  final String _apiKey;
  final GenerativeModel _model;
  bool _isProcessing = false;

  AngleValidatorService({required String apiKey})
      : _apiKey = apiKey,
        _model = GenerativeModel(
          model: 'gemini-2.5-flash',
          apiKey: apiKey,
        );

  bool get isProcessing => _isProcessing;

  Future<AngleValidationResult> validateAngle({
    required Uint8List imageBytes,
    required PhotoAngle expectedAngle,
  }) async {
    if (_isProcessing) return AngleValidationResult.error('Validación en proceso');

    // Sin API key → saltar validación silenciosamente, no mostrar error técnico al usuario
    if (_apiKey.isEmpty) return AngleValidationResult.valid();

    _isProcessing = true;

    try {
      final prompt = _buildPrompt(expectedAngle);
      debugPrint('>>> Gemini prompt: $prompt');
      debugPrint('>>> Image bytes: ${imageBytes.length}');

      final content = [
        Content.multi([
          TextPart(prompt),
          DataPart('image/jpeg', imageBytes),
        ]),
      ];

      final response = await _model.generateContent(content);
      final text = response.text?.toLowerCase().trim() ?? '';
      debugPrint('>>> Gemini raw response: $text');

      return _parseResponse(text, expectedAngle);
    } catch (e, stack) {
      debugPrint('>>> Gemini exception: $e');
      debugPrint('>>> Stack: $stack');
      // Errores técnicos → badge [Error], no [AI]. Mensajes amigables para el usuario
      final msg = e.toString();
      if (msg.contains('SocketException') || msg.contains('ClientException') || msg.contains('TimeoutException')) {
        return AngleValidationResult.error('Sin conexión a internet');
      }
      return AngleValidationResult.error('No se pudo validar la foto');
    } finally {
      _isProcessing = false;
    }
  }

  String _buildPrompt(PhotoAngle angle) {
    final angleDesc = _getAngleDescription(angle);

    return '''
Analiza esta imagen de un vehículo. Necesito saber si la foto muestra el vehículo desde: $angleDesc.

IMPORTANTE para distinguir izquierda de derecha:
- El LADO IZQUIERDO del vehículo es donde está la puerta del conductor (en vehículos con volante a la izquierda).
- El LADO DERECHO es el lado del copiloto.
- Si ves el vehículo de perfil, identifica si el frente del auto apunta hacia tu derecha (estás viendo el lado izquierdo) o hacia tu izquierda (estás viendo el lado derecho).

Responde SOLO con una de estas opciones:
- "CORRECTO" si el ángulo coincide
- "INCORRECTO: [razón breve]" si no coincide (ej: "INCORRECTO: es el lado derecho, no el izquierdo")
- "NO_VEHICULO" si no hay vehículo visible

Sé estricto: el ángulo debe coincidir claramente.
''';
  }

  String _getAngleDescription(PhotoAngle angle) {
    switch (angle) {
      case PhotoAngle.front:
        return 'la PARTE FRONTAL (de frente, viendo el capó, parabrisas y ambos faros)';
      case PhotoAngle.rear:
        return 'la PARTE TRASERA (de atrás, viendo el maletero, ventana trasera y ambas luces)';
      case PhotoAngle.leftSide:
        return 'el LADO IZQUIERDO (perfil izquierdo completo, viendo ambas puertas del lado izquierdo)';
      case PhotoAngle.rightSide:
        return 'el LADO DERECHO (perfil derecho completo, viendo ambas puertas del lado derecho)';
      case PhotoAngle.frontLeftCorner:
        return 'la ESQUINA FRONTAL IZQUIERDA (vista 3/4 frontal desde el lado del conductor/izquierdo. Se debe ver más el lateral izquierdo que el derecho, junto con el frente)';
      case PhotoAngle.frontRightCorner:
        return 'la ESQUINA FRONTAL DERECHA (vista 3/4 frontal desde el lado del copiloto/derecho. Se debe ver más el lateral derecho que el izquierdo, junto con el frente)';
      case PhotoAngle.rearLeftCorner:
        return 'la ESQUINA TRASERA IZQUIERDA (vista 3/4 trasera desde el lado del conductor/izquierdo. Se debe ver más el lateral izquierdo que el derecho, junto con la parte trasera)';
      case PhotoAngle.rearRightCorner:
        return 'la ESQUINA TRASERA DERECHA (vista 3/4 trasera desde el lado del copiloto/derecho. Se debe ver más el lateral derecho que el izquierdo, junto con la parte trasera)';
    }
  }

  AngleValidationResult _parseResponse(String text, PhotoAngle expected) {
    if (text.startsWith('correcto')) {
      return AngleValidationResult.valid();
    }

    if (text.startsWith('no_vehiculo') || text.contains('no hay vehículo')) {
      return AngleValidationResult.invalid('No se detecta un vehículo');
    }

    if (text.startsWith('incorrecto')) {
      // Extract reason after "incorrecto:"
      final parts = text.split(':');
      final reason = parts.length > 1
          ? parts.sublist(1).join(':').trim()
          : _getDefaultFeedback(expected);
      return AngleValidationResult.invalid(_capitalize(reason));
    }

    // Fallback: try to understand the response
    if (text.contains('no') || text.contains('incorrecto')) {
      return AngleValidationResult.invalid(_getDefaultFeedback(expected));
    }

    // If unclear, assume valid to avoid blocking user
    return AngleValidationResult.valid();
  }

  String _getDefaultFeedback(PhotoAngle expected) {
    switch (expected) {
      case PhotoAngle.front:
        return 'Colócate frente al vehículo';
      case PhotoAngle.rear:
        return 'Colócate detrás del vehículo';
      case PhotoAngle.leftSide:
        return 'Muévete al lado izquierdo';
      case PhotoAngle.rightSide:
        return 'Muévete al lado derecho';
      case PhotoAngle.frontLeftCorner:
        return 'Ubícate en la esquina frontal izquierda';
      case PhotoAngle.frontRightCorner:
        return 'Ubícate en la esquina frontal derecha';
      case PhotoAngle.rearLeftCorner:
        return 'Ubícate en la esquina trasera izquierda';
      case PhotoAngle.rearRightCorner:
        return 'Ubícate en la esquina trasera derecha';
    }
  }

  String _capitalize(String s) {
    if (s.isEmpty) return s;
    return s[0].toUpperCase() + s.substring(1);
  }
}
