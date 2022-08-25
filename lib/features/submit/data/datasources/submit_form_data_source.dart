import 'package:dartz/dartz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/errors/exceptions/exceptions.dart';
import '../models/submit_form_model.dart';

abstract class SubmitFormDataSource {
  Future<Unit> submitForm(SubmitFormModel form);
}

class SubmitFormDataSourceImpl implements SubmitFormDataSource {
  final db = FirebaseFirestore.instance;

  @override
  Future<Unit> submitForm(SubmitFormModel form) async {
    final user = form.toJson();

    try {
      await db.collection("users").doc(form.name).set(user);
      return Future.value(unit);
    } on ServerException {
      throw ServerException();
    }
  }
}
