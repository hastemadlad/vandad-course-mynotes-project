import 'package:flutter/material.dart';
import 'package:learningdart/services/cloud/cloud_note.dart';
import 'package:learningdart/utilities/dialog/delete_dialog.dart';

typedef NoteCallBack = void Function(CloudNote note);
//This is creating a function called DeleteNoteCallBack that is taking a DatabaseNote type object and returning void/nothing

class NotesListView extends StatelessWidget {
  final Iterable<CloudNote> notes;
  final NoteCallBack onDeletenote;
  final NoteCallBack onTap;

  const NotesListView({
    super.key,
    required this.notes,
    required this.onDeletenote,
    required this.onTap,
  });

  //! a bit different for vandad ^^^ super.key chapter 34 min 24:11

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (context, index) {
        final note = notes.elementAt(index);
        return ListTile(
          onTap: () {
            onTap(note);
          },
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
