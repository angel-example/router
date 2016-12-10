import 'dart:html';
import 'package:angel_route/angel_route.dart';
import 'injector.dart';

// Angular2 much?
abstract class Component {
  Element render(RoutingResult result, Injector injected);

  void afterRender(Element $root) {}
}
