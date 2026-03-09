import 'dart:async';

import 'package:fucking_math/utils/outputs.dart';

/// 基础参数类型定义
abstract class AiType<T> {
  final String description;
  const AiType(this.description);
  Map<String, dynamic> toSchema();

  T cast(dynamic value) => value as T;
}

class AiString extends AiType<String> {
  final List<String>? enums;
  const AiString(super.description, {this.enums});
  @override
  Map<String, dynamic> toSchema() => {
    "type": "string",
    "description": description,
    if (enums != null) "enum": enums,
  };
}

class AiInt extends AiType<int> {
  const AiInt(super.description);
  @override
  Map<String, dynamic> toSchema() => {
    "type": "integer",
    "description": description,
  };
}

/// 强类型字段定义
class AiField<T> {
  final String name;
  final AiType<T> type;
  final bool isRequired;
  final T? defaultValue; // 新增：默认值

  const AiField(
    this.name,
    this.type, {
    this.isRequired = false,
    this.defaultValue,
  });
  T? getValue(Map<String, dynamic> args) {
    final rawValue = args[name];

    // 1. 如果缺失且是必填
    if (rawValue == null && isRequired) {
      debugPrint("AI 遗漏了必填参数: $name");
      return defaultValue;
    }

    // 2. 如果缺失但非必填
    if (rawValue == null) return defaultValue;

    // 3. 尝试类型转换 (利用我们之前在 AiType 里写的 cast)
    try {
      return type.cast(rawValue);
    } catch (e) {
      debugPrint("参数 $name 类型不匹配，尝试转换失败: $e");
      return defaultValue;
    }
  }
}

/// AI 工具基类
abstract class BaseAiTool {
  String get name;
  String get description;
  List<AiField> get fields;

  Map<String, dynamic> toJsonDefinition() => {
    "type": "function",
    "function": {
      "name": name,
      "description": description,
      "parameters": {
        "type": "object",
        "properties": {for (var f in fields) f.name: f.type.toSchema()},
        "required": fields
            .where((f) => f.isRequired)
            .map((f) => f.name)
            .toList(),
      },
    },
  };

  /// Usage: 解析参数
  ///        AiField arg1Field = AiField();
  ///        final arg1 = AiField.getValue(args);
  Future<String> call(Map<String, dynamic> args);
}
