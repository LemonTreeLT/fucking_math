import 'package:drift/drift.dart';
import 'package:fucking_math/db/app_database.dart';
import 'package:fucking_math/db/tables/tables_ai.dart';

part 'ai_prompt.g.dart';

@DriftAccessor(tables: [Prompts])
class PromptDao extends DatabaseAccessor<AppDatabase> with _$PromptDaoMixin {
  PromptDao(super.db);

  /// 创建新 Prompt
  Future<int> createPrompt(PromptsCompanion prompt) =>
      into(prompts).insert(prompt);

  /// 按 ID 获取 Prompt
  Future<Prompt?> getPromptById(int id) =>
      (select(prompts)..where((p) => p.id.equals(id))).getSingleOrNull();

  /// 按名称查询 Prompt
  Future<Prompt?> getPromptByName(String name) =>
      (select(prompts)..where((p) => p.name.equals(name))).getSingleOrNull();

  /// 获取全部 Prompt
  Future<List<Prompt>> getAllPrompts() =>
      (select(prompts)..orderBy([(p) => OrderingTerm.asc(p.name)]))
          .get();

  /// 更新 Prompt
  Future<int> updatePrompt(PromptsCompanion prompt, int id) =>
      (update(prompts)..where((p) => p.id.equals(id))).write(prompt);

  /// 删除 Prompt
  Future<int> deletePrompt(int id) =>
      (delete(prompts)..where((p) => p.id.equals(id))).go();

  /// 模糊搜索 Prompt（按 name 或 desc）
  Future<List<Prompt>> searchPrompts(String query) async {
    final searchTerm = '%$query%';
    return (select(prompts)
          ..where((p) =>
              p.name.like(searchTerm) | p.desc.like(searchTerm))
          ..orderBy([(p) => OrderingTerm.asc(p.name)]))
        .get();
  }
}
