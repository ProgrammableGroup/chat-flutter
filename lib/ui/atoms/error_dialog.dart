import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog(this.errorMessage);
  final String errorMessage;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('ERROR'),
      content: Text(errorMessage),
      actions: [
        FlatButton(
          child: const Text('OK'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
