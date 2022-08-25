part of 'shipment_bloc.dart';

abstract class ShipmentState extends Equatable {
  const ShipmentState();

  @override
  List<Object> get props => [];
}

class ShipmentInitial extends ShipmentState {}

class ShipmentLoadingState extends ShipmentState {}

class SuccessfullyShipmentState extends ShipmentState {
  final List<ShipmentEntity> shipments;

  const SuccessfullyShipmentState({required this.shipments});

  @override
  List<Object> get props => [shipments];
}

class FailingShipmentState extends ShipmentState {
  final String failMessage;

  const FailingShipmentState({required this.failMessage});

  @override
  List<Object> get props => [failMessage];
}

class SuccessFindShipmentByIdState extends ShipmentState {
  final ShipmentEntity shipment;

  const SuccessFindShipmentByIdState({required this.shipment});
}

class SuccessToGetCurrentShipmentLocationState extends ShipmentState {
  final LocationData currentLocation;

  const SuccessToGetCurrentShipmentLocationState({required this.currentLocation});

  @override
  List<Object> get props => [currentLocation];
}

class FailingToGetCurrentShipmentLocationState extends ShipmentState {
  final String failMessage;

  const FailingToGetCurrentShipmentLocationState({required this.failMessage});
}