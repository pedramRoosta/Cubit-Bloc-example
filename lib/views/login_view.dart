import 'package:bloc_test_project/bloc/actions.dart';
import 'package:bloc_test_project/bloc/app_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class LoginView extends HookWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emailCtrl = useTextEditingController();
    final passwordCtrl = useTextEditingController();
    return Column(
      children: [
        TextField(
          controller: emailCtrl,
        ),
        TextField(
          controller: passwordCtrl,
        ),
        TextButton(
          onPressed: () {
            context.read<AppBloc>().add(
                  LoginAction(
                    email: emailCtrl.text,
                    password: passwordCtrl.text,
                  ),
                );
          },
          child: const Text('Log in'),
        ),
      ],
    );
  }
}
