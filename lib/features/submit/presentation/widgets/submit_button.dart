import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shipment/presentation/screens/select_shipment.dart';

import '../../../../core/strings/strings_class.dart';
import '../../../../core/utils/snack_bar_util.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../domain/entities/submit_form_entity.dart';
import '../bloc/submit_bloc.dart';

class SubmitButton {
  void tryToSubmit(
      BuildContext context,
      GlobalKey<FormState> formKey,
      TextEditingController nameController,
      TextEditingController phoneController) {
    final isValid = formKey.currentState!.validate();

    if (isValid) {
      final form = SubmitFormEntity(
        time: Timestamp.now(),
        name: nameController.text,
        phoneNumber: int.parse(phoneController.text),
      );

      formKey.currentState!.save();

      BlocProvider.of<SubmitBloc>(context).add(SubmitFormEvent(form: form));
      showDialog(
        context: context,
        builder: (context) => BlocConsumer<SubmitBloc, SubmitState>(
          listener: (context, state) {
            if (state is SubmitFormSuccessionState) {
              SnackBarUtil().getSnackBar(
                  context: context,
                  message: FormStrings.successionSubmit,
                  color: Colors.green);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SelectShipment(
                      driverName: nameController.text,
                      driverPhoneNumber: int.parse(phoneController.text),
                      time: Timestamp.now(),
                    ),
                  ),
                  (route) => false);
            } else if (state is SubmitFormFailingState) {
              SnackBarUtil().getSnackBar(
                  context: context,
                  message: state.errorMessage,
                  color: Colors.red);
            }
          },
          builder: (context, state) {
            if (state is SubmitFormLoadingState) {
              return const LoadingWidget();
            }
            return const SizedBox();
          },
        ),
      );
    }
  }
}
