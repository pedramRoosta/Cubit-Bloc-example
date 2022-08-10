import 'package:bloc_test_project/apis/login_api.dart';
import 'package:bloc_test_project/apis/note_api.dart';
import 'package:bloc_test_project/bloc/actions.dart';
import 'package:bloc_test_project/bloc/app_bloc.dart';
import 'package:bloc_test_project/bloc/app_state.dart';
import 'package:bloc_test_project/models/model.dart';
import 'package:bloc_test_project/views/login_view.dart';
import 'package:bloc_test_project/widgets/generic_dialog.dart';
import 'package:bloc_test_project/widgets/loading_screen/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => AppBloc(
          loginApi: LoginApi.instance(),
          noteApi: NoteApi.instance(),
        ),
        child: Scaffold(
          appBar: AppBar(),
          body: BlocConsumer<AppBloc, AppState>(
            listener: (context, appState) {
              if (appState.isLoading) {
                LoadingScreen.instance().show(
                  context: context,
                  text: 'Please wait.',
                );
              } else {
                LoadingScreen.instance().hide();
              }
              final loginError = appState.loginError;
              if (loginError != null) {
                showGenericDialog(
                  context: context,
                  title: 'Error',
                  content: 'Error happens',
                  dialogOptionBuilder: () {
                    return {'ok': true};
                  },
                );
              }
              if (!appState.isLoading &&
                  appState.loginError == null &&
                  appState.loginHandle == const LoginHandle.fooBar() &&
                  appState.fetchedNotes == null) {
                context.read<AppBloc>().add(const LoadNoteAction());
              }
            },
            builder: (context, appState) {
              final notes = appState.fetchedNotes;
              if (notes == null) {
                return const LoginView();
              } else {
                return notes.getListView();
              }
            },
          ),
        ),
      ),
    ),
  );
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Home Page'));
  }
}
