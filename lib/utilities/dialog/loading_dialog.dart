import 'package:flutter/material.dart';
import 'package:path/path.dart';

typedef CloseDialog = void Function();
//in class parameters we usually put variables like strings and ints
//but when you want to use a function as a required thing, you can use typedef to define a fuction struture

CloseDialog showLoadingDialog({
  //This willl return a function with type CloseDialog
  required BuildContext context,
  required String text,
}) {
  final dialog = AlertDialog(
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const CircularProgressIndicator(),
        const SizedBox(height: 10),
        Text(text),
      ],
    ),
  );

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => dialog,
  );

  return () => Navigator.of(context).pop();
}
