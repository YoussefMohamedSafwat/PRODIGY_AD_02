import 'package:hive/hive.dart';
import 'package:todo/models/tasklist.dart';

class Database {
  List <TodoItem> todolist = [];

  final _mybox = Hive.box('mybox');

  void loadData() {

    todolist = _mybox.get("Todolist");
  }

  void updateDatabase() {
    _mybox.put("Todolist", todolist);
  }
}
