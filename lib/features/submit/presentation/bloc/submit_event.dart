part of 'submit_bloc.dart';

abstract class SubmitEvent extends Equatable {
  const SubmitEvent();

  @override
  List<Object> get props => [];
}

class SubmitFormEvent extends SubmitEvent {
  final SubmitFormEntity form;

  const SubmitFormEvent({required this.form});

  @override
  List<Object> get props => [form];
}
