import 'dart:convert';
import 'dart:html';

class TodoRepository {
  final List<Todo> todos = [];

  TodoRepository() {
    load();
  }

  void load() {
    if (window.localStorage.containsKey('todos')) {
      todos.addAll(JSON
          .decode(window.localStorage['todos'])
          .map((data) => new Todo.fromMap(data)));
    }
  }

  void save() {
    window.localStorage['todos'] = JSON.encode(todos);
  }
}

class Todo {
  int id;
  String text;
  bool completed;

  Todo({this.id, this.text, this.completed: false});

  factory Todo.fromMap(Map data) {
    return new Todo(
        id: data['id'], text: data['text'], completed: data['completed']);
  }

  Map toJson() => {'id': id, 'text': text, 'completed': completed};
}
