import 'package:drift/drift.dart';

enum Subject {
  math,
  chinese,
  english,
  physics,
  chemistry,
  biology,
  history,
  geography,
  politics,
}

// ignore: non_constant_identifier_names
final SubjectConverter = EnumNameConverter(Subject.values);

// 单词
class Word {
  final int id;
  final String word;
  final List<Tag> tags;
  final String? definitionPreview; // 预览定义
  final String? definition;
  final String? note;
  final int repeatCount; // 重复记录数
  const Word({
    required this.id,
    required this.word,
    this.tags = const [],
    this.definitionPreview,
    this.definition,
    this.note,
    this.repeatCount = 0,
  });
}

// 标签
class Tag {
  final int id;
  final String name;
  final String? description;
  final int? color;
  final Subject? subject;
  const Tag({
    required this.id,
    required this.name,
    this.description,
    this.color,
    this.subject,
  });
}

class Phrase {
  final int id;
  final String phrase;
  final int linkedWordID;
  final List<Tag> tags;
  final String? definition;
  final int repeatCount;
  final String? note;
  const Phrase({
    required this.id,
    required this.phrase,
    required this.linkedWordID,
    this.tags = const [],
    this.definition,
    this.repeatCount = 1,
    this.note,
  });
}

class Knowledge {
  final int id;
  final Subject subject;
  final String head;
  final String body;
  final List<Tag> tags;
  final int editCount;
  final String? note;
  final DateTime createdAt;
  Knowledge({
    required this.id,
    required this.subject,
    required this.head,
    required this.body,
    required this.tags,
    required this.editCount,
    this.note,
    required this.createdAt,
  });
}

// 错题
class Mistake {
  final int id;
  final Subject subject;
  final String head;
  final String body;
  final String? source;
  final MistakeState state;
  final List<ImageStorage> images;
  Mistake({
    required this.id,
    required this.subject,
    required this.head,
    required this.body,
    required this.state,
    this.source,
    this.images = const [],
  });
}

/// 记录了错题的当前状态
class MistakeState {
  final int view;
  final int review;
  final int repeat;
  final int answer;

  MistakeState({
    required this.view,
    required this.answer,
    required this.repeat,
    required this.review,
  });
}

class Answer {
  final int id;
  final int questionID;

  final String? head;
  final String body;
  final String? note;

  final List<Tag> tags;
  final List<ImageStorage> images;

  Answer({
    required this.id,
    required this.questionID,
    required this.body,
    this.head,
    this.note,
    this.tags = const [],
    this.images = const [],
  });
}

class ImageStorage {
  /// 该路径为图片存储的绝对路径
  /// 相关转换应该在repository中完成
  final String imagePath;
  final int id;
  final String name;
  final String? desc;
  final String? path;

  ImageStorage({
    required this.imagePath,
    required this.id,
    required this.name,
    this.desc,
    this.path,
  });
}
