import 'package:flutter/material.dart';
import 'package:fucking_math/utils/providers/english_proivder.dart';

import 'package:fucking_math/utils/types.dart';
import 'package:provider/provider.dart';

class Debug extends StatelessWidget {
  const Debug({super.key});
  @override
  Widget build(BuildContext context) {
    // 初始化加载数据
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WordsProvider>().loadWords();
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Repository 调试页面'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => context.read<WordsProvider>().loadWords(),
          ),
        ],
      ),
      body: Consumer<WordsProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (provider.error != null) {
            return Center(child: Text('错误: ${provider.error}'));
          }

          return Column(
            children: [
              Row(
                children: [
                  _buildAddWordButton(context),
                  _buildDeleteAllWordButton(context),
                ],
              ),

              const Divider(),
              _buildWordList(provider.words),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDeleteAllWordButton(BuildContext context) {
    final provider = context.read<WordsProvider>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () async {
          List<int> wordsIDs = provider.words
              .map((word) => word.id)
              .toList();
          for (var id in wordsIDs) {
            await provider.deleteWord(id);
          }
        },
        child: const Text('删除全部单词'),
      ),
    );
  }

  // --- 辅助方法: 添加单词按钮 ---
  Widget _buildAddWordButton(BuildContext context) {
    final provider = context.read<WordsProvider>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              // 示例：添加一个新单词
              await provider.addWord(
                'TestWord_${DateTime.now().millisecond}',
                definition: 'This is a test definition.',
                // 假设标签ID 1, 2 存在
                tags: [1, 2],
              );

              if (context.mounted){
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('尝试添加单词...')));
              }
            },
            child: const Text('添加测试单词 (带标签)'),
          ),
        ],
      ),
    );
  }

  // --- 辅助方法: 单词列表 ---
  Widget _buildWordList(List<Word> words) {
    if (words.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('词库为空，请添加单词'),
        ),
      );
    }
    return Expanded(
      child: ListView.builder(
        itemCount: words.length,
        itemBuilder: (context, index) {
          final item = words[index];

          // 将标签名拼接成字符串
          final tagNames = item.tags.map((t) => t.name).join(', ');
          return ListTile(
            title: Text('${item.word} (ID: ${item.id})'),
            subtitle: Text(item.definition ?? 'No Definition'),
            trailing: Text('Tags: [$tagNames]'),
          );
        },
      ),
    );
  }
}
