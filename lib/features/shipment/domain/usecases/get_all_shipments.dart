import 'package:dartz/dartz.dart';
import '../repositories/shipment_repository.dart';

import '../../../../core/errors/failures/failure.dart';
import '../entities/shipment_entity.dart';

class GetAllShipmentsUseCase {
  final ShipmentRepository repository;

  GetAllShipmentsUseCase({required this.repository});

  Future<Either<Failure, List<ShipmentEntity>>> call() async {
    return repository.getAllShipments();
  }
}
