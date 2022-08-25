import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/rendering.dart';
import '../../../../core/errors/exceptions/exceptions.dart';

import '../models/tracker_model.dart';

abstract class RemoteDataSource {
  Future<List<TrackerModel>> getAllTrackers();
  Future<Unit> addTracker(TrackerModel tracker);
}

class FireBaseRemoteDataSourceImplementation implements RemoteDataSource {
  final db = FirebaseFirestore.instance;

  @override
  Future<List<TrackerModel>> getAllTrackers() async {
    try {
      List<TrackerModel> trackers = [];

      final ref = db.collection('trackers').snapshots().map((event) =>
          event.docs.map((e) => TrackerModel.fromFirestore(e)).toList());

      ref.listen((event) {
        trackers = event;
        log(name: 'listen event', event.toString());
      });

      trackers = await ref.first;
      log(name: 'return list ', trackers.toString());

      return trackers;
    } on FirebaseException catch (error) {
      log('error with get trackers from fireStore: ${error.code} ${error.message}');
      throw ServerException();
    }
  }

  @override
  Future<Unit> addTracker(TrackerModel tracker) async {
    try {
      await db
          .collection('trackers')
          .doc(tracker.shipmentId)
          .set(tracker.toFireStore());

      return Future.value(unit);
    } on FirebaseException catch (error) {
      log('Error with adding new tracker: ${error.code} ${error.message}');
      throw ServerException();
    }
  }
}
