import 'dart:developer' as devtools;
import 'package:flutter/material.dart';
import 'package:learningdart/constants/routes.dart';
import 'package:learningdart/enums/menu_action.dart';
import 'package:learningdart/services/auth/auth_service.dart';
import 'package:learningdart/services/crud/notes_service.dart';
import 'package:learningdart/utilities/dialog/logout_dialog.dart';
import 'package:learningdart/views/notes/notes_list_view.dart';

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  late final NotesService _notesService;
  String get userEmail => AuthService.firebase().currentUser!.email;

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
              Navigator.of(context).pushNamed(createOrUpdateNoteRoute);
            },
            icon: const Icon(Icons.add),
          ),
          PopupMenuButton<MenuAction>(
            onSelected: (whatWasSelected) async {
              switch (whatWasSelected) {
                case MenuAction.logout:
                  final shouldLogout = await logoutDialog(context);
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

              return StreamBuilder(
                //! had <List<DatabaseNote>> attached to it before
                stream: _notesService.allNotes,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                    case ConnectionState.active:
                      if (snapshot.hasData) {
                        final allNotes = snapshot.data as List<DatabaseNote>;
                        return NotesListView(
                          notes: allNotes,
                          onDeletenote: (note) async {
                            await _notesService.deleteNote(id: note.id);
                          },
                          onTap: (note) {
                            Navigator.of(context).pushNamed(
                              createOrUpdateNoteRoute,
                              arguments: note,
                            );
                          },
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    default:
                      return const Center(child: CircularProgressIndicator());
                  }
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



// was part of code keeping here for later use incase of bug
// if (!notesSnapshot.hasData) {
//                     return const Center(child: CircularProgressIndicator());
//                   }

//                   final allNotes = notesSnapshot.data!
//                       .where((note) => note.userId == dbUser.id)
//                       .toList();

//                   if (allNotes.isEmpty) {
//                     return const Center(child: Text('No notes yet'));
//                   }

//                   return ListView.builder(
//                     itemCount: allNotes.length,
//                     itemBuilder: (context, index) {
//                       final note = allNotes[index];
//                       return ListTile(
//                         title: Text(
//                           note.text.isEmpty ? '(empty note)' : note.text,
//                           style: TextStyle(
//                             color: const Color.fromARGB(255, 223, 218, 200),
//                           ),
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       );
//                     },
//                   );