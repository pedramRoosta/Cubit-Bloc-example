import 'package:bloc_test_project/bloc/app_action.dart';
import 'package:bloc_test_project/bloc/app_state.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math' as math;

typedef RandomUrlPicker = String Function({Iterable<String> urls});

extension RandomElemtn<String> on Iterable<String> {
  String randomElement() => elementAt(math.Random().nextInt(length));
}

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({
    required Iterable<String> urls,
  }) : super(const AppState.empty()) {
    on<LoadNextUrlEvent>((event, emit) async {
      emit(const AppState(isLoading: true, data: null, error: null));
      final url = urls.randomElement();
      try {
        final bundle = NetworkAssetBundle(Uri.parse(url));
        final data = (await bundle.load(url)).buffer.asUint8List();
        emit(AppState(isLoading: false, data: data, error: null));
      } catch (e) {
        emit(AppState(isLoading: false, data: null, error: e));
      }
    });
  }
}
