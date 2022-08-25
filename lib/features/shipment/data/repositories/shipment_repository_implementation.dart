import '../../../../core/errors/exceptions/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../datasources/remote_data_source.dart';
import '../../domain/entities/shipment_entity.dart';
import '../../../../core/errors/failures/failure.dart';
import 'package:dartz/dartz.dart';
import '../../domain/repositories/shipment_repository.dart';

class ShipmentRepositoryImplementation implements ShipmentRepository {
  final ShipmentsRemoteDataSource dataSource;
  final NetworkInfo deviceStatus;

  ShipmentRepositoryImplementation(this.dataSource, this.deviceStatus);

  @override
  Future<Either<Failure, List<ShipmentEntity>>> getAllShipments() async {
    if (await deviceStatus.isConnected) {
      try {
        final shipments = await dataSource.getAllShipments();
        return Right(shipments);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
  
  @override
  Future<Either<Failure, ShipmentEntity>> findShipmentById(String shipmentId) async{
    if (await deviceStatus.isConnected){
      try{
        final shipment = await dataSource.findShipmentById(shipmentId);
        return Right(shipment);
      } on ServerException{
        return Left(ServerFailure());
      }
    } else{
      return  Left(OfflineFailure());
    }
  }
}
