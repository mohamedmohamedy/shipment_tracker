part of 'shipment_bloc.dart';

abstract class ShipmentEvent extends Equatable {
  const ShipmentEvent();

  @override
  List<Object> get props => [];
}

class GetAllShipmentsEvent extends ShipmentEvent {}

class FindShipmentById extends ShipmentEvent {
  final String shipmentId;

  const FindShipmentById({required this.shipmentId});
   @override
  List<Object> get props => [shipmentId];
}

class GetCurrentShipmentLocationEvent extends ShipmentEvent{}