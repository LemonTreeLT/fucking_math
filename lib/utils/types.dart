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
  String toSql(Subject value) {
    return value.name;
  }
}

// 单词
class Word {
  final int id;
  final String word;
  final List<Tag> tags;
  final String? definitionPreview;
  final String? definition;
  final String? note; // 从最新的 log 中获取
  final int repeatCount; // 从 logs 中计算
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
  // 也可以有 note, repeatCount 等聚合属性
  const Phrase({
    required this.id,
    required this.phrase,
    required this.linkedWordID,
    this.tags = const [],
    this.definition,
  });
}
