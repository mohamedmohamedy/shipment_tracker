import '../../../../core/errors/exceptions/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../datasources/remote_data_source.dart';
import '../models/tracker_model.dart';
import '../../domain/entities/tracker_entity.dart';
import '../../../../core/errors/failures/failure.dart';
import 'package:dartz/dartz.dart';
import '../../domain/repositories/tracker_repository.dart';

class TrackerRepositoryImplementation implements TrackerRepository {
  final RemoteDataSource dataSource;
  final NetworkInfo deviceStatus;

  TrackerRepositoryImplementation(this.dataSource, this.deviceStatus);

  @override
  Future<Either<Failure, List<TrackerEntity>>> getAllTrackers() async {
    if (await deviceStatus.isConnected) {
      try {
        final trackers = await dataSource.getAllTrackers();
        return Right(trackers);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> addTracker(TrackerEntity tracker) async {
    final TrackerModel newTracker = TrackerModel(
      shipmentId: tracker.shipmentId,
      shipmentTarget: tracker.shipmentTarget,
      driverName: tracker.driverName,
      driverNumber: tracker.driverNumber,
      time: tracker.time,
      currentLocationLat: tracker.currentLocationLat,
      currentLocationLong: tracker.currentLocationLong,
      targetLocationLat: tracker.targetLocationLat,
      targetLocationLong: tracker.targetLocationLong
    );
    if (await deviceStatus.isConnected) {
      try {
        await dataSource.addTracker(newTracker);

        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
