import 'dart:html';
import 'package:angel_route/src/router.dart';
import 'package:example_router/example_router.dart';
import '../todo.dart';
import 'todo_item.dart';

Component todoList() => new TodoListComponent();

class TodoListComponent extends Component {
  TodoRepository _todos;

  @override
  Element render(RoutingResult result, Injector injected) {
    document.title = 'Todos';

    _todos = injected.get(TodoRepository);
    final root = new Element.html('''<div class="content todo-list">
            <h1>Todos (${_todos.todos.length})</h1>
            <br>
            <a href="#/todos/new">Add</a>
            <br>
            <ul></ul>
            <br>
          </div>''');
    return root;
  }

  @override
  void afterRender(Element $root) {
    final UListElement $ul = $root.querySelector('ul');
    $ul.children.addAll(_todos.todos.map(renderTodo));
  }
}
