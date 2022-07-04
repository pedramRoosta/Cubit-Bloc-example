extension Subscript<T> on Iterable<T> {
  T? operator [](int index) => length > index ? elementAt(index) : null;
}

extension isEqualIgnoring<T> on Iterable<T> {
  bool isEqualIgnoringOrder(Iterable<T> other) =>
      length == other.length &&
      {...this}.intersection({...other}).length == length;
}
