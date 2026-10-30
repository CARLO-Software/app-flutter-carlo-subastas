import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/vehicle.dart';

enum AuctionStatus { draft, submitted, inReview, live, sold }

class RegisteredVehicle {
  final Vehicle vehicle;
  final double progress;
  final AuctionStatus status;
  final DateTime createdAt;

  const RegisteredVehicle({
    required this.vehicle,
    required this.progress,
    this.status = AuctionStatus.draft,
    required this.createdAt,
  });

  String get statusLabel => switch (status) {
        AuctionStatus.draft => 'Borrador',
        AuctionStatus.submitted => 'Enviado',
        AuctionStatus.inReview => 'En revisión',
        AuctionStatus.live => 'En subasta',
        AuctionStatus.sold => 'Vendido',
      };
}

final registeredVehiclesProvider =
    NotifierProvider<RegisteredVehiclesNotifier, List<RegisteredVehicle>>(
  RegisteredVehiclesNotifier.new,
);

class RegisteredVehiclesNotifier extends Notifier<List<RegisteredVehicle>> {
  @override
  List<RegisteredVehicle> build() => [];

  void add(RegisteredVehicle vehicle) {
    state = [...state, vehicle];
  }

  void remove(int index) {
    state = [...state]..removeAt(index);
  }
}
