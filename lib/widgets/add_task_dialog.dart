import 'package:flutter/material.dart';

class AddTaskDialog extends StatefulWidget {
  final Function addTask;

  const AddTaskDialog({super.key, required this.addTask});

  @override
  _AddTaskDialogState createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
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
              widget.addTask(_textFieldController.text);
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}

void showAddTaskDialog(BuildContext context, Function addTask) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AddTaskDialog(addTask: addTask);
    },
  );
}
