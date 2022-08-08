import 'package:bloc_test_project/home/home_v.dart';
import 'package:bloc_test_project/home/home_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(),
        body: BlocProvider(
          create: (context) => HomeViewModel(),
          child: const HomeScreen(),
        ),
      ),
    ),
  );
}
