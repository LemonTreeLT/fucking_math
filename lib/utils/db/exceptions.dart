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
