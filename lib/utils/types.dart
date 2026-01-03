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

class SubjectConverter extends TypeConverter<Subject, String> {
  const SubjectConverter();

  @override
  Subject fromSql(String fromDb) {
    try {
      return Subject.values.byName(fromDb);
    } catch (e) {
      throw ArgumentError('Invalid Subject index: $fromDb');
    }
  }

  @override
  String toSql(Subject value) => value.name;
}

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
