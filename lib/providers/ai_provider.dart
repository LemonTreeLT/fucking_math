// AI 提供商管理 Provider

import 'package:fucking_math/db/app_database.dart' show AppDatabase, AiProvider;
import 'package:fucking_math/ai/repository/ai_provider_repository.dart';
import 'package:fucking_math/providers/base_db_provider.dart';
import 'package:fucking_math/ai/config/ai_config.dart';
import 'package:get_it/get_it.dart';

/// AI 提供商管理 Provider
///
/// 提供 AI 提供商的增删改查功能，维护提供商列表的本地状态。
/// 支持激活状态管理和与全局 AiConfig 的同步。
class AiProviderProvider extends BaseRepositoryProvider<AiProvider, AiProviderRepository>
    with SingleObjectSelectMixin<AiProvider> {
  AiProviderProvider(AppDatabase db)
      : super(AiProviderRepository(db.aiProviderDao));

  /// 加载所有 AI 提供商
  Future<void> loadProviders() async => justDoIt<List<AiProvider>>(
    action: () => rep.getAllProviders(),
    onSuccess: setItems,
    errMsg: "加载 AI 提供商失败",
  );

  /// 创建新 AI 提供商
  Future<void> createProvider({
    required String name,
    required String baseUrl,
    required String apiKey,
    String? description,
  }) async => justDoIt<int>(
    action: () => rep.createProvider(
      name: name,
      baseUrl: baseUrl,
      apiKey: apiKey,
      description: description,
    ),
    onSuccess: (_) => loadProviders(),
    errMsg: "创建 AI 提供商失败",
  );

  /// 更新 AI 提供商
  Future<void> updateProvider(AiProvider provider) async => justDoIt<bool>(
    action: () => rep.updateProvider(provider),
    onSuccess: (_) async {
      // 如果更新的是激活提供商，同步到 AiConfig
      final aiConfig = GetIt.I<AiConfig>();
      if (aiConfig.activeProvider?.id == provider.id) {
        await aiConfig.updateProvider(provider);
      }
      await loadProviders();
    },
    errMsg: "更新 AI 提供商失败",
  );

  /// 删除 AI 提供商
  Future<void> deleteProvider(int id) async => justDoIt<int>(
    action: () => rep.deleteProvider(id),
    onSuccess: (_) async {
      select(null); // 清除选中项
      await loadProviders();
    },
    errMsg: "删除 AI 提供商失败",
  );

  /// 切换激活的 AI 提供商
  Future<void> switchActiveProvider(int id) async => justDoIt<void>(
    action: () => GetIt.I<AiConfig>().switchProvider(id),
    onSuccess: (_) => loadProviders(),
    errMsg: "切换 AI 提供商失败",
  );
}
