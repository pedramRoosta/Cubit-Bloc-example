import 'package:bloc_test_project/models/model.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class NoteApiInterface {
  const NoteApiInterface();
  Future<Iterable<Note>?> getNotes({required LoginHandle loginHandle});
}

@immutable
class NoteApi implements NoteApiInterface {
  //Singleton pattern
  const NoteApi._sharedInstance();
  static const NoteApi _shared = NoteApi._sharedInstance();
  factory NoteApi.instance() => _shared;

  @override
  Future<Iterable<Note>?> getNotes({required LoginHandle loginHandle}) {
    return Future.delayed(const Duration(seconds: 2), () {}).then(
      (isLoggedIn) =>
          loginHandle == const LoginHandle.fooBar() ? mockedNotes : null,
    );
  }
}
