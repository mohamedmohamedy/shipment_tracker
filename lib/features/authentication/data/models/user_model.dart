import '../../domain/entities/user.dart';

class UserModel extends UserEntity {
  const UserModel({required super.userUid});

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      UserModel(userUid: json['uid']);

  Map<String, dynamic> toJson() => {'uid': userUid};
}
