// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_dao.dart';

// ignore_for_file: type=lint
mixin _$TagsDaoMixin on DatabaseAccessor<AppDatabase> {
  $TagsTable get tags => attachedDatabase.tags;
}
mixin _$WordsDaoMixin on DatabaseAccessor<AppDatabase> {
  $WordsTable get words => attachedDatabase.words;
  $WordLogsTable get wordLogs => attachedDatabase.wordLogs;
  $TagsTable get tags => attachedDatabase.tags;
  $WordTagLinkTable get wordTagLink => attachedDatabase.wordTagLink;
}
mixin _$KnowledgeDaoMixin on DatabaseAccessor<AppDatabase> {
  $KnowledgeTableTable get knowledgeTable => attachedDatabase.knowledgeTable;
  $KnowledgeLogTableTable get knowledgeLogTable =>
      attachedDatabase.knowledgeLogTable;
  $TagsTable get tags => attachedDatabase.tags;
  $KnowledgeTagLinkTable get knowledgeTagLink =>
      attachedDatabase.knowledgeTagLink;
}
mixin _$MistakesDaoMixin on DatabaseAccessor<AppDatabase> {
  $MistakesTable get mistakes => attachedDatabase.mistakes;
  $TagsTable get tags => attachedDatabase.tags;
  $MistakesTagLinkTable get mistakesTagLink => attachedDatabase.mistakesTagLink;
  $MistakeLogsTable get mistakeLogs => attachedDatabase.mistakeLogs;
}
mixin _$PhrasesDaoMixin on DatabaseAccessor<AppDatabase> {
  $WordsTable get words => attachedDatabase.words;
  $PhrasesTable get phrases => attachedDatabase.phrases;
  $TagsTable get tags => attachedDatabase.tags;
  $PhrasesTagLinkTable get phrasesTagLink => attachedDatabase.phrasesTagLink;
}
