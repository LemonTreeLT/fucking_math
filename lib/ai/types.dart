import 'dart:io';
import 'dart:convert';
import 'package:fucking_math/utils/types.dart' show ImageStorage;

enum Roles { user, system, tool, assistant }

class AiProvider {
  /// 当id为空时表示该provider未入库或不来自数据库
  int? id;
  String name;
  String? desc;
  String baseUrl;
  String apiKey;
  List<String> models;

  File? icon;

  AiProvider({
    this.id,
    required this.name,
    this.desc,
    required this.baseUrl,
    required this.apiKey,
    required this.models,
    this.icon,
  });
}

class Message {
  /// id 为空时表示未入库
  final int? id;

  /// providerId 为空时表示使用了一个未入库的 provider
  final int? providerId;
  final Roles role;

  final Session? session;

  final String content;
  final String? toolCalls;
  final String? toolId;

  final int? token;
  final DateTime? createdAt;
  final List<ImageStorage>? images;

  Message({
    this.id,
    this.providerId,
    required this.role,
    this.session,
    required this.content,
    this.toolCalls,
    this.toolId,
    this.token,
    this.createdAt,
    this.images,
  });
}

class Session {
  /// id 为空时表示未入库
  final int? id;
  final String? title;
  final DateTime? createdAt;

  Session({this.id, this.title, this.createdAt});
}

/// 标准的prompt交互对象，支持纯字符也支持存在占位符的prompt
class Prompt {
  final int? id;
  final String? name;
  final String? desc;
  final String content;

  Prompt({this.id, this.name, this.desc, required this.content});

  /// 接受一个 args 替换对应的占位符，不存在的保持原样
  Prompt build(Map<String, String> args) {
    // 正则表达式解释：
    // \{\{ : 匹配左边的 {{
    // (.*?) : 捕获组，匹配任意字符（非贪婪模式），即 {{ }} 内部的 key
    // \}\} : 匹配右边的 }}
    final RegExp pattern = RegExp(r'\{\{(.*?)\}\}');

    final newContent = content.replaceAllMapped(pattern, (Match match) {
      // match.group(1) 是括号中捕获的内容 (即 key)
      // trim() 用于处理 {{ name }} 中可能存在的空格
      String key = match.group(1)!.trim();

      // 如果 map 中存在这个 key，则替换；否则保留原样（或者你可以返回空字符串 ''）
      return args.containsKey(key) ? args[key]! : match.group(0)!;
    });

    return Prompt(content: newContent, id: id, name: name, desc: desc);
  }

  List<String> getArgs(String text) {
    // 正则表达式：匹配 {{ 和 }} 之间的内容
    final RegExp pattern = RegExp(r'\{\{(.*?)\}\}');

    // 查找所有匹配项
    Iterable<RegExpMatch> matches = pattern.allMatches(text);

    // 提取捕获组 (group 1) 的内容，并转为 List
    return matches.map((match) => match.group(1)!.trim()).toList();
  }
}

/// 代表一个完整的对话会话，包含会话信息和所有消息
class Conversation {
  final Session session;
  final List<Message> messages;

  Conversation({required this.session, required this.messages});

  /// 将对话转换为 OpenAI 格式的 messages 字段
  /// 返回符合 OpenAI API 的 message 对象列表
  /// 格式参考：[{"role": "user", "content": "..."}, ...]
  List<Map<String, dynamic>> toOpenAIFormat() => messages.map((msg) {
    final map = <String, dynamic>{
      'role': msg.role.name,
      'content': msg.content,
    };

    // 处理工具调用
    if (msg.toolCalls != null && msg.toolCalls!.isNotEmpty) {
      try {
        map['tool_calls'] = jsonDecode(msg.toolCalls!);
      } catch (e) {
        // 如果 JSON 解析失败，保留原始字符串
        map['tool_calls'] = msg.toolCalls!;
      }
    }

    // 处理工具调用 ID
    if (msg.toolId != null) map['tool_call_id'] = msg.toolId;

    return map;
  }).toList();

  /// 向对话中追加一条消息（不可变操作）
  /// 返回新的 Conversation 实例
  Conversation addMessage(Message message) {
    return Conversation(session: session, messages: [...messages, message]);
  }
}
