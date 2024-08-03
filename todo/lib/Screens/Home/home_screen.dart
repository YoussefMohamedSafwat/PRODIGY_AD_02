import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo/Screens/Home/widgets/search_bar.dart';
import 'package:todo/Screens/Home/widgets/task.dart';
import 'package:todo/models/database.dart';
import 'package:todo/models/tasklist.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Database db = Database();

  final _todoController = TextEditingController();
  List _foundtodo = [];
  @override
  Widget build(BuildContext context) {
    void removeTask(String text) {
      setState(() {
        db.todolist.removeWhere((item) => item.text == text);
      });
    }

    void addTask(String text) {
      if (text != "") {
        setState(() {
          db.todolist.add(TodoItem(text: text));
        });
        _todoController.clear();
        db.updateDatabase();
      }
    }

    @override
    void _runFilter(String enteredKeyword) {
      List results = [];
      if (enteredKeyword.isEmpty) {
        results = db.todolist;
      } else {
        results = db.todolist
            .where((item) =>
                item.text.toLowerCase().contains(enteredKeyword.toLowerCase()))
            .toList();
      }

      setState(() {
        _foundtodo = results;
      });
    }

    handleChange(TodoItem todo) {
      setState(() {
        todo.isDone = !todo.isDone;
      });
    }

    @override
    void initState() {
      db.loadData;
      print("Data inside database : ${db.todolist}");

      _foundtodo = db.todolist;
      super.initState();
    }

    final size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "to do list",
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          centerTitle: true,
          elevation: 1,
          backgroundColor: const Color.fromRGBO(47, 54, 69, 0.6),
        ),
        backgroundColor: const Color.fromRGBO(47, 54, 69, 0.6),
        body: Stack(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  SearchBox(onChange: _runFilter),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                      child: ListView.builder(
                    itemCount: _foundtodo.length,
                    itemBuilder: (context, index) => Task(
                        todo: _foundtodo[index],
                        onDelete: removeTask,
                        onTodoChange: handleChange),
                  ))
                ],
              ),
            ),
            Positioned(
                bottom: 20,
                right: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: size.width * 0.8,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(20),
                          color: Color.fromRGBO(47, 54, 69, 1)),
                      child: TextField(
                        style: const TextStyle(color: Colors.white),
                        controller: _todoController,
                        decoration: const InputDecoration(
                            disabledBorder: InputBorder.none,
                            border: InputBorder.none,
                            hintText: "enter a task",
                            hintStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    const SizedBox(width: 5),
                    FloatingActionButton(
                      onPressed: () => addTask(_todoController.text),
                      child: Icon(
                        Icons.add,
                        color: Colors.black,
                      ),
                      backgroundColor: Colors.white,
                    ),
                  ],
                ))
          ],
        ));
  }
}
