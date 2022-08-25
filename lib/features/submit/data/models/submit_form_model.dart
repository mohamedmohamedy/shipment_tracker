import '../../domain/entities/submit_form_entity.dart';

class SubmitFormModel extends SubmitFormEntity {
  const SubmitFormModel(
      {required super.name, required super.phoneNumber, required super.time});

  Map<String, dynamic> toJson() =>
      {'name': name, 'phone Number': phoneNumber, 'time': time};
}
