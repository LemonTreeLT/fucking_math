extension ListUpdateOrAdd<T> on List<T> {
  // 当这个元素满足 `test` 要求时，更新这个元素
  // 否则添加这个元素
  void upsert(T element, bool Function(T) test) {
    final index = indexWhere(test);
    if (index == -1) {
      add(element);
    } else {
      this[index] = element;
    }
  }
}
