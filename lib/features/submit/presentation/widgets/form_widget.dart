import 'package:flutter/material.dart';
import '../../../../core/strings/strings_class.dart';
import '../../../../core/values/doubles.dart';
import 'submit_button.dart';

class FormWidget extends StatelessWidget {
  FormWidget({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Doubles.d_40),
      child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // name
                TextFormField(
                  controller: _nameController,
                  keyboardType: TextInputType.name,
                  validator: (value) =>
                      value!.isEmpty ? FormStrings.nameValidator : null,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Doubles.d_10)),
                    labelText: FormStrings.formName,
                  ),
                ),

                const SizedBox(
                  height: Doubles.d_30,
                ),

                // phone Number
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  validator: (value) =>
                      value!.isEmpty ? FormStrings.phoneValidator : null,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Doubles.d_10)),
                    labelText: FormStrings.formNumber,
                  ),
                ),

                const SizedBox(
                  height: Doubles.d_30,
                ),
                
                // Submit form button
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: Doubles.d_10,
                      fixedSize: const Size(Doubles.d_250, Doubles.d_55),
                    ),
                    onPressed: () => SubmitButton().tryToSubmit(
                        context, _formKey, _nameController, _phoneController),
                    child: const Text(
                      FormStrings.formSubmit,
                      style: TextStyle(fontSize: Doubles.d_20),
                    )),
              ],
            ),
          )),
    );
  }
}
