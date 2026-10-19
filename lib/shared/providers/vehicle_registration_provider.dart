import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/models.dart';

class VehicleRegistrationNotifier extends Notifier<VehicleRegistrationState> {
  @override
  VehicleRegistrationState build() {
    return const VehicleRegistrationState();
  }

  // Vehicle Information
  void setVehicle(Vehicle vehicle) {
    state = state.copyWith(vehicle: vehicle);
  }

  void setMileage(double mileage) {
    state = state.copyWith(mileage: mileage);
  }

  void confirmVehicleDetails() {
    state = state.copyWith(vehicleDetailsConfirmed: true);
  }

  // Extra Features
  void toggleExtraFeature(String feature) {
    final features = List<String>.from(state.extraFeatures);
    if (features.contains(feature)) {
      features.remove(feature);
    } else {
      features.add(feature);
    }
    state = state.copyWith(extraFeatures: features);
  }

  void setExtraFeatures(List<String> features) {
    state = state.copyWith(extraFeatures: features);
  }

  void confirmExtraFeatures() {
    state = state.copyWith(extraFeaturesConfirmed: true);
  }

  // Keys
  void setNumberOfKeys(int keys) {
    state = state.copyWith(numberOfKeys: keys);
  }

  void confirmKeys() {
    state = state.copyWith(keysConfirmed: true);
  }

  // Finance
  void setHasFinance(bool hasFinance) {
    state = state.copyWith(hasFinance: hasFinance);
  }

  void confirmFinance() {
    state = state.copyWith(financeConfirmed: true);
  }

  // Running Condition
  void setRunningCondition(RunningCondition condition) {
    state = state.copyWith(runningCondition: condition);
  }

  void confirmRunningCondition() {
    state = state.copyWith(runningConditionConfirmed: true);
  }

  // Mechanical Issues
  void toggleMechanicalIssue(String issue) {
    final issues = List<String>.from(state.mechanicalIssues);
    if (issues.contains(issue)) {
      issues.remove(issue);
    } else {
      issues.add(issue);
    }
    state = state.copyWith(mechanicalIssues: issues);
  }

  void setMechanicalIssues(List<String> issues) {
    state = state.copyWith(mechanicalIssues: issues);
  }

  void confirmMechanicalIssues() {
    state = state.copyWith(mechanicalIssuesConfirmed: true);
  }

  // Photos
  void addExteriorPhoto(String photoPath) {
    final photos = List<String>.from(state.exteriorPhotos);
    photos.add(photoPath);
    state = state.copyWith(exteriorPhotos: photos);
  }

  void addExteriorPhotoWithPath(String positionId, String filePath) {
    final photos = Map<String, String>.from(state.exteriorPhotosMap);
    photos[positionId] = filePath;
    state = state.copyWith(exteriorPhotosMap: photos);
  }

  void removeExteriorPhotoByPosition(String positionId) {
    final photos = Map<String, String>.from(state.exteriorPhotosMap);
    photos.remove(positionId);
    state = state.copyWith(exteriorPhotosMap: photos);
  }

  void removeExteriorPhoto(String photoPath) {
    final photos = List<String>.from(state.exteriorPhotos);
    photos.remove(photoPath);
    state = state.copyWith(exteriorPhotos: photos);
  }

  void setExteriorPhotos(List<String> photos) {
    state = state.copyWith(exteriorPhotos: photos);
  }

  void setExteriorPhotosMap(Map<String, String> photosMap) {
    state = state.copyWith(exteriorPhotosMap: photosMap);
  }

  void confirmPhotos() {
    state = state.copyWith(photosConfirmed: true);
  }

  // Interior Photos
  void addInteriorPhoto(String positionId, String filePath) {
    final photos = Map<String, String>.from(state.interiorPhotosMap);
    photos[positionId] = filePath;
    state = state.copyWith(interiorPhotosMap: photos);
  }

  void removeInteriorPhoto(String positionId) {
    final photos = Map<String, String>.from(state.interiorPhotosMap);
    photos.remove(positionId);
    state = state.copyWith(interiorPhotosMap: photos);
  }

  void confirmInteriorPhotos() {
    state = state.copyWith(interiorPhotosConfirmed: true);
  }

  // Wheels Photos
  void addWheelPhoto(String wheelId, String filePath) {
    final photos = Map<String, String>.from(state.wheelsPhotosMap);
    photos[wheelId] = filePath;
    state = state.copyWith(wheelsPhotosMap: photos);
  }

  void removeWheelPhoto(String wheelId) {
    final photos = Map<String, String>.from(state.wheelsPhotosMap);
    photos.remove(wheelId);
    state = state.copyWith(wheelsPhotosMap: photos);
  }

  void confirmWheelsPhotos() {
    state = state.copyWith(wheelsPhotosConfirmed: true);
  }

  // Tire Condition
  void setTireCondition(String condition) {
    state = state.copyWith(tireCondition: condition);
  }

  void confirmTireCondition() {
    state = state.copyWith(tireConditionConfirmed: true);
  }

  // Seat Material
  void setSeatMaterial(String material) {
    state = state.copyWith(seatMaterial: material);
  }

  void confirmSeatMaterial() {
    state = state.copyWith(seatMaterialConfirmed: true);
  }

  // Paintwork Problems
  void addPaintworkMark(PaintworkMark mark) {
    final marks = List<PaintworkMark>.from(state.paintworkMarks);
    marks.add(mark);
    state = state.copyWith(paintworkMarks: marks);
  }

  void removePaintworkMark(String markId) {
    final marks = state.paintworkMarks.where((m) => m.id != markId).toList();
    state = state.copyWith(paintworkMarks: marks);
  }

  void confirmPaintwork() {
    state = state.copyWith(paintworkConfirmed: true);
  }

  // Broken or Missing Fittings
  void setHasBrokenFittings(bool value) {
    state = state.copyWith(hasBrokenFittings: value);
  }

  void addBrokenFittingPhoto(String path) {
    final photos = List<String>.from(state.brokenFittingsPhotos);
    photos.add(path);
    state = state.copyWith(brokenFittingsPhotos: photos);
  }

  void removeBrokenFittingPhoto(String path) {
    final photos = List<String>.from(state.brokenFittingsPhotos);
    photos.remove(path);
    state = state.copyWith(brokenFittingsPhotos: photos);
  }

  void addBrokenFittingMark(BrokenFittingMark mark) {
    final marks = List<BrokenFittingMark>.from(state.brokenFittingMarks);
    marks.add(mark);
    state = state.copyWith(brokenFittingMarks: marks);
  }

  void removeBrokenFittingMark(String markId) {
    final marks = List<BrokenFittingMark>.from(state.brokenFittingMarks);
    marks.removeWhere((m) => m.id == markId);
    state = state.copyWith(brokenFittingMarks: marks);
  }

  void updateBrokenFittingMarkPhoto(String markId, String photoPath) {
    final marks = state.brokenFittingMarks.map((m) {
      return m.id == markId ? m.copyWith(photoPath: photoPath) : m;
    }).toList();
    state = state.copyWith(brokenFittingMarks: marks);
  }

  void confirmBrokenFittings() {
    state = state.copyWith(brokenFittingsConfirmed: true);
  }

  // Wheel Damage
  void setWheelDamage(String wheelId, bool hasDamage) {
    final map = Map<String, bool>.from(state.wheelDamageMap);
    map[wheelId] = hasDamage;
    state = state.copyWith(wheelDamageMap: map);
  }

  void confirmWheelDamage() {
    state = state.copyWith(wheelDamageConfirmed: true);
  }

  // Tool Pack
  void setHasToolPack(bool value) {
    state = state.copyWith(hasToolPack: value);
  }

  void confirmToolPack() {
    state = state.copyWith(toolPackConfirmed: true);
  }

  // Locking Wheel Nut
  void setHasLockingWheelNut(bool value) {
    state = state.copyWith(hasLockingWheelNut: value);
  }

  void confirmLockingWheelNut() {
    state = state.copyWith(lockingWheelNutConfirmed: true);
  }

  // Condition & Damage
  void addDamage(DamageItem damage) {
    final damages = List<DamageItem>.from(state.damages);
    damages.add(damage);
    state = state.copyWith(damages: damages);
  }

  void removeDamage(String damageId) {
    final damages = state.damages.where((d) => d.id != damageId).toList();
    state = state.copyWith(damages: damages);
  }

  void confirmConditionDamage() {
    state = state.copyWith(conditionDamageConfirmed: true);
  }

  // Service History
  void setServiceHistoryType(ServiceHistoryType type) {
    state = state.copyWith(serviceHistoryType: type);
  }

  void addServiceDocument(String documentPath) {
    final documents = List<String>.from(state.serviceDocuments);
    documents.add(documentPath);
    state = state.copyWith(serviceDocuments: documents);
  }

  void removeServiceDocument(String documentPath) {
    final documents = List<String>.from(state.serviceDocuments);
    documents.remove(documentPath);
    state = state.copyWith(serviceDocuments: documents);
  }

  void confirmServiceHistory() {
    state = state.copyWith(serviceHistoryConfirmed: true);
  }

  // Proof of Purchase
  void setHasProofOfPurchase(bool value) {
    state = state.copyWith(hasProofOfPurchase: value);
  }

  void confirmProofOfPurchase() {
    state = state.copyWith(proofOfPurchaseConfirmed: true);
  }

  // Smoking
  void setHasBeenSmokedIn(bool value) {
    state = state.copyWith(hasBeenSmokedIn: value);
  }

  void confirmSmoking() {
    state = state.copyWith(smokingConfirmed: true);
  }

  // Private Plate
  void setHasPrivatePlate(bool value) {
    state = state.copyWith(hasPrivatePlate: value);
  }

  void confirmPrivatePlate() {
    state = state.copyWith(privatePlateConfirmed: true);
  }

  // Submission
  void setSubmissionStatus(SubmissionStatus status) {
    state = state.copyWith(submissionStatus: status);
  }

  void submitForReview() {
    state = state.copyWith(submissionStatus: SubmissionStatus.submitted);
  }

  // Progress Calculation
  double calculateProgress() {
    int completedSteps = 0;
    const int totalSteps = 21;

    if (state.vehicleDetailsConfirmed) completedSteps++;
    if (state.extraFeaturesConfirmed) completedSteps++;
    if (state.keysConfirmed) completedSteps++;
    if (state.financeConfirmed) completedSteps++;
    if (state.runningConditionConfirmed) completedSteps++;
    if (state.mechanicalIssuesConfirmed) completedSteps++;
    if (state.proofOfPurchaseConfirmed) completedSteps++;
    if (state.smokingConfirmed) completedSteps++;
    if (state.privatePlateConfirmed) completedSteps++;
    if (state.seatMaterialConfirmed) completedSteps++;
    if (state.toolPackConfirmed) completedSteps++;
    if (state.lockingWheelNutConfirmed) completedSteps++;
    if (state.photosConfirmed) completedSteps++;
    if (state.interiorPhotosConfirmed) completedSteps++;
    if (state.wheelsPhotosConfirmed) completedSteps++;
    if (state.tireConditionConfirmed) completedSteps++;
    if (state.conditionDamageConfirmed) completedSteps++;
    if (state.paintworkConfirmed) completedSteps++;
    if (state.brokenFittingsConfirmed) completedSteps++;
    if (state.wheelDamageConfirmed) completedSteps++;
    if (state.serviceHistoryConfirmed) completedSteps++;

    return completedSteps / totalSteps;
  }

  int calculateProgressPercentage() {
    return (calculateProgress() * 100).round();
  }

  // Reset
  void reset() {
    state = const VehicleRegistrationState();
  }
}

final vehicleRegistrationProvider =
    NotifierProvider<VehicleRegistrationNotifier, VehicleRegistrationState>(
  VehicleRegistrationNotifier.new,
);

// Convenience providers
final vehicleProvider = Provider<Vehicle?>((ref) {
  return ref.watch(vehicleRegistrationProvider).vehicle;
});

final progressProvider = Provider<double>((ref) {
  final notifier = ref.read(vehicleRegistrationProvider.notifier);
  ref.watch(vehicleRegistrationProvider);
  return notifier.calculateProgress();
});

final progressPercentageProvider = Provider<int>((ref) {
  final notifier = ref.read(vehicleRegistrationProvider.notifier);
  ref.watch(vehicleRegistrationProvider);
  return notifier.calculateProgressPercentage();
});

final dashboardProgressProvider = Provider<int>((ref) {
  final state = ref.watch(vehicleRegistrationProvider);
  int completed = 0;
  const total = 4;

  final infoCompleted = state.vehicleDetailsConfirmed &&
      state.extraFeaturesConfirmed &&
      state.keysConfirmed &&
      state.financeConfirmed &&
      state.runningConditionConfirmed &&
      state.mechanicalIssuesConfirmed &&
      state.proofOfPurchaseConfirmed &&
      state.smokingConfirmed &&
      state.privatePlateConfirmed &&
      state.seatMaterialConfirmed &&
      state.toolPackConfirmed &&
      state.lockingWheelNutConfirmed;
  if (infoCompleted) completed++;

  if (state.photosConfirmed && state.interiorPhotosConfirmed && state.wheelsPhotosConfirmed && state.tireConditionConfirmed) completed++;
  if (state.conditionDamageConfirmed && state.paintworkConfirmed && state.brokenFittingsConfirmed && state.wheelDamageConfirmed) completed++;
  if (state.serviceHistoryConfirmed) completed++;

  return ((completed / total) * 100).round();
});
