enum PhotoAngle {
  front,
  rear,
  leftSide,
  rightSide,
  frontLeftCorner,
  frontRightCorner,
  rearLeftCorner,
  rearRightCorner,
}

class PhotoPositionData {
  final String id;
  final String name;
  final PhotoAngle angle;
  final String instructions;
  final int order;

  const PhotoPositionData({
    required this.id,
    required this.name,
    required this.angle,
    required this.instructions,
    required this.order,
  });
}
