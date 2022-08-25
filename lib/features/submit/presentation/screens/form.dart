import 'package:flutter/material.dart';
import '../../../../core/strings/strings_class.dart';
import '../widgets/form_widget.dart';

class FormScreen extends StatelessWidget {
  static const String routeName = RoutesName.formScreen;

  const FormScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBar(),
      body: Center(child: FormWidget()),
    );
  }

//_______________________________Building Functions__________________________________
  AppBar _getAppBar() {
    return AppBar(
      centerTitle: true,
      title: const Text(FormStrings.formTitle),
    );
  }
}
