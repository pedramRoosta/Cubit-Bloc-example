import 'package:bloc_test_project/bloc/app_bloc.dart';
import 'package:bloc_test_project/bloc/app_event.dart';
import 'package:bloc_test_project/bloc/app_state.dart';
import 'package:bloc_test_project/dialogs/show_auth_error.dart';
import 'package:bloc_test_project/firebase_options.dart';
import 'package:bloc_test_project/loading/loading_screen.dart';
import 'package:bloc_test_project/views/login_view.dart';
import 'package:bloc_test_project/views/photo_gallery_view.dart';
import 'package:bloc_test_project/views/register_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    BlocProvider(
      create: (context) => AppBloc()..add(const AppEventInitialize()),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: BlocConsumer<AppBloc, AppState>(
            builder: (context, state) {
              if (state is AppStateLoggedOut) {
                return const LoginView();
              } else if (state is AppStateIsInRegisterView) {
                return const RegisterView();
              } else if (state is AppStateLoggedIn) {
                return const PhotoGalleryView();
              } else {
                return Container();
              }
            },
            listener: (context, state) {
              if (state.isLoading) {
                LoadingScreen.instance()
                    .show(context: context, text: 'Loading...');
              } else {
                LoadingScreen.instance().hide();
              }
              final authError = state.authError;
              if (authError != null) {
                showAuthError(
                  authError: authError,
                  context: context,
                );
              }
            },
          )),
    ),
  );
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text(''));
  }
}
