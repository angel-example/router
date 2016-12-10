import 'dart:html';
import 'package:angel_route/angel_route.dart';
import 'package:example_router/example_router.dart';
import '../todo.dart';

Component newTodo() => new NewTodoComponent();

class NewTodoComponent extends Component {
  TodoRepository _todos;

  @override
  Element render(RoutingResult result, Injector injected) {
    _todos = injected.get(TodoRepository);

    return new Element.html('''
    <div class="content">
      <h1>New Todo</h1>
      <br>
      <form>
        <input name="text" type="text" placeholder="Todo Text">
        <br><br>
        <input name="completed" type="checkbox">
        Todo is complete
        <br><br>
        <input type="submit" value="OK">
      </form>
    </div>
    ''');
  }

  @override
  void afterRender(Element $root) {
    final FormElement $form = $root.querySelector('form');
    final TextInputElement $text = $form.querySelector('input[type="text"]');
    final CheckboxInputElement $checkbox =
        $form.querySelector('input[type="checkbox"]');

    $form.onSubmit.listen((e) {
      e.preventDefault();

      if ($text.value.isEmpty) {
        window.alert('Todo text is required.');
        return;
      }

      final todo = new Todo(text: $text.value, completed: $checkbox.checked);
      _todos.todos.add(todo..id = _todos.todos.length);
      _todos.save();
      window.location.hash = '#/todos';
    });
  }
}
