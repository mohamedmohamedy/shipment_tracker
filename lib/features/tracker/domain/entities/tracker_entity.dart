import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class TrackerEntity extends Equatable {
  final String shipmentId;
  final String shipmentTarget;
  final String driverName;
  final int driverNumber;
  final Timestamp time;
  final double targetLocationLat;
  final double targetLocationLong;
  final double currentLocationLat;
  final double currentLocationLong;

  const TrackerEntity({
    required this.shipmentId,
    required this.shipmentTarget,
    required this.driverName,
    required this.driverNumber,
    required this.time,
    required this.currentLocationLat,
    required this.currentLocationLong,
    required this.targetLocationLat,
    required this.targetLocationLong,
  });

  @override
  List<Object?> get props => [
        shipmentId,
        shipmentTarget,
        driverName,
        driverNumber,
        time,
        targetLocationLat,
        targetLocationLong,
        currentLocationLat,
        currentLocationLong,
      ];
}
