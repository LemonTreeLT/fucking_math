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
  @protected
  Future<void> justDoIt<T>({
    required Future<T> Function() action,
    void Function(T result)? onSucces,
    String? errMsg,
  }) async {
    onLoading();
    clearError();
    notifyListeners();

    try {
      final result = await action();
      onSucces?.call(result);
    } catch (e) {
      setError("${errMsg ?? "操作失败"}: $e");
      if (kDebugMode) print('$e, msg: $errMsg, class: $T');
    } finally {
      onStopLoading();
      notifyListeners();
    }
  }
}
