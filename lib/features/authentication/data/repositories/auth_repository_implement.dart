import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/errors/exceptions/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../datasources/remote_auth_data_source.dart';
import '../../domain/entities/user.dart';
import '../../../../core/errors/failures/failure.dart';
import 'package:dartz/dartz.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final RemoteAuthDataSource firebaseAuthAnonymously;
  final NetworkInfo deviceStatus;

  AuthRepositoryImpl(
      {required this.firebaseAuthAnonymously, required this.deviceStatus});

  @override
  Future<Either<Failure, UserEntity>> signInAnonymously() async {
    if (await deviceStatus.isConnected) {
      try {
        final userUid = await firebaseAuthAnonymously.signInAnonymously();
        return Right(userUid);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
