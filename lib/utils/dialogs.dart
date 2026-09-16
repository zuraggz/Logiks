import 'package:flutter/material.dart';

Future<bool> showDeleteConfirmDialog(
  BuildContext context, {
  required String itemName,
}) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Delete Lego"),
        content: Text.rich(TextSpan(children: [TextSpan(text: "Are you sure you want to delete "),
      TextSpan(
        text: "\"$itemName\"",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      TextSpan(text: "?")])),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text("Delete"),
          ),
        ],
      );
    },
  );
  return confirmed ?? false;
}
