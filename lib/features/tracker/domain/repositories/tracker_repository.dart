import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures/failure.dart';
import '../entities/tracker_entity.dart';

abstract class TrackerRepository {
  Future<Either<Failure, Unit>> addTracker(TrackerEntity tracker);
  Future<Either<Failure, List<TrackerEntity>>> getAllTrackers();
}
