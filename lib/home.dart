import 'package:bloc_test_project/app_bloc_view.dart';
import 'package:bloc_test_project/bloc/bottom_bloc.dart';
import 'package:bloc_test_project/bloc/top_bloc.dart';
import 'package:bloc_test_project/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: MultiBlocProvider(
          providers: [
            BlocProvider<TopBloc>(
              create: (context) => TopBloc(
                urls: Constants.imageUrrl,
              ),
            ),
            BlocProvider<BottomBloc>(
              create: (context) => BottomBloc(
                urls: Constants.imageUrrl,
              ),
            )
          ],
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: const [
              Expanded(child: AppBlocView<TopBloc>()),
              Expanded(child: AppBlocView<BottomBloc>()),
            ],
          ),
        ),
      ),
    );
  }
}
