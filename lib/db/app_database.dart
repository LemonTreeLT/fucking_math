import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:fucking_math/utils/types.dart';

import 'tables_english.dart';
import 'tables_mistakes.dart';


// 必须运行 build_runner 生成
part 'app_database.g.dart';

// ==========================================================
// 数据库连接配置 (桌面平台)
// ==========================================================

LazyDatabase _openConnection() {
  sqfliteFfiInit();

  return LazyDatabase(() async {
    final Directory appDataDir = await getApplicationSupportDirectory();
    final String configPath = p.join(appDataDir.path, 'config');
    final Directory configDir = Directory(configPath);

    if (!await configDir.exists()) {
      await configDir.create(recursive: true);
    }

    final file = File(p.join(configPath, 'app_records.db'));

    return NativeDatabase(file);
  });
}

// ==========================================================
// 数据库核心类定义
// ==========================================================

@DriftDatabase(tables: [Words, WordLogs, Mistakes])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // ==========================================================
  // I. WORDS API (单词操作)
  // ==========================================================

  /// C: 插入新单词 (如果 word 冲突则忽略，保持现有记录)
  Future<int> insertWord({required String word, String? definition}) async {
    final newId = await into(words).insert(
      WordsCompanion.insert(word: word, definition: Value(definition)),
      onConflict: DoNothing(), // 冲突时保持现有记录
    );

    // 如果成功插入新单词，记录日志
    if (newId != 0) {
      await _insertWordLog(wordId: newId, type: LogType.view);
    }
    return newId;
  }

  /// R: 监听所有单词 (按创建时间降序)
  Stream<List<Word>> watchAllWords() {
    return (select(words)..orderBy([
          (t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc),
        ]))
        .watch();
  }

  /// R: 通过 ID 获取单个单词
  Future<Word?> getWordById(int id) {
    return (select(words)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  /// U: 更新单词释义
  Future<bool> updateDefinition(int wordId, String newDefinition) {
    return (update(words)..where((t) => t.id.equals(wordId)))
        .write(WordsCompanion(definition: Value(newDefinition)))
        .then((rowsAffected) => rowsAffected > 0);
  }

  /// D: 删除单个单词及其所有日志
  Future<void> deleteWord(int id) {
    // 使用事务确保删除操作的原子性
    return transaction(() async {
      await (delete(words)..where((t) => t.id.equals(id))).go();
      await (delete(wordLogs)..where((t) => t.wordID.equals(id))).go();
    });
  }

  // ==========================================================
  // II. WORDLOGS API (日志操作)
  // ==========================================================

  // 内部方法：用于记录单词操作日志
  Future<int> _insertWordLog({
    required int wordId,
    required LogType type,
    String? notes,
  }) {
    return into(wordLogs).insert(
      WordLogsCompanion.insert(wordID: wordId, type: type, notes: Value(notes)),
    );
  }

  /// C: 记录一次单词操作（默写）
  Future<void> recordWordTest(int wordId, {String? notes}) async {
    await _insertWordLog(wordId: wordId, type: LogType.test, notes: notes);
  }

  /// C: 记录一次单词操作（重复）
  Future<void> recordWordRepeat(int wordId, {String? notes}) async {
    await _insertWordLog(wordId: wordId, type: LogType.repeat, notes: notes);
  }

  /// R: 获取特定单词的所有日志 (按时间降序)
  Stream<List<WordLog>> watchLogsForWord(int wordId) {
    return (select(wordLogs)
          ..where((l) => l.wordID.equals(wordId))
          ..orderBy([
            (l) =>
                OrderingTerm(expression: l.timestamp, mode: OrderingMode.desc),
          ]))
        .watch();
  }

  // ==========================================================
  // III. MISTAKES API (错题操作)
  // ==========================================================

  /// C: 插入一条错题记录
  Future<int> insertMistake({
    required Subject subject,
    required String questionHeader,
    required String questionBody,
    String? correctAnswer,
    String? userAnswer,
    String? unvifiedAnswer,
  }) {
    return into(mistakes).insert(
      MistakesCompanion.insert(
        subject: subject,
        questionHeader: questionHeader,
        questionBody: questionBody,
        correctAnswer: Value(correctAnswer),
        userAnswer: Value(userAnswer),
        unvifiedAnswer: Value(unvifiedAnswer),
      ),
    );
  }

  /// R: 监听所有错题记录
  Stream<List<Mistake>> watchAllMistakes() {
    return (select(mistakes)..orderBy([
          (m) => OrderingTerm(expression: m.createdAt, mode: OrderingMode.desc),
        ]))
        .watch();
  }

  /// R: 根据学科获取错题列表
  Future<List<Mistake>> getMistakesBySubject(Subject subject) {
    return (select(mistakes)
          ..where((m) => m.subject.equalsValue(subject))
          ..orderBy([
            (m) =>
                OrderingTerm(expression: m.createdAt, mode: OrderingMode.desc),
          ]))
        .get();
  }

  /// D: 删除单个错题记录
  Future<int> deleteMistake(int id) {
    return (delete(mistakes)..where((m) => m.id.equals(id))).go();
  }
}
