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

  void setMileage(int mileage) {
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

  void removeExteriorPhoto(String photoPath) {
    final photos = List<String>.from(state.exteriorPhotos);
    photos.remove(photoPath);
    state = state.copyWith(exteriorPhotos: photos);
  }

  void setExteriorPhotos(List<String> photos) {
    state = state.copyWith(exteriorPhotos: photos);
  }

  void confirmPhotos() {
    state = state.copyWith(photosConfirmed: true);
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

  void confirmServiceHistory() {
    state = state.copyWith(serviceHistoryConfirmed: true);
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
    const int totalSteps = 9;

    if (state.vehicleDetailsConfirmed) completedSteps++;
    if (state.extraFeaturesConfirmed) completedSteps++;
    if (state.keysConfirmed) completedSteps++;
    if (state.financeConfirmed) completedSteps++;
    if (state.runningConditionConfirmed) completedSteps++;
    if (state.mechanicalIssuesConfirmed) completedSteps++;
    if (state.photosConfirmed) completedSteps++;
    if (state.conditionDamageConfirmed) completedSteps++;
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
