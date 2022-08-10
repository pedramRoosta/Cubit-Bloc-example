import 'package:bloc_test_project/models/model.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class LoginApiInterface {
  const LoginApiInterface();
  Future<LoginHandle?> login({
    required String email,
    required String password,
  });
}

@immutable
class LoginApi implements LoginApiInterface {
  //Singleton pattern
  const LoginApi._sharedInstance();
  static const LoginApi _shared = LoginApi._sharedInstance();
  factory LoginApi.instance() => _shared;

  @override
  Future<LoginHandle?> login({
    required String email,
    required String password,
  }) {
    return Future.delayed(
        const Duration(seconds: 2), () => email == 'a' && password == 'a').then(
      (isLoggedIn) => isLoggedIn ? const LoginHandle.fooBar() : null,
    );
  }
}
