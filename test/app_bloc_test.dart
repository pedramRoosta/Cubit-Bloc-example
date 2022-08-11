import 'package:bloc_test/bloc_test.dart';
import 'package:bloc_test_project/apis/login_api.dart';
import 'package:bloc_test_project/apis/note_api.dart';
import 'package:bloc_test_project/bloc/actions.dart';
import 'package:bloc_test_project/bloc/app_bloc.dart';
import 'package:bloc_test_project/bloc/app_state.dart';
import 'package:bloc_test_project/models/model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

const Iterable<Note> mockedNotes = [
  Note(title: 'title1'),
  Note(title: 'title2'),
  Note(title: 'title3'),
];

@immutable
class MockedNoteApi implements NoteApiInterface {
  const MockedNoteApi();
  const MockedNoteApi.empty();

  @override
  Future<Iterable<Note>?> getNotes({required LoginHandle loginHandle}) async {
    return mockedNotes;
  }
}

@immutable
class MockedLoginApi implements LoginApiInterface {
  final String acceptedEmail;
  final String acceptedPassword;

  const MockedLoginApi({
    required this.acceptedEmail,
    required this.acceptedPassword,
  });

  const MockedLoginApi.empty()
      : acceptedEmail = '',
        acceptedPassword = '';

  @override
  Future<LoginHandle?> login(
      {required String email, required String password}) async {
    if (email == acceptedEmail && password == acceptedPassword) {
      return const LoginHandle.fooBar();
    } else {
      return null;
    }
  }
}

//---Bloc Test
void main() {
  blocTest<AppBloc, AppState>(
    'initial state of bloc should be appState.empty()',
    build: () {
      return AppBloc(
        loginApi: const MockedLoginApi.empty(),
        noteApi: const MockedNoteApi.empty(),
      );
    },
    verify: (bloc) => expect(
      bloc.state,
      const AppState.empty(),
    ),
  );
  blocTest<AppBloc, AppState>(
    'login with correct credentials',
    build: () {
      return AppBloc(
        loginApi: const MockedLoginApi(
          acceptedEmail: 'qweqwe',
          acceptedPassword: 'asdasd',
        ),
        noteApi: const MockedNoteApi.empty(),
      );
    },
    act: (bloc) {
      bloc.add(
        const LoginAction(email: 'qweqwe', password: 'asdasd'),
      );
    },
    expect: () {
      return [
        const AppState(
          isLoading: true,
          fetchedNotes: null,
          loginHandle: null,
          loginError: null,
        ),
        const AppState(
          isLoading: false,
          fetchedNotes: null,
          loginHandle: LoginHandle.fooBar(),
          loginError: null,
        )
      ];
    },
  );

  blocTest<AppBloc, AppState>(
    'login with inCorrect credentials',
    build: () {
      return AppBloc(
        loginApi: const MockedLoginApi(
          acceptedEmail: 'qwe',
          acceptedPassword: 'asd',
        ),
        noteApi: const MockedNoteApi.empty(),
      );
    },
    act: (bloc) {
      bloc.add(
        const LoginAction(email: 'qweqwe', password: 'asdasd'),
      );
    },
    expect: () {
      return [
        const AppState(
          isLoading: true,
          fetchedNotes: null,
          loginHandle: null,
          loginError: null,
        ),
        const AppState(
          isLoading: false,
          fetchedNotes: null,
          loginHandle: null,
          loginError: LoginErrors.invalidHandle,
        )
      ];
    },
  );

  blocTest<AppBloc, AppState>(
    'load notes with valid login hanmdle',
    build: () {
      return AppBloc(
        loginApi: const MockedLoginApi(
          acceptedEmail: 'qwe',
          acceptedPassword: 'asd',
        ),
        noteApi: const MockedNoteApi(),
      );
    },
    act: (bloc) {
      bloc.add(
        const LoginAction(email: 'qwe', password: 'asd'),
      );
      bloc.add(
        const LoadNoteAction(),
      );
    },
    expect: () {
      return [
        const AppState(
          isLoading: true,
          fetchedNotes: null,
          loginHandle: null,
          loginError: null,
        ),
        const AppState(
          isLoading: false,
          fetchedNotes: null,
          loginHandle: LoginHandle.fooBar(),
          loginError: null,
        ),
        const AppState(
          isLoading: true,
          fetchedNotes: null,
          loginHandle: LoginHandle.fooBar(),
          loginError: null,
        ),
        const AppState(
          isLoading: false,
          fetchedNotes: mockedNotes,
          loginHandle: LoginHandle.fooBar(),
          loginError: null,
        ),
      ];
    },
  );
}
