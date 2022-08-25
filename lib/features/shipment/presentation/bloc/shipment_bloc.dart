import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:location/location.dart';
import '../../../../core/location/location_helper.dart';
import '../../domain/entities/shipment_entity.dart';
import '../../domain/usecases/find_shipment_by_id.dart';
import '../../domain/usecases/get_all_shipments.dart';

import '../../../../core/errors/failures/failure.dart';
import '../../../../core/strings/strings_class.dart';

part 'shipment_event.dart';
part 'shipment_state.dart';

class ShipmentBloc extends Bloc<ShipmentEvent, ShipmentState> {
  final GetAllShipmentsUseCase getAllShipments;
  final FindShipmentByIdUseCase findShipmentById;
   final LocationHelper locationHelper;
 

  ShipmentBloc(this.getAllShipments, this.findShipmentById, this.locationHelper)
      : super(ShipmentInitial()) { 
    on<ShipmentEvent>((event, emit) async {
      
      if (event is GetAllShipmentsEvent) {
        emit(ShipmentLoadingState());

        final response = await getAllShipments();

        response.fold(
          (failure) => emit(
              FailingShipmentState(failMessage: _getErrorMessage(failure))),
          (shipments) => emit(SuccessfullyShipmentState(shipments: shipments)),
        );
      }

      if (event is FindShipmentById) {
        emit(ShipmentLoadingState());

        final response = await findShipmentById(event.shipmentId);

        response.fold(
          (failure) => emit(
              FailingShipmentState(failMessage: _getErrorMessage(failure))),
          (shipment) => emit(SuccessFindShipmentByIdState(shipment: shipment)),
        );
      }

      
if (event is GetCurrentShipmentLocationEvent) {
        emit(ShipmentLoadingState());

        final response = await locationHelper.checkLocationServiceEnabled();
        response.fold(
          (failure) => emit(const FailingToGetCurrentShipmentLocationState(
              failMessage: ErrorsMessages.locationFailure)),
          (currentLocation) => emit(SuccessToGetCurrentShipmentLocationState(
              currentLocation: currentLocation)),
        );
      }

    });
  }

  String _getErrorMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return ErrorsMessages.serverFailure;
      case OfflineFailure:
        return ErrorsMessages.offlineFailure;
      default:
        return ErrorsMessages.unknownFailure;
    }
  }
}
