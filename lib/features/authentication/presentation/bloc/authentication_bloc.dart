import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures/failure.dart';
import '../../domain/entities/user.dart';

import '../../../../core/strings/strings_class.dart';
import '../../domain/usecases/sign_in_anonymously.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final SignInAnonymouslyUseCase signInAnonymouslyUseCase;

  AuthenticationBloc({required this.signInAnonymouslyUseCase})
      : super(AuthenticationInitial()) {
    on<AuthenticationEvent>((event, emit) async {
      if (event is SignInAnonymouslyEvent) {
        emit(AuthenticationLoadingState());
        final user = await signInAnonymouslyUseCase();
        user.fold(
          (failure) => emit(AuthenticationFailingState(errorMessage: _getErrorMessage(failure))),
          (user) => emit(SuccessionAuthenticatingState(user: user)),
        );
      }
    });
  }
   String _getErrorMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return ErrorsMessages.serverFailure;
      case OfflineFailure:
        return ErrorsMessages.offlineFailure;
      default:
        return ErrorsMessages.unknownFailure;
    }
  }
}
