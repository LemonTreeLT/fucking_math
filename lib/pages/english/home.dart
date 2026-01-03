import 'package:flutter/material.dart';
import 'package:fucking_math/providers/phrase_proivder.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:fucking_math/providers/words_proivder.dart';

class EnglishShell extends StatefulWidget {
  const EnglishShell({super.key, required this.child});

  final Widget child;

  @override
  State<EnglishShell> createState() => _EnglishShellState();
}

class _EnglishShellState extends State<EnglishShell> {
  String? _lastError;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    
    // 监听错误状态并自动显示 SnackBar
    final provider = context.watch<WordsProvider>();
    if (provider.error != null && provider.error != _lastError) {
      _lastError = provider.error;
      
      // 在下一帧显示 SnackBar，避免在 build 期间调用
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(provider.error!),
              backgroundColor: Colors.red,
              action: SnackBarAction(
                label: '关闭',
                textColor: Colors.white,
                onPressed: () {},
              ),
            ),
          );
        }
      });
    } else if (provider.error == null) {
      _lastError = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: widget.child,
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text("English Learning"),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(4.0),
        child: Consumer<WordsProvider>(
          builder: (context, provider, child) {
            // 显示加载进度条（任一表单在加载时显示）
            if (provider.isLoading) {
              return const LinearProgressIndicator();
            }
            return const SizedBox.shrink();
          },
        ),
      ),
      actions: [
        // 统计信息显示
        Consumer<WordsProvider>(
          builder: (context, provider, child) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Center(
                child: Text(
                  '共 ${provider.getItems.length} 词',
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            );
          },
        ),
        
        Consumer<PhraseProvider>(
          builder: (context, provider, child) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Center(
                child: Text(
                  '${provider.getItems.length} 短语',
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            );
          },
        ),
        
        const SizedBox(width: 8),
        _goToEditorButton(context),
        const SizedBox(width: 8),
        _goToLearningButton(context),
        const SizedBox(width: 16),
      ],
    );
  }

  Widget _goToEditorButton(BuildContext context) {
    final currentRoute = GoRouterState.of(context).uri.path;
    final isActive = currentRoute == '/english/editor';
    
    return ElevatedButton(
      onPressed: isActive ? null : () => context.go('/english/editor'),
      style: ElevatedButton.styleFrom(
        backgroundColor: isActive ? Colors.grey : null,
      ),
      child: const Text("Editor"),
    );
  }

  Widget _goToLearningButton(BuildContext context) {
    final currentRoute = GoRouterState.of(context).uri.path;
    final isActive = currentRoute == '/english';
    
    return ElevatedButton(
      onPressed: isActive ? null : () => context.go('/english'),
      style: ElevatedButton.styleFrom(
        backgroundColor: isActive ? Colors.grey : null,
      ),
      child: const Text("Learning"),
    );
  }
}
