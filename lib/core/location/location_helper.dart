import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:location/location.dart';

import '../errors/failures/failure.dart';

class LocationHelper {
  final _location = Location();
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;

  Future<Either<Failure, LocationData>> checkLocationServiceEnabled() async {
    _serviceEnabled = await _location.serviceEnabled();

    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();

      if (_serviceEnabled) {
        log('User allowed service');
      } else {
        log('User  refused service');
        return Left(LocationFailure());
      }
    }

    _permissionGranted = await _location.hasPermission();

    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted == PermissionStatus.granted) {
        log('User  granted permission');
      } else if (_permissionGranted != PermissionStatus.granted) {
        log('User  denied permission');
        return Left(LocationFailure());
      }
    }
    final _locationData = await _location.getLocation();
    log(_locationData.toString(), name: 'current location helper');

    return Right(_locationData);
  }
}
