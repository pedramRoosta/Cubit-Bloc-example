import 'package:bloc_test_project/bloc/app_action.dart';
import 'package:bloc_test_project/bloc/app_bloc.dart';
import 'package:bloc_test_project/bloc/app_state.dart';
import 'package:bloc_test_project/extensions/stream/start_with.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocView<T extends AppBloc> extends StatelessWidget {
  const AppBlocView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    startUpdatingBloc(context);
    return SizedBox(
      width: double.maxFinite,
      child: BlocBuilder<T, AppState>(
        builder: (context, state) {
          if (state.error != null) {
            return const Text('an error occured');
          } else if (state.data != null) {
            return Image.memory(
              state.data!,
              fit: BoxFit.cover,
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  void startUpdatingBloc(BuildContext context) {
    Stream.periodic(
      const Duration(seconds: 10),
      ((computationCount) => const LoadNextUrlEvent()),
    ).startWith(const LoadNextUrlEvent()).forEach((event) {
      context.read<T>().add(event);
    });
  }
}
