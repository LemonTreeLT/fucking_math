import 'package:drift/drift.dart';
import 'package:fucking_math/utils/types.dart';

class Tags extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get subject => text().map(SubjectConverter).nullable()();
  TextColumn get tag => text().unique()();
  IntColumn get color => integer().nullable()();
  TextColumn get description => text().nullable()();
}
