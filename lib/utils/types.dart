import 'package:drift/drift.dart';
import 'package:fucking_math/db/app_database.dart';

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

typedef Word = ({
  String word,
  int id,
  List<Tag> tags,
  String? definitionPreview,
  String? definition,
});

typedef Tag = ({
  String name,
  int id,
  String? description,
  int? color,
  Subject? subject,
});

typedef Phrase = ({
  String phrase,
  int id,
  int linkedWordID,
  String? definition,
});
