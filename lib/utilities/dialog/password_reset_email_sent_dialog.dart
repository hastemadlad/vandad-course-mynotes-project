import 'package:flutter/widgets.dart';
import 'package:learningdart/utilities/dialog/generic_dialog.dart';

Future<void> showPasswordResetSentDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: 'Password Reset Request',
    content:
        'We have sent the password reset link, check your email and also check your spam folder',
    optionsBuilder: () => {'OK': null},
  );
}
