import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/api_client.dart';

enum AuctionStatus { draft, submitted, inReview, live, sold }

class RegisteredVehicle {
  final String id;
  final String identifier;
  final String vehicleLabel;
  final String plate;
  final AuctionStatus status;
  final DateTime createdAt;

  const RegisteredVehicle({
    required this.id,
    required this.identifier,
    required this.vehicleLabel,
    required this.plate,
    required this.status,
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

AuctionStatus _parseStatus(String? raw) => switch (raw) {
      'submitted' => AuctionStatus.submitted,
      'in_review' => AuctionStatus.inReview,
      'live' || 'published' => AuctionStatus.live,
      'sold' || 'approved' => AuctionStatus.sold,
      _ => AuctionStatus.draft,
    };

final registeredVehiclesProvider = AsyncNotifierProvider<
    RegisteredVehiclesNotifier, List<RegisteredVehicle>>(
  RegisteredVehiclesNotifier.new,
);

class RegisteredVehiclesNotifier
    extends AsyncNotifier<List<RegisteredVehicle>> {
  @override
  Future<List<RegisteredVehicle>> build() => _fetch();

  Future<List<RegisteredVehicle>> _fetch() async {
    final api = ref.read(apiClientProvider);
    try {
      final data = await api.fetchRegistrations();
      return data.map((r) => RegisteredVehicle(
            id: r['id'] as String,
            identifier: r['identifier'] as String? ?? '',
            vehicleLabel: r['vehicle'] as String? ?? '',
            plate: r['plate'] as String? ?? '',
            status: _parseStatus(r['status'] as String?),
            createdAt: DateTime.parse(r['created_at'] as String),
          )).toList();
    } catch (e) {
      debugPrint('Error fetching registrations: $e');
      return [];
    }
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = AsyncData(await _fetch());
  }
}
