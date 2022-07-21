import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math show Random;
import 'package:bloc_test_project/helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(),
        body: const Home(),
      ),
    ),
  );
}

const names = [
  'name1',
  'name1',
  'name4',
  'name3',
];

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final cubit = NamesCubit();
    return Column(
      children: [
        TextButton(
          onPressed: () {
            cubit.getRandomName();
          },
          child: const Text(
            'click to see the next random string!',
          ),
        ),
        BlocBuilder<NamesCubit, String>(
          bloc: cubit,
          builder: (context, state) {
            return Column(
              children: [
                Text(state),
                StreamBuilder<String?>(
                    stream: cubit.stream,
                    builder: ((context, snapshot) {
                      return Text(snapshot.data ?? '');
                    }))
              ],
            );
          },
        ),
      ],
    );
  }
}

class NamesCubit extends Cubit<String> {
  NamesCubit() : super('');

  void getRandomName() {
    emit(names.getRandomItem());
  }
}
