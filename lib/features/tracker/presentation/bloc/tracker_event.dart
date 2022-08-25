part of 'tracker_bloc.dart';

abstract class TrackerEvent extends Equatable {
  const TrackerEvent();

  @override
  List<Object> get props => [];
}

class GetAllTrackersEvent extends TrackerEvent {}

class AddNewTrackerEvent extends TrackerEvent {
  final TrackerEntity tracker;

  const AddNewTrackerEvent({required this.tracker});

   @override
  List<Object> get props => [tracker];
}

class GetCurrentLocationEvent extends TrackerEvent{}
