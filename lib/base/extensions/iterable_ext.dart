extension IterableSecond<E> on Iterable<E> {
  E get second {
    Iterator<E> it = iterator;
    if (!(it.moveNext() && it.moveNext())) {
      throw StateError("No second element");
    }
    return it.current;
  }
}
