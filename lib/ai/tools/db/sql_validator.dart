enum RiskLevel { low, medium, high }

class SqlValidationResult {
  final bool isAllowed;
  final RiskLevel riskLevel;
  final List<String> warnings;
  final String summary;

  const SqlValidationResult({
    required this.isAllowed,
    required this.riskLevel,
    required this.warnings,
    required this.summary,
  });
}

class SqlValidator {
  static const _sensititiveTables = ['ai_histories', 'ai_providers', 'session'];
  static const _blockedFirstWords = {
    'drop', 'truncate', 'alter', 'create', 'attach', 'detach', 'pragma',
  };

  static SqlValidationResult validate(String sql) {
    final trimmed = sql.trim();

    // 拒绝多条语句
    final parts = trimmed.split(';');
    if (parts.length > 1 && parts.skip(1).any((s) => s.trim().isNotEmpty)) {
      return const SqlValidationResult(
        isAllowed: false,
        riskLevel: RiskLevel.high,
        warnings: [],
        summary: '不允许执行多条语句',
      );
    }

    final firstWord = trimmed.split(RegExp(r'\s+'))[0].toLowerCase();

    if (_blockedFirstWords.contains(firstWord)) {
      return SqlValidationResult(
        isAllowed: false,
        riskLevel: RiskLevel.high,
        warnings: [],
        summary: '不允许执行 ${firstWord.toUpperCase()} 语句',
      );
    }

    if (!{'insert', 'update', 'delete'}.contains(firstWord)) {
      return SqlValidationResult(
        isAllowed: false,
        riskLevel: RiskLevel.high,
        warnings: [],
        summary: '只允许执行 INSERT / UPDATE / DELETE 语句，当前首词：$firstWord',
      );
    }

    final warnings = <String>[];
    var riskLevel = RiskLevel.low;

    final upperSql = trimmed.toUpperCase();
    final hasWhere = RegExp(r'\bWHERE\b', caseSensitive: false).hasMatch(trimmed);

    if (firstWord == 'update' && !hasWhere) {
      warnings.add('UPDATE 语句缺少 WHERE 子句，将更新所有行');
      riskLevel = RiskLevel.high;
    }
    if (firstWord == 'delete' && !hasWhere) {
      warnings.add('DELETE 语句缺少 WHERE 子句，将删除所有行');
      riskLevel = RiskLevel.high;
    }

    for (final table in _sensititiveTables) {
      if (upperSql.contains(table.toUpperCase())) {
        warnings.add('操作涉及敏感表：$table');
        if (riskLevel == RiskLevel.low) riskLevel = RiskLevel.medium;
      }
    }

    final summary = switch (riskLevel) {
      RiskLevel.low => '低风险 ${firstWord.toUpperCase()} 操作',
      RiskLevel.medium => '中风险操作，请注意影响范围',
      RiskLevel.high => '高风险操作，请仔细确认',
    };

    return SqlValidationResult(
      isAllowed: true,
      riskLevel: riskLevel,
      warnings: warnings,
      summary: summary,
    );
  }
}
