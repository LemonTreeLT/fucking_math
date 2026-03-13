import 'package:flutter/foundation.dart';
import 'package:fucking_math/ai/repository/ai_provider_repository.dart';
import 'package:fucking_math/db/app_database.dart';

/// AI 配置管理器
/// 负责管理激活的 AI 提供商配置，作为全局单例供应用使用
class AiConfig extends ChangeNotifier {
  final AiProviderRepository _repository;
  AiProvider? _activeProvider;

  AiConfig(this._repository);

  /// 获取当前激活的 AI 提供商
  AiProvider? get activeProvider => _activeProvider;

  /// 是否已配置 AI 提供商
  bool get isConfigured => _activeProvider != null;

  /// 获取 API 密钥
  String? get apiKey => _activeProvider?.apiKey;

  /// 获取 API 基础 URL
  String? get baseUrl => _activeProvider?.baseUrl;

  /// 获取提供商名称
  String? get name => _activeProvider?.name;

  /// 获取所有可用的 AI 提供商
  Future<List<AiProvider>> getAllProviders() => _repository.getAllProviders();

  Future<void> loadActionProvider() async =>
      _activeProvider = await _repository.getActiveProvider();

  /// 切换激活的 AI 提供商
  Future<void> switchProvider(int id) async {
    await _repository.setProviderActive(id);
    _activeProvider = await _repository.getProviderById(id);
    notifyListeners();
  }

  /// 创建新的 AI 提供商配置
  Future<int> createProvider({
    required String name,
    required String baseUrl,
    required String apiKey,
    String? description,
    int? iconId,
  }) => _repository.createProvider(
    name: name,
    baseUrl: baseUrl,
    apiKey: apiKey,
    description: description,
    iconId: iconId,
  );

  /// 更新现有 AI 提供商配置
  Future<bool> updateProvider(AiProvider provider) async {
    final result = await _repository.updateProvider(provider);
    // 如果更新的是激活提供商，更新缓存
    if (_activeProvider?.id == provider.id) {
      _activeProvider = provider;
      notifyListeners();
    }
    return result;
  }

  /// 删除 AI 提供商配置
  Future<int> deleteProvider(int id) async {
    final result = await _repository.deleteProvider(id);
    // 如果删除的是激活提供商，清空缓存
    if (_activeProvider?.id == id) {
      _activeProvider = null;
      notifyListeners();
    }
    return result;
  }
}
