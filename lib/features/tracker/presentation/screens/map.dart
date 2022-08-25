import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import '../../../../core/constants/constants.dart';
import '../../domain/entities/tracker_entity.dart';

import '../../../../core/strings/strings_class.dart';

class MapScreen extends StatefulWidget {
  static const String routeName = AllTrackersStrings.mapRouteName;
  final TrackerEntity tracker;

  const MapScreen({Key? key, required this.tracker}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  List<LatLng> pollyLineCoordinates = [];

  //_____________________________Poly Points___________________________
  void getPolyLinesPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      GOOGLE_API_KEY,
      PointLatLng(widget.tracker.currentLocationLat,
          widget.tracker.currentLocationLong),
      PointLatLng(
          widget.tracker.targetLocationLat, widget.tracker.targetLocationLong),
    );

    if (result.points.isNotEmpty) {
      result.points.forEach(
        (PointLatLng point) => pollyLineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        ),
      );
      setState(() {});
    }
  }

  //_________________________live location_____________________________________________
  void getCurrentLocation() async {
    Location location = Location();
   await  location.getLocation();
    GoogleMapController googleMapController = await _controller.future;
    location.onLocationChanged.listen(
      (newLoc) async {

      await FirebaseFirestore.instance
            .collection('trackers')
            .doc(widget.tracker.shipmentId)
            .update({
          'currentLocationLat': newLoc.latitude,
          'currentLocationLong': newLoc.longitude,
        });

//________________________________Tracking the live location__________________

        googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              zoom: 13.5,
              target: LatLng(
                newLoc.latitude!,
                newLoc.longitude!,
              ),
            ),
          ),
        );
        setState(() {});
      },
    );
  }

  //______________________________________________________________________________
  @override
  void initState() {
    getPolyLinesPoints();
    getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    LatLng sourceLocation = LatLng(
        widget.tracker.currentLocationLat, widget.tracker.currentLocationLong);

    LatLng destination = LatLng(
        widget.tracker.targetLocationLat, widget.tracker.targetLocationLong);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.tracker.shipmentTarget),
      ),
      body: 
    
           GoogleMap(
              initialCameraPosition: CameraPosition(
                target: sourceLocation,
                zoom: 13.5,
              ),
              onMapCreated: (mapController) =>
                  _controller.complete(mapController),
              markers: {
                Marker(
                    markerId: const MarkerId('current location'),
                    position: sourceLocation),
                Marker(
                    markerId: const MarkerId('target location'),
                    position: destination)
              },
              polylines: {
                Polyline(
                  polylineId: const PolylineId('route'),
                  points: pollyLineCoordinates,
                  color: const Color(0xFF7B61FF),
                  width: 6,
                ),
              },
            ),
    );
  }
}
