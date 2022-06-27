import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math show Random;

const names = ["apfel", "bar", "Whiskey", 'names', 'khaj kolah'];

extension GetRandomit<T> on Iterable<T> {
  T get getRandomElement => elementAt(
        math.Random().nextInt(length),
      );
}

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: const Home(),
      ),
    ),
  );
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final CubitVM cubit;

  @override
  void initState() {
    super.initState();
    cubit = CubitVM();
  }

  @override
  void dispose() {
    super.dispose();
    cubit.close();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String?>(
      stream: cubit.stream,
      builder: (context, snapshot) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (snapshot.hasData) Text(snapshot.data ?? ''),
              TextButton(
                onPressed: () => cubit.pickRandomName(),
                child: const Text('Pick new names'),
              )
            ],
          ),
        );
      },
    );
  }
}

class CubitVM extends Cubit<String?> {
  CubitVM() : super(null);

  void pickRandomName() => emit(names.getRandomElement);
}
