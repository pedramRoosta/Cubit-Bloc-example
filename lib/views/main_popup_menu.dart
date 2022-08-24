import 'package:bloc_test_project/bloc/app_bloc.dart';
import 'package:bloc_test_project/bloc/app_event.dart';
import 'package:bloc_test_project/dialogs/delete_account_dialog.dart';
import 'package:bloc_test_project/dialogs/logout_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum MenuAction { logOut, deleteAccount }

class MainPopupMenu extends StatelessWidget {
  const MainPopupMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MenuAction>(
      onSelected: (value) async {
        switch (value) {
          case MenuAction.logOut:
            final shouldLogout = await showLogoutDialog(context);
            if (shouldLogout) {
              context.read<AppBloc>().add(const AppEventLogout());
            }
            break;
          case MenuAction.deleteAccount:
            final shouldDeleteAccount = await showDeleteAccountDialog(context);
            if (shouldDeleteAccount) {
              context.read<AppBloc>().add(const AppEventDeleteAccount());
            }
            break;
        }
      },
      itemBuilder: ((context) {
        return [
          const PopupMenuItem<MenuAction>(
            value: MenuAction.logOut,
            child: Text('Log out'),
          ),
          const PopupMenuItem<MenuAction>(
            value: MenuAction.deleteAccount,
            child: Text('Delete account'),
          ),
        ];
      }),
    );
  }
}
