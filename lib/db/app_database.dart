import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

// --- 引入所有表格定义 ---
import 'package:fucking_math/db/tables_english.dart' as eng;
import 'package:fucking_math/db/tables_knowledge.dart' as know;
import 'package:fucking_math/db/tables_mistakes.dart' as mist;
import 'package:fucking_math/db/tables_tags.dart' as tag;

import 'package:fucking_math/utils/types.dart';
import 'app_dao.dart';

// 告诉 drift 生成代码。运行 `dart run build_runner build`
part 'app_database.g.dart';

// =======================================================
// 1. 核心数据库类
// =======================================================

// 在 app_database.dart 的 AppDatabase 类中添加以下 getter

@DriftDatabase(
  tables: [
    tag.Tags,
    eng.Words,
    eng.WordLogs,
    eng.WordTagLink,
    eng.Phrases,
    eng.PhrasesTagLink,
    know.KnowledgeTable,
    know.KnowledgeLogTable,
    know.KnowledgeTagLink,
    mist.Mistakes,
    mist.MistakesTagLink,
    mist.MistakeLogs,
  ],
  daos: [TagsDao, WordsDao, KnowledgeDao, MistakesDao, PhrasesDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1; // 在mvp之前这个值为1

  static LazyDatabase _openConnection() {
    return LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'fucking_math_db.sqlite'));
      return NativeDatabase(file);
    });
  }

  // DAO 访问器
  @override
  TagsDao get tagsDao => TagsDao(this);
  @override
  WordsDao get wordsDao => WordsDao(this);
  @override
  KnowledgeDao get knowledgeDao => KnowledgeDao(this);
  @override
  MistakesDao get mistakesDao => MistakesDao(this);
}
