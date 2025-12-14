import 'package:drift/drift.dart';
import 'package:fucking_math/utils/types.dart';

class Tags extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get subject => text().map(const SubjectConverter()).nullable()();
  TextColumn get tag => text()();
  TextColumn get description => text().nullable()();
}
