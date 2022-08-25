import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:location/location.dart';
import '../../../../core/location/location_helper.dart';
import '../../../shipment/presentation/bloc/shipment_bloc.dart';
import '../../domain/entities/tracker_entity.dart';
import '../../domain/usecases/add_tracker.dart';
import '../../domain/usecases/get_all_tracker.dart';

import '../../../../core/errors/failures/failure.dart';
import '../../../../core/strings/strings_class.dart';

part 'tracker_event.dart';
part 'tracker_state.dart';

class TrackerBloc extends Bloc<TrackerEvent, TrackerState> {
  final AddTrackerUseCase addTracker;
  final GetAllTrackerUseCase getAllTracker;
  final LocationHelper locationHelper;

  TrackerBloc(this.addTracker, this.getAllTracker, this.locationHelper)
      : super(TrackerInitial()) {
    on<TrackerEvent>((event, emit) async {
      if (event is GetCurrentLocationEvent) {
        emit(LoadingTrackersState());

        final response = await locationHelper.checkLocationServiceEnabled();
        response.fold(
          (failure) => emit(const FailingToGetCurrentLocationState(
              failMessage: ErrorsMessages.locationFailure)),
          (currentLocation) => emit(SuccessToGetCurrentLocationState(
              currentLocation: currentLocation)),
        );
      }

      if (event is GetAllTrackersEvent) {
        emit(LoadingTrackersState());

        final response = await getAllTracker();

        response.fold(
          (failure) =>
              emit(FailingLoadingState(failMessage: _getErrorMessage(failure))),
          (trackers) => emit(SuccessLoadingState(trackers: trackers)),
        );
      }

      if (event is AddNewTrackerEvent) {
        emit(LoadingTrackersState());
        emit(AddingNewTrackerWaitingState());

        final response = await addTracker(event.tracker);

        response.fold(
          (failure) =>
              emit(FailingLoadingState(failMessage: _getErrorMessage(failure))),
          (_) => emit(AddingNewTrackerSuccessState()),
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
