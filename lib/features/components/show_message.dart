import 'package:flutter/material.dart';

class ShowMessage extends StatelessWidget {
  final String title;
  final String message;

  const ShowMessage({ super.key, required this.title, required this.message });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          child: const Text("Ok"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}