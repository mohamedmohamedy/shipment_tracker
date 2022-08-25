import 'package:firebase_core/firebase_core.dart';
import '../../../../core/errors/exceptions/exceptions.dart';
import '../models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class RemoteAuthDataSource {
  Future<UserModel> signInAnonymously();
}

class RemoteAuthDataSourceImpl implements RemoteAuthDataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<UserModel> signInAnonymously() async {
    try {
      final result = await _auth.signInAnonymously();
      User user = result.user!;
      return UserModel(userUid: user.uid);
    } on ServerException {
      throw ServerException();
    }
  }
}
