import 'dart:developer' as devtools;
import 'package:flutter/material.dart';
import 'package:learningdart/constants/routes.dart';
import 'package:learningdart/enums/menu_action.dart';
import 'package:learningdart/services/auth/auth_service.dart';

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 19, 19, 19),
      appBar: AppBar(
        title: const Text('Notes'),
        actions: [
          PopupMenuButton<MenuAction>(
            onSelected: (whatWasSelected) async {
              switch (whatWasSelected) {
                case MenuAction.logout:
                  final shouldLogout = await logoutDialogue(context);
                  devtools.log(shouldLogout.toString());

                  if (shouldLogout) {
                    await AuthService.firebase().logout();
                    Navigator.of(
                      context,
                    ).pushNamedAndRemoveUntil(loginRoute, (_) => false);
                  }
              }
            },

            itemBuilder: (context) {
              return [
                const PopupMenuItem(
                  value: MenuAction.logout,
                  child: Text("Logout"),
                ),
              ];
            },
          ),
        ],
        backgroundColor: Colors.amberAccent,
      ),
    );
  }
}

Future<bool> logoutDialogue(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Logout?"),
        content: const Text("Wanna logout baby girl?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: const Text("Getout"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text("Stay"),
          ),
        ],
      );
    },
  ).then((value) => value ?? false);
}
