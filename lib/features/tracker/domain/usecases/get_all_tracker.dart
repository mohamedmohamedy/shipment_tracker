import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures/failure.dart';
import '../entities/tracker_entity.dart';
import '../repositories/tracker_repository.dart';

class GetAllTrackerUseCase {
  final TrackerRepository repository;

  GetAllTrackerUseCase(this.repository);

  Future<Either<Failure, List<TrackerEntity>>> call() async =>
      repository.getAllTrackers();
}
