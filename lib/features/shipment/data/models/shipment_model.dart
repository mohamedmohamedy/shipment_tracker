import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/shipment_entity.dart';

class ShipmentModel extends ShipmentEntity {
  const ShipmentModel({
    required super.shipmentId,
    required super.name,
    required super.targetLocation,
  });

  factory ShipmentModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    return ShipmentModel(
      shipmentId: data?['shipmentId'],
      name: data?['name'],
      targetLocation: data?['targetLocation'],
    );
  }

  Map<String, dynamic> toFirestore() => {
        "shipmentId": shipmentId,
        "name": name,
        "targetLocation": targetLocation,
      };
}
