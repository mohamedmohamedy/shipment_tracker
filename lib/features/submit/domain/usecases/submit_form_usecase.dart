import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures/failure.dart';
import '../entities/submit_form_entity.dart';
import '../repositories/submit_repository.dart';

class SubmitFormUseCase {
  final SubmitFormRepository repository;

  SubmitFormUseCase({required this.repository});

  Future<Either<Failure, Unit>> call(SubmitFormEntity form) async =>
      repository.submitForm(form);
}
