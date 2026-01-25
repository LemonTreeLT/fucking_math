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

class AppDatabaseException implements Exception {
  final String message;
  final Object? originalError;
  final StackTrace? stackTrace;
  AppDatabaseException(
    this.message, {
    this.originalError,
    this.stackTrace,
  });
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

class TagOrMistakeNotFoundException implements Exception {
  final String message;
  final int? tagID;
  final int? mistakeId;

  TagOrMistakeNotFoundException(
    this.message, {
    this.tagID,
    this.mistakeId,
  });

  @override
  String toString() =>
      'Tag or mistake not found: $message, tagID: $tagID, mistakeId: $mistakeId';
}

class ImageOrMistakeNotFoundException implements Exception {
  final String message;
  final int? imageId;
  final int? mistakeId;

  ImageOrMistakeNotFoundException(
    this.message, {
    this.imageId,
    this.mistakeId,
  });

  @override
  String toString() =>
      'Image or mistake not found: $message, imageId: $imageId, mistakeId: $mistakeId';
}

class TagOrAnswerNotFoundException implements Exception {
  final String message;
  final int? tagID;
  final int? answerId;

  TagOrAnswerNotFoundException(
    this.message, {
    this.tagID,
    this.answerId,
  });

  @override
  String toString() =>
      'Tag or answer not found: $message, tagID: $tagID, answerId: $answerId';
}

class ImageOrAnswerNotFoundException implements Exception {
  final String message;
  final int? imageId;
  final int? answerId;

  ImageOrAnswerNotFoundException(
    this.message, {
    this.imageId,
    this.answerId,
  });

  @override
  String toString() =>
      'Image or answer not found: $message, imageId: $imageId, answerId: $answerId';
}

