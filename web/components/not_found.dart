import 'dart:html';
import 'package:angel_route/angel_route.dart';
import 'package:example_router/example_router.dart';

Component notFound() => new NotFoundComponent();

class NotFoundComponent extends Component {
  @override
  Element render(RoutingResult result, Injector injected) {
    document.title = '404 Not Found';

    return new Element.html('''
    <div class="content">
      <h1>404 Not Found</h1>
    </div>
    ''');
  }
}