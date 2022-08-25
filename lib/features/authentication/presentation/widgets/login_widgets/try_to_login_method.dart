import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/strings/strings_class.dart';

import '../../../../../core/utils/snack_bar_util.dart';
import '../../../../../core/widgets/loading_widget.dart';
import '../../bloc/authentication_bloc.dart';
import '../../../../submit/presentation/screens/form.dart';

class TryToLogin {
  void call(BuildContext context) {
    BlocProvider.of<AuthenticationBloc>(context).add(SignInAnonymouslyEvent());
    showDialog(
      context: context,
      builder: (context) {
        return BlocConsumer<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is SuccessionAuthenticatingState) {
              SnackBarUtil().getSnackBar(
                  context: context,
                  message: LoginStrings.successLoginMessage,
                  color: Colors.green);

              Navigator.of(context).pushNamedAndRemoveUntil(
                FormScreen.routeName,
                (route) => false,
              );
            } else if (state is AuthenticationFailingState) {
              SnackBarUtil().getSnackBar(
                  context: context,
                  message: state.errorMessage,
                  color: Colors.red);
            }
          },
          builder: (context, state) {
            if (state is AuthenticationLoadingState) {
              return const LoadingWidget();
            }
            return const SizedBox();
          },
        );
      },
    );
  }
}
