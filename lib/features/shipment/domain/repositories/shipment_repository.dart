import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures/failure.dart';
import '../entities/shipment_entity.dart';

abstract class ShipmentRepository {
  Future<Either<Failure, List<ShipmentEntity>>> getAllShipments();
  Future<Either<Failure, ShipmentEntity>> findShipmentById(String shipmentId);
}
