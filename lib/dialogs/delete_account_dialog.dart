import 'package:bloc_test_project/dialogs/generic_dialog.dart';
import 'package:flutter/material.dart';

Future<bool> showDeleteAccountDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: 'Delete account',
    content: 'Are you sure to delete your account?',
    optionsBuilder: () => {'Cancel': false, 'Delete account': true},
  ).then((value) => value ?? false);
}
