import 'package:bloc_test_project/bloc/app_bloc.dart';
import 'package:bloc_test_project/bloc/app_event.dart';
import 'package:bloc_test_project/helpers/if_debugging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class LoginView extends HookWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emailCtrl = useTextEditingController(
      text: 'pedram.roo@gmail.com'.ifDebugging,
    );
    final passwordCtrl = useTextEditingController(
      text: 'qwaszx'.ifDebugging,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log in'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextField(
            controller: emailCtrl,
          ),
          TextField(
            controller: passwordCtrl,
          ),
          TextButton(
            onPressed: () {
              final email = emailCtrl.text;
              final password = passwordCtrl.text;
              context.read<AppBloc>().add(
                    AppEventLogin(
                      email: email,
                      password: password,
                    ),
                  );
            },
            child: const Text('Login'),
          ),
          TextButton(
            onPressed: () {
              context.read<AppBloc>().add(
                    const AppEventGoToRegistration(),
                  );
            },
            child: const Text('New? register here.'),
          ),
        ],
      ),
    );
  }
}
