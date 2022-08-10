import 'package:flutter/material.dart';

@immutable
class LoginHandle {
  const LoginHandle({required this.token});
  const LoginHandle.fooBar() : token = 'foobar';

  final String token;

  @override
  bool operator ==(covariant LoginHandle other) => token == other.token;

  @override
  int get hashCode => token.hashCode;

  @override
  String toString() => 'LoginHanle token=$token';
}

enum LoginErrors {
  invalidHandle,
}

extension ListViewOnIterable<T> on Iterable<T> {
  Widget getListView() {
    return ListView.builder(
      itemCount: length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(elementAt(index).toString()),
        );
      },
    );
  }
}

@immutable
class Note {
  const Note({required this.title});

  final String title;

  @override
  String toString() => 'Note title=$title';
}

final mockedNotes =
    Iterable.generate(3, (index) => Note(title: 'Note ${index + 1}'));
