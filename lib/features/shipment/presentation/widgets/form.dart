import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../tracker/domain/entities/tracker_entity.dart';
import '../../../tracker/presentation/bloc/tracker_bloc.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/strings/strings_class.dart';
import '../../../../core/values/doubles.dart';
import '../bloc/shipment_bloc.dart';

class SelectionFormWidget extends StatelessWidget {
  const SelectionFormWidget({
    Key? key,
    required this.textController,
    required this.formKey,
    required this.driverName,
    required this.driverPhoneNumber,
    required this.time,
  }) : super(key: key);

  final TextEditingController textController;
  final GlobalKey<FormState> formKey;
  final String driverName;
  final int driverPhoneNumber;
  final Timestamp time;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShipmentBloc, ShipmentState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is SuccessToGetCurrentShipmentLocationState) {
          return TextFormField(
            controller: textController,
            keyboardType: TextInputType.name,
            onFieldSubmitted: (value) => getShipment(context, value),
            validator: (value) {
              if (IDS.contains(value)) {
                return null;
              }
              return SelectShipmentStrings.textValidator;
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Doubles.d_10)),
              labelText: SelectShipmentStrings.enterId,
            ),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }

  void getShipment(context, value) {
    if (formKey.currentState!.validate()) {
      BlocProvider.of<ShipmentBloc>(context)
          .add(FindShipmentById(shipmentId: value));
    }
  }
}
