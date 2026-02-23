import 'package:flutter/material.dart';
import 'package:learningdart/utilities/dialog/generic_dialog.dart';

Future<void> showErrorDialog(BuildContext context, String text) {
  return showGenericDialog(
    context: context,
    title: 'An error as occured',
    content: text,
    optionsBuilder: () => {'OK': null},
  );
}
