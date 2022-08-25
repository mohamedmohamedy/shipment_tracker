part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLoadingState extends AuthenticationState {}

class SuccessionAuthenticatingState extends AuthenticationState {
  final UserEntity user;
  const SuccessionAuthenticatingState({required this.user});

  @override
  List<Object> get props => [user];
}

class AuthenticationFailingState extends AuthenticationState {
  final String errorMessage;

  const AuthenticationFailingState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
