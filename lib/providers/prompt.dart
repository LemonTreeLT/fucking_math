import 'package:fucking_math/ai/prompts.dart' show builtInPrompts;
import 'package:fucking_math/ai/repository/ai_prompt_repository.dart';
import 'package:fucking_math/ai/types.dart' show Prompt;
import 'package:fucking_math/providers/base_db_provider.dart';

class PromptProvider extends BaseRepositoryProvider<Prompt, PromptRepository>
    with SingleObjectSelectMixin<Prompt> {
  PromptProvider(super.rep);

  Future<void> loadPrompts() => justDoIt<List<Prompt>>(
    action: () => rep.getAllPrompts(),
    onSuccess: (dbPrompts) => setItems([...builtInPrompts, ...dbPrompts]),
    errMsg: "加载 Prompt 失败",
  );

  Future<void> createPrompt({
    required String content,
    String? name,
    String? desc,
  }) => justDoIt<int>(
    action: () => rep.createPrompt(content: content, name: name, desc: desc),
    onSuccess: (_) => loadPrompts(),
    errMsg: "创建 Prompt 失败",
  );

  Future<void> updatePrompt(
    int id, {
    String? name,
    String? desc,
    String? content,
  }) => justDoIt<int>(
    action: () => rep.updatePrompt(id, name: name, desc: desc, content: content),
    onSuccess: (_) => loadPrompts(),
    errMsg: "更新 Prompt 失败",
  );

  Future<void> deletePrompt(int id) => justDoIt<int>(
    action: () => rep.deletePrompt(id),
    onSuccess: (_) async {
      select(null);
      await loadPrompts();
    },
    errMsg: "删除 Prompt 失败",
  );
}
