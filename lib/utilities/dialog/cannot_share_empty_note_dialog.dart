import 'package:flutter/material.dart';
import 'package:learningdart/utilities/dialog/generic_dialog.dart';

Future<void> showCannotShareEmptyNotesDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: 'Sharing',
    content: 'You cannot share empty note',
    optionsBuilder: () => {'ok': null},
  );
}
