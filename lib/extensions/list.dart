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

  List<T> withUpsert(T element, bool Function(T) test) {
    final index = indexWhere(test);
    if (index == -1) {
      // 如果没找到，返回由 [旧数据 + 新元素] 组成的新列表
      return [...this, element];
    } else {
      // 如果找到了，拷贝一份旧列表，并修改其中的元素
      final newList = List<T>.of(this);
      newList[index] = element;
      return newList;
    }
  }
}
