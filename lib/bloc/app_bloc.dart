import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:bloc_test_project/auth/auth_error.dart';
import 'package:bloc_test_project/bloc/app_event.dart';
import 'package:bloc_test_project/bloc/app_state.dart';
import 'package:bloc_test_project/helpers/helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc()
      : super(const AppStateLoggedOut(
          isLoading: false,
        )) {
    on<AppEventUploadImage>((event, emit) async {
      final user = state.getUser;
      if (user == null) {
        emit(const AppStateLoggedOut(isLoading: false));
        return;
      }
      emit(AppStateLoggedIn(
        user: user,
        images: state.getImages ?? [],
        isLoading: false,
      ));
      final file = File(event.filePathToUpload);
      await uploadImage(file: file, userId: user.uid);
      final images = await getImages(user.uid);
      emit(AppStateLoggedIn(
        user: user,
        images: images,
        isLoading: false,
      ));
    });
    on<AppEventDeleteAccount>((event, emit) async {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        emit(const AppStateLoggedOut(isLoading: false));
        return;
      }
      emit(AppStateLoggedIn(
        user: user,
        images: state.getImages ?? [],
        isLoading: true,
      ));

      try {
        final folder = await FirebaseStorage.instance.ref(user.uid).listAll();
        for (var element in folder.items) {
          await element.delete().catchError((_) {});
        }
        await FirebaseStorage.instance
            .ref(user.uid)
            .delete()
            .catchError((_) {});
        await user.delete();
        await FirebaseAuth.instance.signOut();
        emit(const AppStateLoggedOut(
          isLoading: false,
        ));
      } on FirebaseAuthException catch (e) {
        emit(AppStateLoggedIn(
            user: user,
            images: state.getImages ?? [],
            isLoading: false,
            authError: AuthError.from(e)));
      } on FirebaseException {
        emit(const AppStateLoggedOut(isLoading: false));
      }
    });
    on<AppEventLogout>(
      (event, emit) async {
        emit(const AppStateLoggedOut(isLoading: true));
        await FirebaseAuth.instance.signOut();
        emit(const AppStateLoggedOut(
          isLoading: false,
        ));
      },
    );
    on<AppEventInitialize>(
      (event, emit) async {
        final user = FirebaseAuth.instance.currentUser;
        if (user == null) {
          emit(const AppStateLoggedOut(isLoading: false));
        } else {
          final images = await getImages(user.uid);
          emit(AppStateLoggedIn(
            user: user,
            images: images,
            isLoading: false,
          ));
        }
      },
    );
    on<AppEventRegister>(
      (event, emit) async {
        emit(const AppStateIsInRegisterView(isLoading: true));
        final email = event.email;
        final password = event.password;
        try {
          final credentials =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email,
            password: password,
          );
          emit(
            AppStateLoggedIn(
                user: credentials.user!, images: const [], isLoading: false),
          );
        } on FirebaseAuthException catch (e) {
          emit(AppStateIsInRegisterView(
            isLoading: false,
            authError: AuthError.from(e),
          ));
        }
      },
    );
    on<AppEventGoToLogin>((event, emit) {
      emit(const AppStateLoggedOut(isLoading: false));
    });
    on<AppEventLogin>((event, emit) async {
      emit(const AppStateLoggedOut(isLoading: true));
      final email = event.email;
      final password = event.password;
      try {
        final userCredentials =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        final user = userCredentials.user!;
        final images = await getImages(user.uid);
        emit(
          AppStateLoggedIn(
            user: user,
            images: images,
            isLoading: false,
          ),
        );
      } on FirebaseAuthException catch (e) {
        emit(AppStateLoggedOut(
          isLoading: false,
          authError: AuthError.from(e),
        ));
      }
    });
    on<AppEventGoToRegistration>((event, emit) {
      emit(const AppStateIsInRegisterView(isLoading: false));
    });
  }
}
