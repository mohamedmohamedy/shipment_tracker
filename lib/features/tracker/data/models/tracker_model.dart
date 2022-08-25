import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/tracker_entity.dart';

class TrackerModel extends TrackerEntity {
  const TrackerModel({
    required super.shipmentId,
    required super.shipmentTarget,
    required super.driverName,
    required super.driverNumber,
    required super.time,
    required super.currentLocationLat,
    required super.currentLocationLong,
    required super.targetLocationLat, 
    required super.targetLocationLong, 
  });

  factory TrackerModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    return TrackerModel(
      shipmentId: data?['shipmentId'],
      shipmentTarget: data?['shipmentTarget'],
      driverName: data?['driverName'],
      driverNumber: data?['driverNumber'],
      time: data?['time'],
      currentLocationLat: data?['currentLocationLat'],
      currentLocationLong: data?['currentLocationLong'],
      targetLocationLat: data?['targetLocationLat'],
      targetLocationLong: data?['targetLocationLong'],
    
    );
  }

  Map<String, dynamic> toFireStore() {
    return {
      'shipmentId': shipmentId,
      'shipmentTarget': shipmentTarget,
      'driverName': driverName,
      'driverNumber': driverNumber,
      'time': time,
      'currentLocationLat': currentLocationLat,
      'currentLocationLong': currentLocationLong,
      'targetLocationLat': targetLocationLat,
      'targetLocationLong': targetLocationLong,
    };
  }
}
