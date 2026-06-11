class AppConstants {
  AppConstants._();

  // App Info
  static const String appName = 'Carlo Vehicle App';
  static const String appVersion = '1.0.0';

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
