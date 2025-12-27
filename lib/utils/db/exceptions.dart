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
      'TagOrWordNotFoundException: $message, tagID: $tagID, wordID: $wordId';
}
