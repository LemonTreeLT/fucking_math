import 'package:drift/drift.dart';
import 'package:fucking_math/ai/types.dart';
import 'package:fucking_math/db/tables/tables_images.dart';

/// AI 提供商配置表
class AiProviders extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()(); // 提供商名称（OpenAI, Gemini, etc）
  TextColumn get description => text().nullable()(); // 提供商描述
  TextColumn get baseUrl => text()(); // API 基础 URL
  TextColumn get apiKey => text()(); // API 密钥
  IntColumn get iconId =>
      integer().nullable().references(Images, #id)(); // Icon 图片 ID
  BoolColumn get isActive =>
      boolean().withDefault(const Constant(true))(); // 是否激活
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)(); // 创建时间
  TextColumn get modelsJson =>
      text().withDefault(const Constant('[]'))(); // 支持的模型列表 (JSON 数组)
}

/// 对话历史表
class AiHistories extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// 该字段不为空是表示这是对id为sourceId的记录的覆写
  IntColumn get sourceId => integer().references(AiHistories, #id).nullable()();

  IntColumn get providerId =>
      integer().references(AiProviders, #id)(); // 关联的提供商

  TextColumn get role => text().map(EnumNameConverter(Roles.values))();

  IntColumn get sessionId => integer().references(Session, #id)();

  TextColumn get content => text()(); // 消息内容, 包含工具调用json

  // 3. 多工具调用支持：
  // - 当 role 为 assistant 时，这里存模型生成的多个工具调用 JSON 数组。
  TextColumn get toolCalls => text().nullable()();

  // 4. 工具结果关联：
  // - 当 role 为 tool 时，必须提供这个 ID，告诉模型这是对哪个 tool_call 的回应。
  TextColumn get toolCallId => text().nullable()();

  IntColumn get tokens => integer().nullable()(); // Token 使用量
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class Session extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text().nullable()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class Prompts extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().nullable()();
  TextColumn get desc => text().nullable()();

  /// 使用{{key}}添加可被替换内容
  TextColumn get content => text()();
}

class AiHistoryImagesLink extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get historyId => integer().references(AiHistories, #id)();
  IntColumn get imageId => integer().references(Images, #id)();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
