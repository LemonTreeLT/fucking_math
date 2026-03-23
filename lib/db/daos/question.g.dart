// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// ignore_for_file: type=lint
mixin _$QuestionsDaoMixin on DatabaseAccessor<AppDatabase> {
  $QuestionsTable get questions => attachedDatabase.questions;
  $AnswersTable get answers => attachedDatabase.answers;
  $QuestionLogsTable get questionLogs => attachedDatabase.questionLogs;
  $ImagesTable get images => attachedDatabase.images;
  $QuestionPicsLinkTable get questionPicsLink =>
      attachedDatabase.questionPicsLink;
  $TagsTable get tags => attachedDatabase.tags;
  $AnswersTagsLinkTable get answersTagsLink => attachedDatabase.answersTagsLink;
  $AnswerPicsLinkTable get answerPicsLink => attachedDatabase.answerPicsLink;
  $QuestionsTagLinkTable get questionsTagLink =>
      attachedDatabase.questionsTagLink;
  $QuestionAnalysisTable get questionAnalysis =>
      attachedDatabase.questionAnalysis;
  $KnowledgeTable get knowledge => attachedDatabase.knowledge;
  $QuestionKnowledgeLinkTable get questionKnowledgeLink =>
      attachedDatabase.questionKnowledgeLink;
}
