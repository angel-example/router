class Injector {
  final Map<Type, dynamic> _table = {};

  dynamic get(Type type) => _table[type];

  void singleton(value, {Type as}) {
    _table[as ?? value.runtimeType] = value;
  }
}