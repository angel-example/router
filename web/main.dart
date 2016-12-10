import 'dart:html';
import 'package:angel_route/angel_route.dart';
import 'package:angel_route/browser.dart';
import 'package:example_router/example_router.dart';
import 'components/new_todo.dart';
import 'components/not_found.dart';
import 'components/todo_detail.dart';
import 'components/todo_list.dart';
import 'todo.dart';

final DivElement container = document.getElementById('app');
final Injector injector = new Injector();
final BrowserRouter router = new BrowserRouter(hash: true);

main() {
  configureInjector(injector);
  configureRoutes(router);

  router.onResolve.listen((result) async {
    if (result == null) {
      throw404();
    } else {
      for (final handler in result.allHandlers) {
        if (handler is ComponentFactory) {
          await renderInto(container, handler, result, injector);
          break;
        } else if (handler is List &&
            handler.length >= 2 &&
            handler[1] is Type) {
          injector.singleton(handler[0], as: handler[1]);
        } else if (handler is InjectorFunction) {
          await handler(injector);
        } else {
          injector.singleton(handler);
        }
      }
    }
  });

  final oldHash = window.location.hash;
  window.location.hash = '';
  window.location.hash = oldHash;

  if (window.location.hash.isEmpty) window.location.hash = '#/';
}

void configureInjector(Injector injector) {
  injector.singleton(new TodoRepository());
}

void configureRoutes(BrowserRouter router) {
  router
    ..get('/todos', todoList)
    ..get('/todos/new', newTodo)
    ..get('/todos/:id', todoDetail)
    ..get('/', () {
      window.location.hash = '#/todos';
    });
}

void throw404() {
  renderInto(container, notFound, null, injector);
}
