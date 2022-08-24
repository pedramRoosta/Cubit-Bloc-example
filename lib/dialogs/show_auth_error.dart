import 'package:bloc_test_project/auth/auth_error.dart';
import 'package:bloc_test_project/dialogs/generic_dialog.dart';
import 'package:flutter/material.dart' show BuildContext;

Future<void> showAuthError({
  required AuthError authError,
  required BuildContext context,
}) {
  return showGenericDialog<void>(
    context: context,
    title: authError.errorTitle,
    content: authError.errorText,
    optionsBuilder: () => {
      'OK': true,
    },
  );
}
