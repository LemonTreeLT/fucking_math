import 'package:drift/drift.dart';
import 'package:fucking_math/db/app_database.dart';
import 'package:fucking_math/db/tables/tables_ai.dart';

part 'ai_provider.g.dart';

@DriftAccessor(tables: [AiProviders])
class AiProviderDao extends DatabaseAccessor<AppDatabase>
    with _$AiProviderDaoMixin {
  AiProviderDao(super.db);

  // 获取所有提供商
  Future<List<AiProvider>> getAllProviders() => select(aiProviders).get();

  // 获取激活的提供商
  Future<AiProvider?> getActiveProvider() => (select(
    aiProviders,
  )..where((p) => p.isActive.equals(true))).getSingleOrNull();

  // 通过 ID 获取提供商
  Future<AiProvider?> getProviderById(int id) =>
      (select(aiProviders)..where((p) => p.id.equals(id))).getSingleOrNull();

  // 通过名称获取提供商
  Future<AiProvider?> getProviderByName(String name) => (select(
    aiProviders,
  )..where((p) => p.name.equals(name))).getSingleOrNull();

  // 创建新提供商
  Future<int> createProvider(AiProvidersCompanion entry) =>
      into(aiProviders).insert(entry);

  // 更新提供商
  Future<bool> updateProvider(AiProvider provider) =>
      update(aiProviders).replace(provider);

  // 通过 companion 更新提供商
  Future<int> updateProviderWithCompanion(
    int id,
    AiProvidersCompanion companion,
  ) => (update(aiProviders)..where((p) => p.id.equals(id))).write(companion);

  // 设置提供商为激活
  Future<int> setProviderActive(int id) =>
      (update(aiProviders)..where((p) => p.id.equals(id))).write(
        const AiProvidersCompanion(isActive: Value(true)),
      );

  // 禁用提供商
  Future<int> disableProvider(int id) =>
      (update(aiProviders)..where((p) => p.id.equals(id))).write(
        const AiProvidersCompanion(isActive: Value(false)),
      );

  // 删除提供商
  Future<int> deleteProvider(int id) =>
      (delete(aiProviders)..where((p) => p.id.equals(id))).go();

  // Upsert 提供商（基于 name 的 unique 约束会用到）
  Future<int> upsertProvider(AiProvidersCompanion entry) async =>
      await into(aiProviders).insertOnConflictUpdate(entry);
}
