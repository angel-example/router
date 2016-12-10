import 'dart:html';
import 'package:angel_route/angel_route.dart';
import 'package:example_router/example_router.dart';
import '../todo.dart';
import 'not_found.dart';

Component todoDetail() => new TodoDetailComponent();

class TodoDetailComponent extends Component {
  int _id;
  TodoRepository _todos;
  Injector _injected;
  RoutingResult _result;

  @override
  Element render(RoutingResult result, Injector injected) {
    _injected = injected;
    _result = result;
    _todos = injected.get(TodoRepository);

    try {
      return renderById(_id = int.parse(result.allParams['id']));
    } catch (e) {
      // Int parse exception
      return notFound().render(result, injected);
    }
  }

  Element renderById(int id) {
    final todo =
        _todos.todos.firstWhere((todo) => todo.id == id, orElse: () => null);

    if (todo == null) {
      return notFound().render(null, null);
    }

    return new Element.html('''
    <div class="content todo-detail">
      <h1>${todo.text}</h1>
      <input type="checkbox" ${todo.completed ? 'checked' : ''} />
      Todo is complete
      <br><br>
      <button class="save" type="button">Save</button>
      <br>
      <button class="delete" type="button">Delete</button>
    </div>''');
  }

  @override
  void afterRender(Element $root) {
    if ($root.classes.contains('todo-detail')) {
      final ButtonElement $delete = $root.querySelector('button.delete');
      final ButtonElement $save = $root.querySelector('button.save');
      final CheckboxInputElement $checkbox = $root.querySelector('input');

      $delete.onClick.listen((_) {
        if (window.confirm(
            'Are you sure you want to delete this todo? This action cannot be undone.')) {
          _todos.todos.removeWhere((todo) => todo.id == _id);
          _todos.save();
          window.location.hash = '#/todos';
        }
      });

      $save.onClick.listen((_) {
        final todo = _todos.todos
            .firstWhere((todo) => todo.id == _id, orElse: () => null);
        todo?.completed = $checkbox.checked;
        _todos.save();
        window.location.hash = '#/todos';
      });
    }
  }
}
