import 'package:flutter/foundation.dart';

@immutable
abstract class AppAction {
  const AppAction();
}

@immutable
abstract class LoginAction implements AppAction {
  final String email;
  final String password;
  const LoginAction({
    required this.email,
    required this.password,
  });
}

@immutable
abstract class LoadNoteAction implements AppAction {
  const LoadNoteAction();
}
