import 'dart:html';
import '../todo.dart';

Element renderTodo(Todo todo) {
  return new Element.html(
      '''<li class="todo-item ${todo.completed ? 'complete' : 'incomplete'}">
          <a href="#/todos/${todo.id}">${todo.text}</a>
        </li>''');
}
