import 'package:flutter/material.dart';
import 'package:fucking_math/providers/phrase_proivder.dart';
import 'package:fucking_math/providers/words_proivder.dart';
import 'package:fucking_math/utils/types.dart';
import 'package:provider/provider.dart';

class Debug extends StatefulWidget {
  const Debug({super.key});

  @override
  State<Debug> createState() => _DebugState();
}

class _DebugState extends State<Debug> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // 保持原有的高效加载逻辑
      context.read<WordsProvider>().loadWords();
      context.read<PhraseProivder>().loadPhrases();
    });
  }

  @override
  Widget build(BuildContext context) {
    // 从 Theme 获取颜色和文本样式，作为后面所有组件的基础
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        // AppBar 的颜色和样式会自动跟随主题，无需额外设置
        title: const Text('调试页面 - 数据库浏览器'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<WordsProvider>().loadWords();
              context.read<PhraseProivder>().loadPhrases();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0), // 调整左右 padding
        child: CustomScrollView(
          slivers: [
            // --- Words 表展示区域 ---
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
                child: Text(
                  'Words 表数据',
                  // 使用 theme 中预定义的标题样式
                  style: textTheme.headlineSmall,
                ),
              ),
            ),
            _buildWordsList(),

            const SliverToBoxAdapter(
              // 使用主题颜色来绘制分隔线，并增加左右间距
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Divider(height: 1),
              ),
            ),

            // --- Phrases 表展示区域 ---
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Phrases 表数据',
                  style: textTheme.headlineSmall,
                ),
              ),
            ),
            _buildPhrasesList(),
          ],
        ),
      ),
    );
  }

  // 构建 Words 列表的 Sliver
  Widget _buildWordsList() {
    return Consumer<WordsProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading && provider.words.isEmpty) {
          return const SliverToBoxAdapter(
              child: Center(child: CircularProgressIndicator()));
        }
        if (provider.error != null) {
          // 错误文本使用主题的 error color
          return SliverToBoxAdapter(
            child: Center(
              child: Text(
                '加载 Words 失败: ${provider.error}',
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ),
          );
        }
        if (provider.words.isEmpty) {
          return const SliverToBoxAdapter(
              child: Center(child: Text('Words 表中没有数据')));
        }
        return SliverList.builder(
          itemCount: provider.words.length,
          itemBuilder: (context, index) {
            final word = provider.words[index];
            return _buildWordCard(context, word); // 传递 context
          },
        );
      },
    );
  }

  // 构建 Phrases 列表的 Sliver
  Widget _buildPhrasesList() {
    return Consumer<PhraseProivder>(
      builder: (context, provider, child) {
        if (provider.isLoading && provider.phrases.isEmpty) {
          return const SliverToBoxAdapter(
              child: Center(child: CircularProgressIndicator()));
        }
        if (provider.error != null) {
          return SliverToBoxAdapter(
            child: Center(
              child: Text(
                '加载 Phrases 失败: ${provider.error}',
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ),
          );
        }
        if (provider.phrases.isEmpty) {
          return const SliverToBoxAdapter(
              child: Center(child: Text('Phrases 表中没有数据')));
        }
        return SliverList.builder(
          itemCount: provider.phrases.length,
          itemBuilder: (context, index) {
            final phrase = provider.phrases[index];
            return _buildPhraseCard(context, phrase); // 传递 context
          },
        );
      },
    );
  }

  // 用于展示单个 Word 信息的卡片
  Widget _buildWordCard(BuildContext context, Word word) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      // Card 的颜色和阴影会自动跟随主题
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${word.word} (ID: ${word.id})',
              style: textTheme.titleMedium, // 使用主题的 title 样式
            ),
            const Divider(height: 16),
            _buildInfoRow(
                context, '定义 (Definition):', word.definition ?? 'N/A'),
            _buildInfoRow(
                context, '预览 (Def. Preview):', word.definitionPreview ?? 'N/A'),
            _buildInfoRow(
                context, '标签 (Tags):', word.tags.map((t) => '${t.name}(${t.id})').join(', ').ifEmpty('N/A')),
          ],
        ),
      ),
    );
  }

  // 用于展示单个 Phrase 信息的卡片
  Widget _buildPhraseCard(BuildContext context, Phrase phrase) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${phrase.phrase} (ID: ${phrase.id})',
              style: textTheme.titleMedium,
            ),
            const Divider(height: 16),
            _buildInfoRow(
                context, '关联单词ID (Linked Word ID):', phrase.linkedWordID.toString()),
            _buildInfoRow(
                context, '定义 (Definition):', phrase.definition ?? 'N/A'),
            _buildInfoRow(
                context, '标签 (Tags):', phrase.tags.map((t) => '${t.name}(${t.id})').join(', ').ifEmpty('N/A')),
          ],
        ),
      ),
    );
  }

  // 一个辅助 Widget，用于格式化信息行
  Widget _buildInfoRow(BuildContext context, String label, String value) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text.rich( // 使用 Text.rich 替代 RichText，更简洁
        TextSpan(
          // 基础样式使用 bodyMedium，这是正文的标准样式
          style: textTheme.bodyMedium,
          children: <TextSpan>[
            TextSpan(
              text: '$label ',
              // 标签使用 secondary color，比主色调柔和，适合做辅助文本
              style: TextStyle(
                color: theme.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }
}

// 一个小的扩展方法，让代码更干净
extension StringIfEmpty on String {
  String ifEmpty(String replacement) {
    return isEmpty ? replacement : this;
  }
}

