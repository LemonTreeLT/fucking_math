import 'package:flutter/material.dart';
import 'package:fucking_math/db/app_database.dart' show AiProvider;
import 'package:fucking_math/providers/ai_provider.dart';
import 'package:fucking_math/ai/config/ai_config.dart';
import 'package:fucking_math/widget/common/backgrounds.dart';
import 'package:fucking_math/widget/ui_constants.dart';
import 'package:provider/provider.dart';
import '_ai_provider_form.dart';

class AiProviderManager extends StatefulWidget {
  const AiProviderManager({super.key});

  @override
  State<AiProviderManager> createState() => _AiProviderManagerState();
}

class _AiProviderManagerState extends State<AiProviderManager> {
  bool _isCreatingNew = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AiProviderProvider>().loadProviders();
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text("AI 提供商管理")),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(flex: 1, child: _buildProvidersListArea()),
          boxW16,
          Expanded(flex: 1, child: _buildDetailedScreen()),
        ],
      ),
    ),
  );

  Widget _buildProvidersListArea() => BorderedContainerWithTopText(
    labelText: "提供商列表",
    child: Column(
      children: [
        Expanded(
          child: Consumer<AiProviderProvider>(
            builder: (context, provider, _) {
              if (provider.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (provider.getItems.isEmpty) {
                return Center(
                  child: Text(
                    "暂无提供商，点击下方按钮添加",
                    style: TextStyle(color: Colors.grey),
                  ),
                );
              }
              return ListView.separated(
                itemCount: provider.getItems.length,
                separatorBuilder: (_, _) => const Divider(),
                itemBuilder: (context, index) =>
                    _buildProviderListItem(provider.getItems[index]),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        _buildAddButton(),
      ],
    ),
  );

  Widget _buildProviderListItem(AiProvider provider) {
    final aiConfig = context.read<AiConfig>();
    final isActive = aiConfig.activeProvider?.id == provider.id;

    return Consumer<AiProviderProvider>(
      builder: (context, providerNotifier, _) => InkWell(
        onTap: () {
          providerNotifier.select(provider);
          setState(() => _isCreatingNew = false);
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      provider.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (provider.description?.isNotEmpty ?? false) ...[
                      const SizedBox(height: 4),
                      Text(
                        provider.description!,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
              if (isActive)
                const Icon(Icons.check_circle, color: Colors.green, size: 20),
              if (!isActive)
                InkWell(
                  onTap: () => context.read<AiProviderProvider>().switchActiveProvider(provider.id),
                  child: Icon(
                    Icons.radio_button_unchecked,
                    color: Colors.grey.shade400,
                    size: 20,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddButton() => SizedBox(
    width: double.infinity,
    child: ElevatedButton.icon(
      onPressed: () => setState(() {
        context.read<AiProviderProvider>().select(null);
        _isCreatingNew = true;
      }),
      icon: const Icon(Icons.add),
      label: const Text("添加新提供商"),
    ),
  );

  Widget _buildDetailedScreen() {
    final provider = context.watch<AiProviderProvider>();

    if (provider.error != null) {
      return BorderedContainerWithTopText(
        labelText: "错误",
        child: Center(child: Text(provider.error!)),
      );
    }

    if (_isCreatingNew) {
      return AiProviderForm(
        key: const ValueKey('new'),
        provider: null,
        onCreated: () => setState(() => _isCreatingNew = false),
      );
    }

    if (provider.selectedItem == null) {
      return BorderedContainerWithTopText(
        labelText: "详情与编辑",
        child: Center(
          child: Text(
            "点击左侧提供商查看详情，或点击\"添加新提供商\"创建新配置",
            style: TextStyle(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return AiProviderForm(
      key: ValueKey(provider.selectedItem!.id),
      provider: provider.selectedItem!,
      onCreated: null,
    );
  }
}
