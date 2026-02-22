import 'dart:developer' as devtools;
import 'package:flutter/material.dart';
import 'package:learningdart/constants/routes.dart';
import 'package:learningdart/enums/menu_action.dart';
import 'package:learningdart/services/auth/auth_service.dart';
import 'package:learningdart/services/crud/notes_service.dart';

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  late final NotesService _notesService;
  String get userEmail => AuthService.firebase().currentUser!.email!;

  @override
  void initState() {
    _notesService = NotesService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 19, 19, 19),
      appBar: AppBar(
        title: const Text('Notes'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(newNoteRoute);
            },
            icon: const Icon(Icons.add),
          ),
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
                  child: Text('Logout'),
                ),
              ];
            },
          ),
        ],
        backgroundColor: Colors.amberAccent,
      ),
      body: FutureBuilder<DatabaseUser>(
        future: _notesService.getOrCreateUser(email: userEmail),
        builder: (context, userSnapshot) {
          switch (userSnapshot.connectionState) {
            case ConnectionState.done:
              final dbUser = userSnapshot.data;
              if (dbUser == null) {
                return const Center(child: CircularProgressIndicator());
              }

              return StreamBuilder<List<DatabaseNote>>(
                stream: _notesService.allNotes,
                builder: (context, notesSnapshot) {
                  if (!notesSnapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final allNotes = notesSnapshot.data!
                      .where((note) => note.userId == dbUser.id)
                      .toList();

                  if (allNotes.isEmpty) {
                    return const Center(child: Text('No notes yet'));
                  }

                  return ListView.builder(
                    itemCount: allNotes.length,
                    itemBuilder: (context, index) {
                      final note = allNotes[index];
                      return ListTile(
                        title: Text(
                          note.text.isEmpty ? '(empty note)' : note.text,
                          style: TextStyle(
                            color: const Color.fromARGB(255, 223, 218, 200),
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    },
                  );
                },
              );
            default:
              return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

Future<bool> logoutDialogue(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Logout?'),
        content: const Text('Wanna logout baby girl?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: const Text('Getout'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text('Stay'),
          ),
        ],
      );
    },
  ).then((value) => value ?? false);
}
