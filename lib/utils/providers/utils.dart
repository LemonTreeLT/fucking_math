  // 没有后顾之忧的调用你的方法吧

Future<void> justDoIt<T>(
    Future<T> Function() action, {
    String? errMsg,
    void Function()? onLoading,
    void Function()? onStopLoading,
    void Function()? clearError,
    void Function(String errMsg)? setError,
    void Function()? notifyListeners,
    void Function(T result)? onSuccess,
  }) async {
    onLoading?.call();
    clearError?.call();
    notifyListeners?.call();

    try {
      final result = await action();
      onSuccess?.call(result);
    } catch (e) {
      setError?.call("${errMsg ?? "操作失败"}: $e");
    } finally {
      onStopLoading?.call();
      notifyListeners?.call();
    }
  }