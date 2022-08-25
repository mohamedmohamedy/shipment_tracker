import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures/failure.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class SignInAnonymouslyUseCase {
  final AuthRepository authRepository;

  SignInAnonymouslyUseCase({required this.authRepository});

  Future<Either<Failure, UserEntity>> call() async {
    return authRepository.signInAnonymously();
  }
}
