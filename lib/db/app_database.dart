import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:fucking_math/configs/config.dart';
import 'package:fucking_math/configs/tags.dart';
import 'package:fucking_math/db/tables/tables_images.dart';

// --- 引入所有表格定义 ---
import 'package:fucking_math/db/tables/tables_ai.dart';
import 'package:fucking_math/db/tables/tables_english.dart';
import 'package:fucking_math/db/tables/tables_knowledge.dart';
import 'package:fucking_math/db/tables/tables_mistakes.dart';
import 'package:fucking_math/db/tables/tables_tags.dart';

import 'package:fucking_math/utils/types.dart' show Subject, SubjectConverter;
import 'package:fucking_math/ai/types.dart' show Roles;

// 引入 dao 定义
import 'daos/ai_history.dart';
import 'daos/ai_provider.dart';
import 'daos/ai_prompt.dart';
import 'daos/tag.dart';
import 'daos/knowledge.dart';
import 'daos/mistake.dart';
import 'daos/phrase.dart';
import 'daos/word.dart';
import 'daos/images.dart';

// 告诉 drift 生成代码。运行 `dart run build_runner build`
part 'app_database.g.dart';

// =======================================================
// 1. 核心数据库类
// =======================================================

// 在 app_database.dart 的 AppDatabase 类中添加以下 getter

@DriftDatabase(
  tables: [
    AiProviders,
    AiHistories,
    Session,
    Prompts,
    Tags,
    Words,
    WordLogs,
    WordTagLink,
    Phrases,
    PhrasesTagLink,
    PhraseLogs,
    Knowledge,
    KnowledgeLogs,
    KnowledgeTagLink,
    Mistakes,
    MistakesTagLink,
    MistakeLogs,
    MistakePicsLink,
    Answers,
    AnswersTagsLink,
    AnswerPicsLink,
    Images,
    MistakeAnalysis,
    MistakeKnowledgeLink,
  ],
  daos: [AiProviderDao, AiHistoryDao, PromptDao, TagsDao, WordsDao, KnowledgeDao, MistakesDao, PhrasesDao, ImagesDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1; // 在mvp之前这个值为1

  static LazyDatabase _openConnection() =>
      LazyDatabase(() async => NativeDatabase(Config.dbFile));

  // DAO 访问器
  @override
  AiProviderDao get aiProviderDao => AiProviderDao(this);
  @override
  AiHistoryDao get aiHistoryDao => AiHistoryDao(this);
  @override
  TagsDao get tagsDao => TagsDao(this);
  @override
  WordsDao get wordsDao => WordsDao(this);
  @override
  KnowledgeDao get knowledgeDao => KnowledgeDao(this);
  @override
  MistakesDao get mistakesDao => MistakesDao(this);

  @override
  MigrationStrategy get migration => MigrationStrategy(
    // 初始化默认tag
    onCreate: (m) async {
      await m.createAll();
      await batch((b) => b.insertAll(tags, getDefaultTagList()));
    },
  );
}

List<TagsCompanion> getDefaultTagList() => DefaultTag.values
    .map(
      (t) => TagsCompanion.insert(
        tag: t.name,
        description: Value(t.desc),
        color: Value(t.c),
        subject: Value(t.sub),
      ),
    )
    .toList();
