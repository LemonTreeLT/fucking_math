import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fucking_math/utils/providers/phrase_proivder.dart';
import 'package:fucking_math/utils/providers/words_proivder.dart';
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
    // 在页面初始化时，主动触发数据加载
    // 使用 addPostFrameCallback 确保 Provider 已经准备好
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // 使用 listen: false 是因为我们不希望 initState 因为 Provider 的变化而重新执行
      // 我们只需要调用方法，UI 的更新会由下面的 build 方法中的 watch 来处理
      context.read<WordsProvider>().loadWords();
      context.read<PhraseProivder>().loadPhrases();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('调试页面 - 数据库浏览器'),
        actions: [
          // 添加一个刷新按钮，方便手动更新数据
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              if (kDebugMode) print(context.read<WordsProvider>().words);
              context.read<WordsProvider>().loadWords();
              context.read<PhraseProivder>().loadPhrases();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        // 使用 CustomScrollView 和 Slivers 可以更高效地展示多个可滚动区域
        child: CustomScrollView(
          slivers: [
            // --- Words 表展示区域 ---
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text('Words 表数据', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
            ),
            _buildWordsList(),

            const SliverToBoxAdapter(child: Divider(height: 32, thickness: 2)),

            // --- Phrases 表展示区域 ---
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text('Phrases 表数据', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
    // 使用 Consumer 来订阅 WordsProvider 的变化
    return Consumer<WordsProvider>(
      builder: (context, provider, child) {
        // 1. 处理加载状态
        if (provider.isLoading && provider.words.isEmpty) {
          return const SliverToBoxAdapter(child: Center(child: CircularProgressIndicator()));
        }

        // 2. 处理错误状态
        if (provider.error != null) {
          return SliverToBoxAdapter(
            child: Center(child: Text('加载 Words 失败: ${provider.error}', style: const TextStyle(color: Colors.red))),
          );
        }

        // 3. 处理列表为空的状态
        if (provider.words.isEmpty) {
          return const SliverToBoxAdapter(child: Center(child: Text('Words 表中没有数据')));
        }
        
        // 4. 成功获取数据，构建列表
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final word = provider.words[index];
              return _buildWordCard(word);
            },
            childCount: provider.words.length,
          ),
        );
      },
    );
  }

  // 构建 Phrases 列表的 Sliver
  Widget _buildPhrasesList() {
    // 使用 Consumer 来订阅 PhraseProivder 的变化
    return Consumer<PhraseProivder>(
      builder: (context, provider, child) {
        // 1. 处理加载状态
        if (provider.isLoading && provider.phrases.isEmpty) {
          return const SliverToBoxAdapter(child: Center(child: CircularProgressIndicator()));
        }

        // 2. 处理错误状态
        if (provider.error != null) {
          return SliverToBoxAdapter(
            child: Center(child: Text('加载 Phrases 失败: ${provider.error}', style: const TextStyle(color: Colors.red))),
          );
        }

        // 3. 处理列表为空的状态
        if (provider.phrases.isEmpty) {
          return const SliverToBoxAdapter(child: Center(child: Text('Phrases 表中没有数据')));
        }
        
        // 4. 成功获取数据，构建列表
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final phrase = provider.phrases[index];
              return _buildPhraseCard(phrase);
            },
            childCount: provider.phrases.length,
          ),
        );
      },
    );
  }

  // 用于展示单个 Word 信息的卡片
  Widget _buildWordCard(Word word) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${word.word} (ID: ${word.id})',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const Divider(),
            _buildInfoRow('定义 (Definition):', word.definition ?? 'N/A'),
            _buildInfoRow('预览 (Def. Preview):', word.definitionPreview ?? 'N/A'),
            _buildInfoRow('标签 (Tags):', word.tags.map((t) => '${t.name}(${t.id})').join(', ')),
          ],
        ),
      ),
    );
  }

  // 用于展示单个 Phrase 信息的卡片
  Widget _buildPhraseCard(Phrase phrase) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${phrase.phrase} (ID: ${phrase.id})',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const Divider(),
            _buildInfoRow('关联单词ID (Linked Word ID):', phrase.linkedWordID.toString()),
            _buildInfoRow('定义 (Definition):', phrase.definition ?? 'N/A'),
            _buildInfoRow('标签 (Tags):', phrase.tags.map((t) => '${t.name}(${t.id})').join(', ')),
          ],
        ),
      ),
    );
  }

  // 一个辅助 Widget，用于格式化信息行
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: RichText(
        text: TextSpan(
          style: DefaultTextStyle.of(context).style,
          children: <TextSpan>[
            TextSpan(text: '$label ', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey)),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }
}
