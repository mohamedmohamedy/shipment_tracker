import 'package:dartz/dartz.dart';
import '../repositories/shipment_repository.dart';

import '../../../../core/errors/failures/failure.dart';
import '../entities/shipment_entity.dart';

class FindShipmentByIdUseCase {
  final ShipmentRepository repository;

  FindShipmentByIdUseCase(this.repository);

  Future<Either<Failure, ShipmentEntity>> call(String shipmentId) async =>
      repository.findShipmentById(shipmentId);
}
