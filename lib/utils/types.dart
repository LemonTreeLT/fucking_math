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
