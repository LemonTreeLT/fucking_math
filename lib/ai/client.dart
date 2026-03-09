import 'package:fucking_math/ai/core/ai_client.dart';
import 'package:fucking_math/ai/types.dart';
import 'package:fucking_math/utils/outputs.dart';

class Assistant {
  // TODO 实现完整的 AI 回复（含 tool calls、session 管理等）
  Future<Message?> getResponse() async {
    return null;
  }

  /// 纯文本问答，发送 prompt 获取 AI 文本回复
  Future<String> getPureTextMessage(
    AiProvider provider,
    Prompt prompt, {
    String model = "gpt-3.5-turbo",
    Map<String, String>? args,
  }) async {
    final String finalContent =
        args != null ? prompt.build(args).content : prompt.content;

    final response = await AiClient.chatCompletion(
      baseUrl: provider.baseUrl,
      apiKey: provider.apiKey,
      model: model,
      messages: [
        {"role": "user", "content": finalContent},
      ],
    );

    debugPrint("[Ai] Response: ${response.content}");
    return response.content;
  }

  // TODO 低优先级 实现流回复
  Future<void> getResponseStream() async {}
}
