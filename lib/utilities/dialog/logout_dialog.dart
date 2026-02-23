import 'package:flutter/widgets.dart';
import 'package:learningdart/utilities/dialog/generic_dialog.dart';

Future<bool> logoutDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: 'Getout',
    content: 'Are you sure you want to get out?',
    optionsBuilder: () => {'Get out': true, 'Nooo I want to stay': false},
  ).then((value) => value ?? false);
}
