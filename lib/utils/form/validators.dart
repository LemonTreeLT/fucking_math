class FormValidators {
  // 非空验证
  static String? notEmpty(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName不能为空';
    }
    return null;
  }

  static String? singleWord(String? value) {
    final emptyError = notEmpty(value, '单词');
    if (emptyError != null) return emptyError;
    
    if (value!.contains(' ')) {
      return '单词不应该包含空格';
    }
    return null;
  }

  static String? phrase(String? value) {
    return notEmpty(value, '短语');
  }
}
