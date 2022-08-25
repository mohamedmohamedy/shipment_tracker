import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String userUid;

  const UserEntity({required this.userUid});

  @override
  List<Object?> get props => [userUid];
}
