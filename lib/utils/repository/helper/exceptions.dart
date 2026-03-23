class TagOrWordNotFoundException implements Exception {
  final String message;
  final int tagID;
  final int wordId;

  TagOrWordNotFoundException(
    this.message, {
    required this.tagID,
    required this.wordId,
  });

  @override
  String toString() =>
      'Tag or word not found: $message, tagID: $tagID, wordID: $wordId';
}

class TagOrPhraseNotFoundException implements Exception {
  final String message;
  final int phraseID;
  final int tagID;

  TagOrPhraseNotFoundException(
    this.message, {
    required this.phraseID,
    required this.tagID,
  });

  @override
  String toString() =>
      'Phrase or tag not found: $message, phraseID: $phraseID, tagID: $tagID';
}

/// 数据库级错误，当且仅当数据库出现非常严重的结构性故障才抛出
class AppDatabaseException implements Exception {
  final String message;
  final Object? originalError;
  final StackTrace? stackTrace;
  AppDatabaseException(this.message, {this.originalError, this.stackTrace});
  @override
  String toString() {
    if (originalError != null) {
      return 'AppDatabaseException: $message\nCaused by: $originalError';
    }
    return 'AppDatabaseException: $message';
  }
}

class TagOrKnowledgeNotFoundException implements Exception {
  final String message;
  final int tagID;
  final int knowledgeId;

  TagOrKnowledgeNotFoundException(
    this.message, {
    required this.tagID,
    required this.knowledgeId,
  });

  @override
  String toString() =>
      'Tag or knowledge not found: $message, tagID: $tagID, knowledgeId: $knowledgeId';
}

class TagNotFoundException implements Exception {
  final String message;

  TagNotFoundException(this.message);

  @override
  String toString() => 'TagNotFoundException: $message';
}

class TagOrQuestionNotFoundException implements Exception {
  final String message;
  final int? tagID;
  final int? questionId;

  TagOrQuestionNotFoundException(this.message, {this.tagID, this.questionId});

  @override
  String toString() =>
      'Tag or question not found: $message, tagID: $tagID, questionId: $questionId';
}

class ImageOrQuestionNotFoundException implements Exception {
  final String message;
  final int? imageId;
  final int? questionId;

  ImageOrQuestionNotFoundException(this.message, {this.imageId, this.questionId});

  @override
  String toString() =>
      'Image or question not found: $message, imageId: $imageId, questionId: $questionId';
}

class TagOrAnswerNotFoundException implements Exception {
  final String message;
  final int? tagID;
  final int? answerId;

  TagOrAnswerNotFoundException(this.message, {this.tagID, this.answerId});

  @override
  String toString() =>
      'Tag or answer not found: $message, tagID: $tagID, answerId: $answerId';
}

class ImageOrAnswerNotFoundException implements Exception {
  final String message;
  final int? imageId;
  final int? answerId;

  ImageOrAnswerNotFoundException(this.message, {this.imageId, this.answerId});

  @override
  String toString() =>
      'Image or answer not found: $message, imageId: $imageId, answerId: $answerId';
}

class KnowledgeOrQuestionNotFoundException implements Exception {
  final String message;
  final int? knowledgeId;
  final int? questionId;

  KnowledgeOrQuestionNotFoundException(this.message,
      {this.knowledgeId, this.questionId});

  @override
  String toString() =>
      'Knowledge or question not found: $message, knowledgeId: $knowledgeId, questionId: $questionId';
}

/// 图片验证异常(文件不存在等业务逻辑错误)
class ImageValidationException implements Exception {
  final String message;
  final String? imagePath;

  ImageValidationException(this.message, {this.imagePath});

  @override
  String toString() =>
      'ImageValidationException: $message'
      '${imagePath != null ? ' (path: $imagePath)' : ''}';
}

/// 图片未找到异常
class ImageNotFoundException implements Exception {
  final String message;
  final int? imageId;

  ImageNotFoundException(this.message, {this.imageId});

  @override
  String toString() =>
      'ImageNotFoundException: $message'
      '${imageId != null ? ' (id: $imageId)' : ''}';
}

/// 短语未找到异常
class PhraseNotFoundException implements Exception {
  final String message;
  final int? phraseId;

  PhraseNotFoundException(this.message, {this.phraseId});

  @override
  String toString() =>
      'PhraseNotFoundException: $message'
      '${phraseId != null ? ' (id: $phraseId)' : ''}';
}

/// 知识点未找到异常
class KnowledgeNotFoundException implements Exception {
  final String message;
  final int? knowledgeId;

  KnowledgeNotFoundException(this.message, {this.knowledgeId});

  @override
  String toString() =>
      'KnowledgeNotFoundException: $message'
      '${knowledgeId != null ? ' (id: $knowledgeId)' : ''}';
}

/// 单词未找到异常
class WordNotFoundException implements Exception {
  final String message;
  final int? wordId;

  WordNotFoundException(this.message, {this.wordId});

  @override
  String toString() =>
      'WordNotFoundException: $message'
      '${wordId != null ? ' (id: $wordId)' : ''}';
}

// ============ AI 模块异常 ============

/// AI 提供商未找到异常
class AiProviderNotFoundException implements Exception {
  final String message;
  final int? providerId;

  AiProviderNotFoundException(this.message, {this.providerId});

  @override
  String toString() =>
      'AiProviderNotFoundException: $message'
      '${providerId != null ? ' (providerId: $providerId)' : ''}';
}

/// AI 会话未找到异常
class AiSessionNotFoundException implements Exception {
  final String message;
  final int? sessionId;

  AiSessionNotFoundException(this.message, {this.sessionId});

  @override
  String toString() =>
      'AiSessionNotFoundException: $message'
      '${sessionId != null ? ' (sessionId: $sessionId)' : ''}';
}

/// AI Prompt 未找到异常
class AiPromptNotFoundException implements Exception {
  final String message;
  final int? promptId;

  AiPromptNotFoundException(this.message, {this.promptId});

  @override
  String toString() =>
      'AiPromptNotFoundException: $message'
      '${promptId != null ? ' (promptId: $promptId)' : ''}';
}

/// AI 历史记录业务异常
class AiHistoryException implements Exception {
  final String message;

  AiHistoryException(this.message);

  @override
  String toString() => 'AiHistoryException: $message';
}

/// AI 任务引擎异常
class AiTaskException implements Exception {
  final String message;
  final String? taskId;

  AiTaskException(this.message, {this.taskId});

  @override
  String toString() =>
      'AiTaskException: $message'
      '${taskId != null ? ' (taskId: $taskId)' : ''}';
}

