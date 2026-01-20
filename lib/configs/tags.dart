import 'package:fucking_math/utils/types.dart';

/// **Warning**: 当你在比对一个default tag的时候，请务必使用 [name] 字段
enum DefaultTag {
  word("单词", "这是一个单词", c: 0xFF2196F3, sub: Subject.english),
  mistake("错题", "这是一道错题", c: 0xFFF44336),
  correct("正确答案", "该答案被验证为正确", c: 0xFF66ED4E),
  unverified("未验证", "这个答案需要被验证，并手动标记正误", c: 0xfff5b031),
  best("最好答案", "这是在多解问题中的最优解", c: 0xff00d600),
  available("可用解", "这是可以解决一个多解问题的一个解", c: 0xff299e7f);

  // -------------- ADD TAG ABOVE --------------
  // 字段定义
  final String name;
  final String desc;
  final int? c;
  final Subject? sub;
  // 构造函数
  const DefaultTag(this.name, this.desc, {this.c, this.sub});
}
