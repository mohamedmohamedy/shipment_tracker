import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class SubmitFormEntity extends Equatable {
  final String name;
  final int phoneNumber;
  final Timestamp time;

   const SubmitFormEntity( {required this.time ,required this.name, required this.phoneNumber});

  @override
  List<Object?> get props => [name, phoneNumber, time];
}
