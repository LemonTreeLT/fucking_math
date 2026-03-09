import 'package:dio/dio.dart';
import 'package:fucking_math/ai/types.dart';
import 'package:fucking_math/utils/outputs.dart';
import 'package:get_it/get_it.dart';

class Assistant {
  /// 获取不带流的 ai 回复
  /// 高级封装，仅需提供prompt与场景
  Future<Message?> getResponse(
    AiProvider provider,
    Prompt prompt, {
    String model = "gpt-3.5-turbo",
    Map<String, String>? args,
  }) async {
    final String finalContent = args != null
        ? prompt.build(args).content
        : prompt.content;

    final Dio dio = GetIt.I.call();

    // 3. 构建 URL (适配 OpenAI 兼容格式)
    String baseUrl = provider.baseUrl.trim();
    if (baseUrl.endsWith('/')) {
      baseUrl = baseUrl.substring(0, baseUrl.length - 1);
    }
    final String apiUrl = "$baseUrl/chat/completions";

    debugPrint("Final Request Url: $apiUrl");

    try {
      // 4. 发送请求
      final response = await dio.post(
        apiUrl,
        data: {
          "model": model,
          "messages": [
            {"role": "user", "content": finalContent},
          ],
        },
        options: Options(
          receiveTimeout: const Duration(seconds: 60), // AI 响应较慢，给 60 秒
          headers: {
            "Authorization": "Bearer ${provider.apiKey}",
            "Content-Type": "application/json",
          },
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data;

        // 5. 提取 AI 核心回复内容
        final String aiContent = data['choices'][0]['message']['content'] ?? "";

        // 6. 提取 Token 消耗 (OpenAI 协议中通常在 usage 字段)
        final int totalTokens = data['usage']?['total_tokens'] ?? 0;

        debugPrint("[Ai] Response: $aiContent");
        // 7. 封装并返回 Message 对象
        return Message(
          providerId: provider.id ?? 0, // 如果 provider 未入库，暂时传 0 或处理逻辑
          role: Roles.assistant, // AI 的回复角色固定为 assistant
          content: aiContent,
          token: totalTokens, // 记录本次消耗的 token
          createdAt: DateTime.now(), // 记录创建时间
          // toolCalls, toolId, session 等字段根据你的业务需求在此赋值
        );
      }
    } on DioException catch (e) {
      debugPrint("请求 AI 出错: ${e.type} - ${e.message}");
      if (e.response != null) {
        debugPrint("错误详情: ${e.response?.data}");
      }
    } catch (e) {
      debugPrint("发生未知错误: $e");
    }
    return null; // 如果失败则返回 null
  }

  // TODO 低优先级 实现流回复
  Future<void> getResponseStream() async {}
}
