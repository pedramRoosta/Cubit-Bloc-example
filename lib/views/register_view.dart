import 'package:bloc_test_project/bloc/app_bloc.dart';
import 'package:bloc_test_project/bloc/app_event.dart';
import 'package:bloc_test_project/helpers/if_debugging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class RegisterView extends HookWidget {
  const RegisterView({Key? key}) : super(key: key);

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
        title: const Text('Registeration'),
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
                    AppEventRegister(
                      email: email,
                      password: password,
                    ),
                  );
            },
            child: const Text('Register'),
          ),
          TextButton(
            onPressed: () {
              context.read<AppBloc>().add(
                    const AppEventGoToLogin(),
                  );
            },
            child: const Text('Already has an account? login here.'),
          ),
        ],
      ),
    );
  }
}
