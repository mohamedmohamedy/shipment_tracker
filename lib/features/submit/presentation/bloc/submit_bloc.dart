import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/submit_form_entity.dart';
import '../../domain/usecases/submit_form_usecase.dart';

import '../../../../core/errors/failures/failure.dart';
import '../../../../core/strings/strings_class.dart';

part 'submit_event.dart';
part 'submit_state.dart';

class SubmitBloc extends Bloc<SubmitEvent, SubmitState> {
  final SubmitFormUseCase submitFormUseCase;

  SubmitBloc({required this.submitFormUseCase}) : super(SubmitInitial()) {
    on<SubmitEvent>((event, emit) async {
      if (event is SubmitFormEvent) {
        emit(SubmitFormLoadingState());

        final response = await submitFormUseCase(event.form);

        response.fold(
          (failure) => emit(SubmitFormFailingState(errorMessage: _getErrorMessage(failure))),
          (success) => emit(SubmitFormSuccessionState()),
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
