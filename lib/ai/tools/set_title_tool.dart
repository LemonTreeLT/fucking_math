import 'package:fucking_math/ai/engine/tool_context.dart';
import 'package:fucking_math/ai/tools/_base_tool.dart';

class SetTitleTool extends BaseAiTool {
  @override
  String get name => 'set_title';

  @override
  String get description => '获取或设置当前对话的标题。不传 title 则返回当前标题（空字符串表示未设置），传入 title 则设置新标题。';

  @override
  List<AiField> get fields => [
    AiField<String>('title', const AiString('要设置的标题，不传则查询当前标题')),
  ];

  @override
  Future<String> call(Map<String, dynamic> args, [ToolContext? context]) async {
    if (context == null) return 'Error: no context';
    final title = fields[0].getValue(args);
    if (title == null || title.isEmpty) {
      return await context.getTitle() ?? '';
    }
    await context.setTitle(title);
    return '标题已设置为: $title';
  }
}
