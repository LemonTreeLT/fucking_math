import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:fucking_math/db/daos/ai_provider.dart';
import 'package:fucking_math/db/app_database.dart';

/// AI 提供商管理仓库层
/// 负责从数据库读取和管理 AI 提供商配置
class AiProviderRepository {
  final AiProviderDao _dao;

  AiProviderRepository(this._dao);

  /// 获取激活的 AI 提供商
  Future<AiProvider?> getActiveProvider() => _dao.getActiveProvider();

  /// 获取所有 AI 提供商
  Future<List<AiProvider>> getAllProviders() => _dao.getAllProviders();

  /// 通过 ID 获取提供商
  Future<AiProvider?> getProviderById(int id) => _dao.getProviderById(id);

  /// 通过名称获取提供商
  Future<AiProvider?> getProviderByName(String name) =>
      _dao.getProviderByName(name);

  /// 创建新提供商
  Future<int> createProvider({
    required String name,
    required String baseUrl,
    required String apiKey,
    String? description,
    int? iconId,
  }) =>
      _dao.createProvider(
        AiProvidersCompanion.insert(
          name: name,
          baseUrl: baseUrl,
          apiKey: apiKey,
          description: description != null ? Value(description) : const Value(null),
          iconId: iconId != null ? Value(iconId) : const Value(null),
          isActive: const Value(true),
        ),
      );

  /// 更新提供商
  Future<bool> updateProvider(AiProvider provider) =>
      _dao.updateProvider(provider);

  /// 设置提供商为激活（同时禁用其他提供商）
  Future<int> setProviderActive(int id) async {
    // 首先禁用所有提供商
    await _dao.disableAllProviders();
    // 然后激活指定提供商
    return _dao.setProviderActive(id);
  }

  /// 禁用提供商
  Future<int> disableProvider(int id) => _dao.disableProvider(id);

  /// 删除提供商
  Future<int> deleteProvider(int id) => _dao.deleteProvider(id);

  /// Upsert 提供商（基于 name 的 unique 约束）
  Future<int> upsertProvider({
    required String name,
    required String baseUrl,
    required String apiKey,
    String? description,
    int? iconId,
  }) =>
      _dao.upsertProvider(
        AiProvidersCompanion.insert(
          name: name,
          baseUrl: baseUrl,
          apiKey: apiKey,
          description: description != null ? Value(description) : const Value(null),
          iconId: iconId != null ? Value(iconId) : const Value(null),
          isActive: const Value(true),
        ),
      );

  /// 更新模型列表
  Future<int> updateModels(int providerId, List<String> models) {
    final jsonStr = jsonEncode(models);
    return _dao.updateProviderWithCompanion(
      providerId,
      AiProvidersCompanion(modelsJson: Value(jsonStr)),
    );
  }

  /// 解析模型列表 JSON
  static List<String> parseModels(String json) {
    try {
      final decoded = jsonDecode(json);
      if (decoded is List) {
        return decoded.cast<String>();
      }
      return [];
    } catch (_) {
      return [];
    }
  }
}
