library example_router;

import 'dart:async';
import 'dart:html';
import 'package:angel_route/angel_route.dart';
import 'src/component.dart';
import 'src/injector.dart';
export 'src/component.dart';
export 'src/injector.dart';

typedef Component ComponentFactory();
typedef InjectorFunction(Injector injector);

Future renderInto(Element target, ComponentFactory componentFactory,
    RoutingResult result, Injector injector) async {
  final component = await componentFactory();
  Element $root;

  target.children
    ..clear()
    ..add($root = component.render(result, injector));

  component.afterRender($root);
}
