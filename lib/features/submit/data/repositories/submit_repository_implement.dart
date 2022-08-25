import '../../../../core/errors/exceptions/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../datasources/submit_form_data_source.dart';
import '../models/submit_form_model.dart';
import '../../domain/entities/submit_form_entity.dart';
import '../../../../core/errors/failures/failure.dart';
import 'package:dartz/dartz.dart';
import '../../domain/repositories/submit_repository.dart';

class SubmitRepositoryImpl implements SubmitFormRepository {
  final SubmitFormDataSource submitFormDataSource;
  final NetworkInfo deviceStatus;

  SubmitRepositoryImpl(
      {required this.submitFormDataSource, required this.deviceStatus});

  @override
  Future<Either<Failure, Unit>> submitForm(SubmitFormEntity form) async {
    final SubmitFormModel formModel = SubmitFormModel(
        name: form.name, phoneNumber: form.phoneNumber, time: form.time);

    if (await deviceStatus.isConnected) {
      try {
        await submitFormDataSource.submitForm(formModel);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
