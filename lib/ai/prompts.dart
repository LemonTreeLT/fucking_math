import 'package:fucking_math/ai/types.dart';


Prompt getTest1() => test1.build({"content1": "你好", "content2": "测试替换"});

// ========== Source Prompts ==========

final test1 = Prompt(
  content:
      "你现在处于测试模式之中，你需要输出以下内容,若出现{{}}则说明用户没有提供该字段, 你不需要输出: {{content1}}, {{content2}}, {{content3}}",
);

final systemPromptV1 = Prompt(content: "你是一位内置于Fucking Math");
