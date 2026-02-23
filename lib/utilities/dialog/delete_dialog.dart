import 'package:flutter/widgets.dart';
import 'package:learningdart/utilities/dialog/generic_dialog.dart';

Future<bool> showDeleteDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: 'Delete?',
    content: 'Notes Gone Forever?',
    optionsBuilder: () => {'Hell yeah': true, 'NOOOO!': false},
  ).then((value) => value ?? false);
}
