extension IteratorX<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T Function(E e, int index) toElement) {
    return Iterable.generate(
      length,
      (index) => toElement(
        elementAt(index),
        index,
      ),
    );
  }
}
