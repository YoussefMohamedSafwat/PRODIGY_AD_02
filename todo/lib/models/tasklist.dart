class TodoItem {
  String text;
  bool isDone;

  TodoItem({required this.text, this.isDone = false});
}

List<TodoItem> tasklist = [
  TodoItem(text: "eat breakfast"),
  TodoItem(text: "go to gym"),
  TodoItem(text: "Go to sleep", isDone: true),
];
