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
    {'id': 'front_seats', 'name': 'Asientos frontales', 'instructions': '', 'reference': 'assets/images/interior/interior-asiento-1.webp'},
    {'id': 'instrument_panel', 'name': 'Tablero de instrumentos', 'instructions': 'Siéntate en el asiento del conductor y enciende el motor', 'reference': 'assets/images/interior/interior-tablero-instrumentos.webp'},
    {'id': 'rear_seats', 'name': 'Asientos traseros', 'instructions': 'Abre todas las puertas para una mejor iluminación', 'reference': 'assets/images/interior/interior-asiento-4.webp', 'optional': 'true'},
    {'id': 'dashboard', 'name': 'Tablero', 'instructions': 'Endereza el volante y mantén el motor encendido para que el tablero esté iluminado', 'reference': 'assets/images/interior/interior-seccion-delantera.webp'},
    {'id': 'trunk', 'name': 'Maletera', 'instructions': 'Abre la maletera y fotografía el espacio completo', 'reference': 'assets/images/interior/interior-maletera.webp', 'optional': 'true'},
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

  // Exterior reference photos (real photos showing expected angle)
  static String referenceForAngle(PhotoAngle angle) => switch (angle) {
    PhotoAngle.front => 'assets/images/exterior/exterior-frontal.webp',
    PhotoAngle.rear => 'assets/images/exterior/exterior-trasero.webp',
    PhotoAngle.leftSide => 'assets/images/exterior/exterior-lado-izquierdo.webp',
    PhotoAngle.rightSide => 'assets/images/exterior/exterior-lado-derecho.webp',
    PhotoAngle.frontLeftCorner => 'assets/images/exterior/exterior-angulo-izquierdo.webp',
    PhotoAngle.frontRightCorner => 'assets/images/exterior/exterior-angulo-derecho.webp',
    PhotoAngle.rearLeftCorner => 'assets/images/exterior/exterior-trasero-angulo-izquierdo.webp',
    PhotoAngle.rearRightCorner => 'assets/images/exterior/exterior-trasero-angulo-derecho.webp',
  };

  // Card silhouettes (black, for cards before photo is taken)
  static String templateForAngle(PhotoAngle angle) => switch (angle) {
    PhotoAngle.front => 'assets/images/plantillas/siluetas_negro/exterior/png/exterior-frontal.png',
    PhotoAngle.rear => 'assets/images/plantillas/siluetas_negro/exterior/png/exterior-trasera.png',
    PhotoAngle.leftSide => 'assets/images/plantillas/siluetas_negro/exterior/png/exterior-lateral-izquierdo.png',
    PhotoAngle.rightSide => 'assets/images/plantillas/siluetas_negro/exterior/png/exterior-lateral-derecho.png',
    PhotoAngle.frontLeftCorner => 'assets/images/plantillas/siluetas_negro/exterior/png/exterior-diagonal-frontal-izquierda.png',
    PhotoAngle.frontRightCorner => 'assets/images/plantillas/siluetas_negro/exterior/png/exterior-diagonal-frontal-derecha.png',
    PhotoAngle.rearLeftCorner => 'assets/images/plantillas/siluetas_negro/exterior/png/exterior-diagonal-trasera-izquierda.png',
    PhotoAngle.rearRightCorner => 'assets/images/plantillas/siluetas_negro/exterior/png/exterior-diagonal-trasera-derecha.png',
  };

  // Camera overlay silhouettes (white, shown on camera preview)
  static String cameraOverlayForAngle(PhotoAngle angle) => switch (angle) {
    PhotoAngle.front => 'assets/images/plantillas/siluetas_blanco/exterior/png/exterior-frontal.png',
    PhotoAngle.rear => 'assets/images/plantillas/siluetas_blanco/exterior/png/exterior-trasera.png',
    PhotoAngle.leftSide => 'assets/images/plantillas/siluetas_blanco/exterior/png/exterior-lateral-izquierdo.png',
    PhotoAngle.rightSide => 'assets/images/plantillas/siluetas_blanco/exterior/png/exterior-lateral-derecho.png',
    PhotoAngle.frontLeftCorner => 'assets/images/plantillas/siluetas_blanco/exterior/png/exterior-diagonal-frontal-izquierda.png',
    PhotoAngle.frontRightCorner => 'assets/images/plantillas/siluetas_blanco/exterior/png/exterior-diagonal-frontal-derecha.png',
    PhotoAngle.rearLeftCorner => 'assets/images/plantillas/siluetas_blanco/exterior/png/exterior-diagonal-trasera-izquierda.png',
    PhotoAngle.rearRightCorner => 'assets/images/plantillas/siluetas_blanco/exterior/png/exterior-diagonal-trasera-derecha.png',
  };

  static String? templateForInteriorPosition(String positionId) => switch (positionId) {
    'front_seats' => 'assets/images/plantillas/siluetas_negro/interior/png/interior-asientos-traseros.png',
    'instrument_panel' => 'assets/images/plantillas/siluetas_negro/interior/png/interior-panel-instrumentos.png',
    'rear_seats' => 'assets/images/plantillas/siluetas_negro/interior/png/interior-asientos-traseros.png',
    'dashboard' => 'assets/images/plantillas/siluetas_negro/interior/png/interior-tablero.png',
    'trunk' => 'assets/images/plantillas/siluetas_negro/interior/png/interior-maletera.png',
    _ => null,
  };

  static String? cameraOverlayForInteriorPosition(String positionId) => switch (positionId) {
    'front_seats' => 'assets/images/plantillas/siluetas_blanco/interior/png/interior-asientos-traseros.png',
    'instrument_panel' => 'assets/images/plantillas/siluetas_blanco/interior/png/interior-panel-instrumentos.png',
    'rear_seats' => 'assets/images/plantillas/siluetas_blanco/interior/png/interior-asientos-traseros.png',
    'dashboard' => 'assets/images/plantillas/siluetas_blanco/interior/png/interior-tablero.png',
    'trunk' => 'assets/images/plantillas/siluetas_blanco/interior/png/interior-maletera.png',
    _ => null,
  };

  // Wheel (rim) silhouettes (card = negro, camera = blanco)
  static String? templateForWheelPosition(String wheelId) =>
    'assets/images/plantillas/siluetas_negro/llantas/svg/rueda-1.svg';

  static String? cameraOverlayForWheelPosition(String wheelId) =>
    'assets/images/plantillas/siluetas_blanco/rueda/svg/rueda-1.svg';

  // Wheel silhouettes
  static const String wheelRimTemplate = 'assets/images/plantillas/siluetas_negro/llantas/png/llantas-aro-delantero.png';
  static const String wheelTireTemplate = 'assets/images/plantillas/siluetas_negro/llantas/png/llantas-neumatico.png';
  static const String wheelRimOverlay = 'assets/images/plantillas/siluetas_blanco/llantas/png/llantas-aro-delantero.png';
  static const String wheelTireOverlay = 'assets/images/plantillas/siluetas_blanco/llantas/png/llantas-neumatico.png';

  static bool templateHasLightBackground(PhotoAngle angle) => false;

  static String overlayInstruction(PhotoAngle angle) => switch (angle) {
    PhotoAngle.front => 'Posiciona el frente del vehículo dentro de la guía',
    PhotoAngle.rear => 'Posiciona la parte trasera dentro de la guía',
    PhotoAngle.leftSide => 'Alinea el perfil izquierdo con la guía',
    PhotoAngle.rightSide => 'Alinea el perfil derecho con la guía',
    PhotoAngle.frontLeftCorner => 'Vista diagonal frontal izquierda',
    PhotoAngle.frontRightCorner => 'Vista diagonal frontal derecha',
    PhotoAngle.rearLeftCorner => 'Vista diagonal trasera izquierda',
    PhotoAngle.rearRightCorner => 'Vista diagonal trasera derecha',
  };

  // Animation Durations
  static const Duration animationFast = Duration(milliseconds: 200);
  static const Duration animationNormal = Duration(milliseconds: 300);
  static const Duration animationSlow = Duration(milliseconds: 500);
}
