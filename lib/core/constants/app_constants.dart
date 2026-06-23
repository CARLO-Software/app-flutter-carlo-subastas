import '../../models/photo_position.dart';

class AppConstants {
  AppConstants._();

  // App Info
  static const String appName = 'Carlo Vehicle App';
  static const String appVersion = '1.0.0';

  // AI Configuration — passed via --dart-define-from-file=.env
  static const String geminiApiKey = String.fromEnvironment('GEMINI_API_KEY');

  // Photo Position Definitions
  static const List<PhotoPositionData> photoPositions = [
    PhotoPositionData(
      id: 'front',
      name: 'Front',
      angle: PhotoAngle.front,
      instructions: 'Stand directly in front of the vehicle, about 3 meters away. Center the car in frame.',
      order: 1,
    ),
    PhotoPositionData(
      id: 'rear',
      name: 'Rear',
      angle: PhotoAngle.rear,
      instructions: 'Stand directly behind the vehicle, about 3 meters away. Capture the full rear view.',
      order: 2,
    ),
    PhotoPositionData(
      id: 'left_side',
      name: 'Left Side',
      angle: PhotoAngle.leftSide,
      instructions: 'Stand to the left side of the vehicle. Capture the entire side profile.',
      order: 3,
    ),
    PhotoPositionData(
      id: 'right_side',
      name: 'Right Side',
      angle: PhotoAngle.rightSide,
      instructions: 'Stand to the right side of the vehicle. Capture the entire side profile.',
      order: 4,
    ),
    PhotoPositionData(
      id: 'front_left_corner',
      name: 'Front Left Corner',
      angle: PhotoAngle.frontLeftCorner,
      instructions: 'Position yourself at a 45-degree angle from the front left. Show front and left side.',
      order: 5,
    ),
    PhotoPositionData(
      id: 'front_right_corner',
      name: 'Front Right Corner',
      angle: PhotoAngle.frontRightCorner,
      instructions: 'Position yourself at a 45-degree angle from the front right. Show front and right side.',
      order: 6,
    ),
    PhotoPositionData(
      id: 'rear_left_corner',
      name: 'Rear Left Corner',
      angle: PhotoAngle.rearLeftCorner,
      instructions: 'Position yourself at a 45-degree angle from the rear left. Show rear and left side.',
      order: 7,
    ),
    PhotoPositionData(
      id: 'rear_right_corner',
      name: 'Rear Right Corner',
      angle: PhotoAngle.rearRightCorner,
      instructions: 'Position yourself at a 45-degree angle from the rear right. Show rear and right side.',
      order: 8,
    ),
  ];

  // Extra Features Options
  static const List<String> extraFeatureOptions = [
    'Sat Nav',
    'Bluetooth',
    'Apple CarPlay',
    'Android Auto',
    'Sunroof',
    'Keyless Entry',
    'Heated Seats',
    'Roof Rails',
    'Reverse Camera',
    'Leather Seats',
    'Bike Rack',
    'Blind Spot Alerts',
    'Towbar',
  ];

  // Mechanical Issue Options
  static const List<String> mechanicalIssueOptions = [
    'Central Locking',
    'Headlights',
    'Electric Windows',
    'Oil Leak',
    'Strange Sound',
    'Rear Lights',
    'Parking Sensors',
    'Brake Pads',
    'Infotainment',
    'Air Conditioning',
    'Something Else',
  ];

  // Damage Types
  static const List<String> damageTypes = [
    'Scratch',
    'Dent',
    'Paint Damage',
  ];

  // Photo Types
  static const List<String> exteriorPhotoTypes = [
    'Front',
    'Rear',
    'Left Side',
    'Right Side',
    'Front Left Corner',
    'Front Right Corner',
    'Rear Left Corner',
    'Rear Right Corner',
  ];

  // Animation Durations
  static const Duration animationFast = Duration(milliseconds: 200);
  static const Duration animationNormal = Duration(milliseconds: 300);
  static const Duration animationSlow = Duration(milliseconds: 500);
}
