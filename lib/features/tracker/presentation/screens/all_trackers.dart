import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/strings/strings_class.dart';
import '../../../../core/utils/list_item.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../domain/entities/tracker_entity.dart';
import '../bloc/tracker_bloc.dart';
import 'map.dart';

import '../../../../core/utils/snack_bar_util.dart';

class AllTrackersScreen extends StatelessWidget {
  const AllTrackersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     late List<TrackerEntity> trackers;
    return Scaffold(
      appBar: AppBar(
        title: const Text(AllTrackersStrings.title),
        centerTitle: true,
      ),
      body: BlocConsumer<TrackerBloc, TrackerState>(
        listener: (context, state) {
          if (state is AddingNewTrackerSuccessState) {
            BlocProvider.of<TrackerBloc>(context).add(GetAllTrackersEvent());
          } else if (state is SuccessLoadingState) {
             trackers = state.trackers;
            SnackBarUtil().getSnackBar(
                context: context,
                message: AllTrackersStrings.loadingAllTrackerSuccessfully,
                color: Colors.green);
          } else if (state is FailingLoadingState) {
            SnackBarUtil().getSnackBar(
                context: context,
                message: state.failMessage,
                color: Colors.red);
          }
        },
        builder: (context, state) {
          if (state is LoadingTrackersState) {
            return const LoadingWidget();
          }
          if (state is SuccessLoadingState) {
            return ListView.builder(
              itemCount: state.trackers.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () =>  Navigator.of(context).push(MaterialPageRoute(builder: (context) => MapScreen(tracker: trackers[index]),)),
                child: ListItem(
                  title: trackers[index].shipmentTarget,
                  subtitle: 'Driver Name: ${trackers[index].driverName}',
                  leading: trackers[index].shipmentId,
                ),
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
