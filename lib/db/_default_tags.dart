import 'package:drift/drift.dart';
import 'package:fucking_math/db/app_database.dart';
import 'package:fucking_math/utils/types.dart';

final List<_T> _defaultTags = [
  const _T("单词", "这是一个单词", 0xFF2196F, Subject.english),
  const _T("错题", "这是一道错题", 0xFFF44336),
];

class _T {
  final String name;
  final String? description;
  final int? color;
  final Subject? subject;

  // ignore: unused_element_parameter
  const _T(this.name, [this.description, this.color, this.subject]);

  TagsCompanion toCompanion() => TagsCompanion.insert(
    tag: name,
    description: Value(description),
    color: Value(color),
    subject: Value(subject),
  );
}

List<TagsCompanion> getDefaultTagList() =>
    _defaultTags.map((tag) => tag.toCompanion()).toList();
