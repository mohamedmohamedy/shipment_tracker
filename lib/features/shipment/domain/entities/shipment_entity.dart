import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ShipmentEntity extends Equatable {
  final String shipmentId;
  final String name;
  final GeoPoint targetLocation;

  const ShipmentEntity({
    required this.name,
    required this.shipmentId,
    required this.targetLocation,
  });

  @override
  List<Object?> get props => [shipmentId, name, targetLocation];
}
