import 'package:flutter/material.dart';

import '../model/todo.dart';
import '../constants/colors.dart';

class TodoItem extends StatefulWidget {
  final ToDo todo;
  final Function onToDoChanged;
  final Function onDeleteItem;

  const TodoItem({
    super.key,
    required this.todo,
    required this.onToDoChanged,
    required this.onDeleteItem,
  });

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(widget.todo.id.toString()),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        widget.onDeleteItem(widget.todo.id);
      },
      background: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
        child: const Icon(Icons.delete, color: tdRed),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(1, 1),
                  spreadRadius: 0,
                  blurRadius: 2,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Transform.scale(
                  scale: 1.3,
                  child: Checkbox(
                    checkColor: Colors.white,
                    value: widget.todo.isDone,
                    fillColor: WidgetStateProperty.resolveWith<Color?>((states) => widget.todo.isDone ? tdGreen : tdRed),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                    onChanged: (bool? value) {
                      setState(() {
                        widget.todo.isDone = value!;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  widget.todo.taskText!,
                  style: TextStyle(
                    fontSize: 16,
                    color: tdBlack,
                    decoration: widget.todo.isDone ? TextDecoration.lineThrough : null,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10)
        ],
      ),
    );
  }
}
