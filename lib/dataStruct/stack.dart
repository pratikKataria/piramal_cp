
class StackSetDSA<E> {
  final _list = <E>[];

  void push(E value) {
    if (!_list.contains(value)){
      _list.add(value);
    }
  }

  E pop() => _list.removeLast();

  E get peek => _list.last;

   popAll() => _list.clear();


  bool get isEmpty => _list.isEmpty;
  bool get isNotEmpty => _list.isNotEmpty;

  @override
  String toString() => _list.toString();
}