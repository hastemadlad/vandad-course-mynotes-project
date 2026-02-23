import 'package:flutter/material.dart';
import 'package:learningdart/services/crud/notes_service.dart';
import 'package:learningdart/utilities/dialog/delete_dialog.dart';

typedef DeleteNoteCallBack = void Function(DatabaseNote note);
//This is creating a function called DeleteNoteCallBack that is taking a DatabaseNote type object and returning void/nothing

class NotesListView extends StatelessWidget {
  final List<DatabaseNote> notes;
  final DeleteNoteCallBack onDeletenote;

  const NotesListView({required this.notes, required this.onDeletenote});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (context, index) {
        final note = notes[index];
        return ListTile(
          title: Text(
            note.text.isEmpty ? '(empty note)' : note.text,
            style: TextStyle(color: const Color.fromARGB(255, 223, 218, 200)),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: IconButton(
            onPressed: () async {
              final shouldDelete = await showDeleteDialog(context);
              if (shouldDelete) {
                onDeletenote(note);
              }
            },
            icon: const Icon(Icons.delete),
          ),
        );
      },
    );
  }
}
