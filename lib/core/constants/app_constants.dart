import '../../models/photo_position.dart';

class AppConstants {
  AppConstants._();

  // App Info
  static const String appName = 'Carlo Subastas';
  static const String appVersion = '1.0.0';

  // API Configuration — passed via --dart-define-from-file=.env
  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://api.carlo.pe/v1',
  );

  // AI Configuration — passed via --dart-define-from-file=.env
  static const String geminiApiKey = String.fromEnvironment('GEMINI_API_KEY');

  // Photo Position Definitions
  static const List<PhotoPositionData> photoPositions = [
    PhotoPositionData(
      id: 'front',
      name: 'Frontal',
      angle: PhotoAngle.front,
      instructions: 'Colócate frente al vehículo, a unos 3 metros. Centra el auto en el encuadre.',
      order: 1,
    ),
    PhotoPositionData(
      id: 'rear',
      name: 'Trasera',
      angle: PhotoAngle.rear,
      instructions: 'Colócate detrás del vehículo, a unos 3 metros. Captura toda la vista trasera.',
      order: 2,
    ),
    PhotoPositionData(
      id: 'left_side',
      name: 'Lado Izquierdo',
      angle: PhotoAngle.leftSide,
      instructions: 'Ubícate al lado izquierdo del vehículo. Captura todo el perfil lateral.',
      order: 3,
    ),
    PhotoPositionData(
      id: 'right_side',
      name: 'Lado Derecho',
      angle: PhotoAngle.rightSide,
      instructions: 'Ubícate al lado derecho del vehículo. Captura todo el perfil lateral.',
      order: 4,
    ),
    PhotoPositionData(
      id: 'front_left_corner',
      name: 'Esquina Frontal Izq.',
      angle: PhotoAngle.frontLeftCorner,
      instructions: 'Colócate en ángulo de 45° desde el frente izquierdo. Muestra el frente y el lado izquierdo.',
      order: 5,
    ),
    PhotoPositionData(
      id: 'front_right_corner',
      name: 'Esquina Frontal Der.',
      angle: PhotoAngle.frontRightCorner,
      instructions: 'Colócate en ángulo de 45° desde el frente derecho. Muestra el frente y el lado derecho.',
      order: 6,
    ),
    PhotoPositionData(
      id: 'rear_left_corner',
      name: 'Esquina Trasera Izq.',
      angle: PhotoAngle.rearLeftCorner,
      instructions: 'Colócate en ángulo de 45° desde la parte trasera izquierda. Muestra la trasera y el lado izquierdo.',
      order: 7,
    ),
    PhotoPositionData(
      id: 'rear_right_corner',
      name: 'Esquina Trasera Der.',
      angle: PhotoAngle.rearRightCorner,
      instructions: 'Colócate en ángulo de 45° desde la parte trasera derecha. Muestra la trasera y el lado derecho.',
      order: 8,
    ),
  ];

  // Interior Photo Positions
  static const List<Map<String, String>> interiorPhotoPositions = [
    {'id': 'dashboard', 'name': 'Tablero', 'instructions': 'Fotografía el tablero completo con el volante visible'},
    {'id': 'front_seats', 'name': 'Asientos delanteros', 'instructions': 'Captura ambos asientos delanteros desde la puerta trasera'},
    {'id': 'rear_seats', 'name': 'Asientos traseros', 'instructions': 'Fotografía los asientos traseros desde el frente'},
    {'id': 'trunk', 'name': 'Maletero', 'instructions': 'Abre el maletero y fotografía el espacio completo'},
    {'id': 'odometer', 'name': 'Odómetro', 'instructions': 'Acércate al odómetro para que el kilometraje sea legible'},
    {'id': 'center_console', 'name': 'Consola central', 'instructions': 'Fotografía la consola central y la palanca de cambios'},
  ];

  // Extra Features Options
  static const List<String> extraFeatureOptions = [
    'GPS / Navegación',
    'Bluetooth',
    'Apple CarPlay',
    'Android Auto',
    'Techo solar',
    'Entrada sin llave',
    'Asientos calefactados',
    'Barras de techo',
    'Cámara de retroceso',
    'Asientos de cuero',
    'Porta bicicletas',
    'Alerta de punto ciego',
    'Enganche de remolque',
  ];

  // Mechanical Issue Options
  static const List<String> mechanicalIssueOptions = [
    'Cierre centralizado',
    'Luces delanteras',
    'Ventanas eléctricas',
    'Fuga de aceite',
    'Ruido extraño',
    'Luces traseras',
    'Sensores de estacionamiento',
    'Pastillas de freno',
    'Sistema multimedia',
    'Aire acondicionado',
    'Otro problema',
  ];

  // Damage Types
  static const List<String> damageTypes = [
    'Rayón',
    'Abolladura',
    'Daño de pintura',
  ];

  // Photo Types
  static const List<String> exteriorPhotoTypes = [
    'Frontal',
    'Trasera',
    'Lado Izquierdo',
    'Lado Derecho',
    'Esquina Frontal Izq.',
    'Esquina Frontal Der.',
    'Esquina Trasera Izq.',
    'Esquina Trasera Der.',
  ];

  // Animation Durations
  static const Duration animationFast = Duration(milliseconds: 200);
  static const Duration animationNormal = Duration(milliseconds: 300);
  static const Duration animationSlow = Duration(milliseconds: 500);
}
