import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:todo/models/tasklist.dart';

class Task extends StatefulWidget {
  Task(
      {super.key,
      required this.todo,
      required this.onDelete,
      required this.onTodoChange});

  TodoItem todo;
  final onDelete;
  final onTodoChange;

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  bool is_editing = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Card(
            margin: const EdgeInsets.only(top: 10, left: 3),
            elevation: 3,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: ListTile(
              trailing: IconButton(
                icon: Icon(is_editing ? Icons.done : Icons.edit),
                onPressed: () {
                  setState(() {
                    is_editing = !is_editing;
                  });
                },
              ),
              title: is_editing
                  ? TextFormField(
                      initialValue: widget.todo.text,
                      onChanged: (val) => widget.todo.text = val,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                        fontSize: 15,
                      ),
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter your task",
                          ),
                    )
                  : Text(widget.todo.text,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                        fontSize: 15,
                        decoration: widget.todo.isDone
                            ? TextDecoration.lineThrough
                            : null,
                      )),
            ),
          ),
        ),
        IconButton(
            onPressed: () {
              widget.onTodoChange(widget.todo);
            },
            icon: Icon(
              widget.todo.isDone
                  ? Icons.check_box
                  : Icons.check_box_outline_blank,
              size: 30,
              color: Colors.blueAccent,
            )),
        IconButton(
            onPressed: () {
              widget.onDelete(widget.todo.text);
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
