import 'dart:html';
import '../todo.dart';

Element renderTodo(Todo todo) {
  return new Element.html(
      '''<a class="todo-item ${todo.completed ? 'complete' : 'incomplete'}"
          href="#/todos/${todo.id}">${todo.text}</a>''');
}
