import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import '../../../../core/strings/strings_class.dart';
import '../../../../core/values/doubles.dart';
import '../../domain/entities/shipment_entity.dart';
import '../bloc/shipment_bloc.dart';
import '../../../tracker/presentation/screens/all_trackers.dart';

import '../../../../core/utils/snack_bar_util.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../tracker/domain/entities/tracker_entity.dart';
import '../../../tracker/presentation/bloc/tracker_bloc.dart';
import '../widgets/form.dart';
import '../widgets/selection_list_widget.dart';

class SelectShipment extends StatelessWidget {
  static const String routeName = RoutesName.selectShipmentScreen;

  final String driverName;
  final int driverPhoneNumber;
  final Timestamp time;
  SelectShipment({
    Key? key,
    required this.driverName,
    required this.driverPhoneNumber,
    required this.time,
  }) : super(key: key);

  final TextEditingController textController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBar(),
      body: _getBody(),
    );
  }

//____________________________Building functions_____________________________

  AppBar _getAppBar() {
    return AppBar(
      title: const Text(SelectShipmentStrings.title),
      centerTitle: true,
    );
  }

  Padding _getBody() {
    late List<ShipmentEntity> shipments;
    LocationData? currentLocation;
    return Padding(
      padding: const EdgeInsets.all(Doubles.d_20),
      child: Center(
        child: BlocConsumer<ShipmentBloc, ShipmentState>(
          listener: (context, state) {
            if (state is SuccessfullyShipmentState) {
              shipments = state.shipments;
              SnackBarUtil().getSnackBar(
                  context: context,
                  message: SelectShipmentStrings.loadingShipmentsSuccessState,
                  color: Colors.green);
              shipments = state.shipments;
              BlocProvider.of<ShipmentBloc>(context)
                  .add(GetCurrentShipmentLocationEvent());
            } else if (state is FailingShipmentState) {
              SnackBarUtil().getSnackBar(
                  context: context,
                  message: state.failMessage,
                  color: Colors.red);
            } else if (state is SuccessFindShipmentByIdState) {
              BlocProvider.of<TrackerBloc>(context).add(
                AddNewTrackerEvent(
                  tracker: TrackerEntity(
                    shipmentId: state.shipment.shipmentId,
                    shipmentTarget: state.shipment.name,
                    driverName: driverName,
                    driverNumber: driverPhoneNumber,
                    time: time,
                    currentLocationLat: currentLocation?.latitude ?? 0,
                    currentLocationLong: currentLocation?.longitude ?? 0,
                    targetLocationLat: state.shipment.targetLocation.latitude,
                    targetLocationLong: state.shipment.targetLocation.longitude,
                  ),
                ),
              );

              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => const AllTrackersScreen())),
                  (route) => false);
            }
          },
          builder: (context, state) {
            if (state is ShipmentLoadingState) {
              return const LoadingWidget();
            } else if (state is SuccessToGetCurrentShipmentLocationState) {
              currentLocation = state.currentLocation;
              return Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SelectionFormWidget(
                        textController: textController,
                        formKey: formKey,
                        driverName: driverName,
                        driverPhoneNumber: driverPhoneNumber,
                        time: time,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      SelectionListWidget(shipments: shipments),
                    ],
                  ),
                ),
              );
            } else {
              return const SizedBox(child: Text('test2'));
            }
          },
        ),
      ),
    );
  }
}
