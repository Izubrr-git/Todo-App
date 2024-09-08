import 'package:flutter/material.dart';

class AddTaskDialog extends StatefulWidget {
  final Function(String)? onAdd;

  const AddTaskDialog({this.onAdd, super.key});

  @override
  AddTaskDialogState createState() => AddTaskDialogState();
}

class AddTaskDialogState extends State<AddTaskDialog> {
  final _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Task'),
      content: TextField(
        controller: _textFieldController,
        autofocus: true,
        decoration: const InputDecoration(
          labelText: 'Task name',
          border: OutlineInputBorder(),
        ),
      ),
      actions: [
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FilledButton(
          child: const Text('Add'),
          onPressed: () async {
            if (_textFieldController.text.isNotEmpty) {
              if (widget.onAdd != null) {
                widget.onAdd!(_textFieldController.text);
              }
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}

Future<String?> showAddTaskDialog(BuildContext context) async {
  String? result;
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AddTaskDialog(
        onAdd: (text) {
          result = text;
        },
      );
    },
  );
  return result;
}
