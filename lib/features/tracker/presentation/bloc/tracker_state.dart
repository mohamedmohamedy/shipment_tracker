part of 'tracker_bloc.dart';

abstract class TrackerState extends Equatable {
  const TrackerState();

  @override
  List<Object> get props => [];
}

class TrackerInitial extends TrackerState {}

class LoadingTrackersState extends TrackerState {}

class SuccessLoadingState extends TrackerState {
  final List<TrackerEntity> trackers;

  const SuccessLoadingState({required this.trackers});

  @override
  List<Object> get props => [trackers];
}

class FailingLoadingState extends TrackerState {
  final String failMessage;

  const FailingLoadingState({required this.failMessage});

  @override
  List<Object> get props => [failMessage];
}

class AddingNewTrackerSuccessState extends TrackerState {}

class SuccessToGetCurrentLocationState extends TrackerState {
  final LocationData currentLocation;

  const SuccessToGetCurrentLocationState({required this.currentLocation});

  @override
  List<Object> get props => [currentLocation];
}

class FailingToGetCurrentLocationState extends TrackerState {
  final String failMessage;

  const FailingToGetCurrentLocationState({required this.failMessage});
}

class AddingNewTrackerWaitingState extends TrackerState{}
