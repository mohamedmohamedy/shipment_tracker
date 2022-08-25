import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures/failure.dart';
import '../entities/tracker_entity.dart';
import '../repositories/tracker_repository.dart';

class AddTrackerUseCase {
  final TrackerRepository repository;

  AddTrackerUseCase(this.repository);

  Future<Either<Failure, Unit>> call(TrackerEntity tracker) async =>
      repository.addTracker(tracker);
}
