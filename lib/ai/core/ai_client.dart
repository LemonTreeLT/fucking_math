import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fucking_math/ai/types.dart';
import 'package:fucking_math/utils/outputs.dart';
import 'package:get_it/get_it.dart';

class AiClientException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic responseData;

  AiClientException(this.message, {this.statusCode, this.responseData});

  @override
  String toString() => 'AiClientException($statusCode): $message';
}

class AiClient {
  /// 发送 chat completion 请求（OpenAI 兼容格式）
  static Future<AiResponse> chatCompletion({
    required String baseUrl,
    required String apiKey,
    required String model,
    required List<Map<String, dynamic>> messages,
    List<Map<String, dynamic>>? tools,
    Duration timeout = const Duration(seconds: 60),
  }) async {
    final dio = GetIt.I<Dio>();

    // 1. 规范化 baseUrl
    String normalizedUrl = baseUrl.trim();
    if (normalizedUrl.endsWith('/')) {
      normalizedUrl = normalizedUrl.substring(0, normalizedUrl.length - 1);
    }
    final String apiUrl = "$normalizedUrl/chat/completions";

    debugPrint("[AiClient] POST $apiUrl");

    // 2. 构建请求体
    final Map<String, dynamic> body = {
      "model": model,
      "messages": messages,
    };
    if (tools != null && tools.isNotEmpty) {
      body["tools"] = tools;
    }

    // 3. 发送请求
    try {
      final response = await dio.post(
        apiUrl,
        data: body,
        options: Options(
          receiveTimeout: timeout,
          headers: {
            "Authorization": "Bearer $apiKey",
            "Content-Type": "application/json",
          },
        ),
      );

      if (response.statusCode != 200) {
        throw AiClientException(
          'Unexpected status code: ${response.statusCode}',
          statusCode: response.statusCode,
          responseData: response.data,
        );
      }

      final data = response.data;
      final choice = data['choices']?[0];
      if (choice == null) {
        throw AiClientException(
          'No choices in response',
          statusCode: response.statusCode,
          responseData: data,
        );
      }

      final message = choice['message'];
      final String content = message['content'] ?? '';
      final toolCalls = message['tool_calls'];

      return AiResponse(
        content: content,
        model: data['model'] ?? model,
        toolCalls: toolCalls != null ? jsonEncode(toolCalls) : null,
        promptTokens: data['usage']?['prompt_tokens'],
        completionTokens: data['usage']?['completion_tokens'],
        totalTokens: data['usage']?['total_tokens'],
        finishReason: choice['finish_reason'],
      );
    } on DioException catch (e) {
      throw AiClientException(
        '${e.type} - ${e.message}',
        statusCode: e.response?.statusCode,
        responseData: e.response?.data,
      );
    }
  }
}
