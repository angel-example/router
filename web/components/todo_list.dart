import 'dart:html';
import 'package:angel_route/src/router.dart';
import 'package:example_router/example_router.dart';
import '../todo.dart';
import 'todo_item.dart';

Component todoList() => new TodoListComponent();

class TodoListComponent extends Component {
  @override
  Element render(RoutingResult result, Injector injected) {
    document.title = 'Todos';

    final TodoRepository repo = injected.get(TodoRepository);
    final root = new Element.html(
        '''<div class="content todo-list">
            <h1>Todos (${repo.todos.length})</h1>
            <br>
            <a href="#/todos/new">Add</a>
            <br>
            <br>
          </div>''');
    return root..children.addAll(repo.todos.map(renderTodo));
  }
}
