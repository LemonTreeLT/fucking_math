extension StringExtensions on String {
  /// 如果字符串在 trim() 后为空，则返回 null，否则返回 trim() 后的字符串。
  String? get nullIfEmpty {
    final trimmed = trim();
    return trimmed.isEmpty ? null : trimmed;
  }
}