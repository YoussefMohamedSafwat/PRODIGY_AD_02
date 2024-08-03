import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:todo/models/tasklist.dart';

class Task extends StatelessWidget {
  Task(
      {super.key,
      required this.todo,
      required this.onDelete,
      required this.onTodoChange});

  TodoItem todo;
  final onDelete;
  final onTodoChange;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Row(
      children: [
        Container(
          width: size.width * 0.7,
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(top: 10, left: 3),
          decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Text(todo.text,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
                fontSize: 15,
                decoration: todo.isDone ? TextDecoration.lineThrough : null,
              )),
        ),
        IconButton(
            onPressed: () {
              onTodoChange(todo);
            },
            icon: Icon(
              todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
              size: 30,
              color: Colors.blueAccent,
            )),
        IconButton(
            onPressed: () {
              onDelete(todo.text);
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
              size: 30,
            )),
      ],
    );
  }
}
