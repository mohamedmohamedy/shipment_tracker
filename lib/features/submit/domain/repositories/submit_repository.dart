import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures/failure.dart';

import '../entities/submit_form_entity.dart';

abstract class SubmitFormRepository {
  Future<Either<Failure, Unit>> submitForm(SubmitFormEntity form);
}
