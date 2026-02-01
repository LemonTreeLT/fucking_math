import 'package:flutter/foundation.dart';

abstract class BaseProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _error;

  bool get isLoading => _isLoading;
  String? get error => _error;

  @protected
  void onLoading() => _isLoading = true;
  @protected
  void onStopLoading() => _isLoading = false;
  @protected
  void clearError() => _error = null;
  @protected
  void setError(String errMsg) => _error = errMsg;
}

abstract class BaseRepositoryProvider<T, R> extends BaseProvider
    with ProviderActionNotifier {
  @protected
  List<T> items = [];
  @protected
  void setItems(List<T> newitems) => items = newitems;
  @protected
  R rep;
  BaseRepositoryProvider(this.rep);

  List<T> get getItems => items;
}

mixin ProviderActionNotifier on BaseProvider {

  /// 私有辅助方法：执行操作、处理状态、通知监听器
  /// 封装了 try-catch-finally 逻辑，并返回操作结果 T 或 null
  Future<T?> _runActionAndNotify<T>({
    required Future<T> Function() action,
    void Function(T result)? onSuccess,
    String? errMsg,
  }) async {
    onLoading();
    clearError();
    notifyListeners();

    try {
      final result = await action();
      onSuccess?.call(result);
      return result; // 成功时返回结果
    } catch (e) {
      setError("${errMsg ?? "操作失败"}: $e");
      if (kDebugMode) print('$e, msg: $errMsg, class: $T');
      return null; // 失败时返回 null
    } finally {
      onStopLoading();
      notifyListeners();
    }
  }

  @protected
  Future<void> justDoIt<T>({
    required Future<T> Function() action,
    void Function(T result)? onSucces,
    String? errMsg,
  }) async {
    // 调用辅助方法，忽略其返回值 (Future<void>)
    await _runActionAndNotify<T>(
      action: action,
      onSuccess: onSucces,
      errMsg: errMsg,
    );
  }

  @protected
  Future<T?> justDoItNext<T>({
    required Future<T> Function() action,
    void Function(T result)? onSucces,
    String? errMsg,
  }) async {
    // 直接返回辅助方法的结果 (Future<T?>)
    return _runActionAndNotify<T>(
      action: action,
      onSuccess: onSucces,
      errMsg: errMsg,
    );
  }
}
