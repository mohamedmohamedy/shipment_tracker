part of 'submit_bloc.dart';

abstract class SubmitState extends Equatable {
  const SubmitState();

  @override
  List<Object> get props => [];
}

class SubmitInitial extends SubmitState {}

class SubmitFormLoadingState extends SubmitState {}

class SubmitFormSuccessionState extends SubmitState {}

class SubmitFormFailingState extends SubmitState {
  final String errorMessage;
  const SubmitFormFailingState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
