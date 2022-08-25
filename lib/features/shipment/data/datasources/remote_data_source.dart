import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../../core/errors/exceptions/exceptions.dart';
import '../models/shipment_model.dart';

abstract class ShipmentsRemoteDataSource {
  Future<List<ShipmentModel>> getAllShipments();
  Future<ShipmentModel> findShipmentById(String shipmentId);
}

class ShipmentsFireBaseDataSource implements ShipmentsRemoteDataSource {
  final db = FirebaseFirestore.instance;

  @override
  Future<List<ShipmentModel>> getAllShipments() async {
    try {
      List<ShipmentModel> shipmentList = [];

      final ref = db.collection('shipments').snapshots().map((event) =>
          event.docs.map((e) => ShipmentModel.fromFirestore(e)).toList());

      ref.listen((event) {
        shipmentList = event;
      });

      shipmentList = await ref.first;

      return shipmentList;
    } on FirebaseException catch (_) {
      throw ServerException();
    }
  }

  @override
  Future<ShipmentModel> findShipmentById(String shipmentId) async {
    try {
      final shipmentsSnapShot = await db
          .collection("shipments")
          .where("shipmentId", isEqualTo: shipmentId)
          .get();
      final shipment = shipmentsSnapShot.docs
          .map((e) => ShipmentModel.fromFirestore(e))
          .first;
      debugPrint(shipment.toString());

      return shipment;
    } on FirebaseException catch (_) {
      throw ServerException();
    }
  }
}
