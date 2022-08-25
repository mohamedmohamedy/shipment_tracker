import 'package:flutter/material.dart';
import '../../../../core/strings/strings_class.dart';
import '../widgets/login_widgets/try_to_login_method.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = RoutesName.loginScreen;

  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBar(),
      body: _getBody(context),
    );
  }

//____________________________________Build functions_____________________________________________
 
 
  AppBar _getAppBar() {
    return AppBar(
      title: const Text(LoginStrings.loginTitle),
      centerTitle: true,
    );
  }

  Center _getBody(BuildContext context) {
    return Center(
      child: ElevatedButton(
          onPressed: () => TryToLogin().call(context), child: Text('login')),
    );
  }

 
}
