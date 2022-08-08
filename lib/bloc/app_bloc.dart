import 'package:bloc/bloc.dart';
import 'package:bloc_test_project/apis/login_api.dart';
import 'package:bloc_test_project/apis/note_api.dart';
import 'package:bloc_test_project/bloc/actions.dart';
import 'package:bloc_test_project/bloc/app_state.dart';
import 'package:bloc_test_project/models/model.dart';

class AppBloc extends Bloc<AppAction, AppState> {
  AppBloc({
    required this.loginApi,
    required this.noteApi,
  }) : super(const AppState.empty()) {
    on<LoginAction>((event, emit) async {
      emit(const AppState(
        isLoading: true,
        fetchedNotes: null,
        loginHandle: null,
        loginError: null,
      ));
      //log the user
      final loginHandle = await loginApi.login(
        email: event.email,
        password: event.password,
      );
      emit(AppState(
        isLoading: false,
        fetchedNotes: null,
        loginHandle: loginHandle,
        loginError: loginHandle == null ? LoginErrors.invalidHandle : null,
      ));
    });

    on<LoadNoteAction>((event, emit) async {
      emit(AppState(
        isLoading: true,
        fetchedNotes: null,
        loginHandle: state.loginHandle,
        loginError: null,
      ));
      final notes = await noteApi.getNotes(loginHandle: state.loginHandle!);
      emit(AppState(
        isLoading: false,
        fetchedNotes: notes,
        loginHandle: state.loginHandle,
        loginError: null,
      ));
    });
  }

  final LoginApiInterface loginApi;
  final NoteApiInterface noteApi;
}
