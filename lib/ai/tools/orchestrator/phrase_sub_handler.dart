import 'package:fucking_math/ai/tools/_base_tool.dart';
import 'package:fucking_math/ai/tools/orchestrator/sub_action_handler.dart';
import 'package:fucking_math/utils/repository/phrase.dart';

class PhraseSubHandler implements SubActionHandler {
  final PhraseRepository _repo;
  PhraseSubHandler(this._repo);

  @override
  String get target => 'phrase';

  @override
  List<String> get supportedActions => [
    'save',
    'delete',
    'mark_review',
    'mark_repeat',
    'mark_test',
  ];

  @override
  List<AiField> get fields => [
    const AiField('id', AiInt('Phrase ID; required for delete/mark_review')),
    const AiField(
      'linked_word_id',
      AiInt('Word ID this phrase belongs to'),
      isRequired: true,
    ),
    const AiField(
      'phrase',
      AiString('The phrase text'),
      isRequired: true,
    ),
    const AiField('definition', AiString('Meaning/definition of the phrase')),
    const AiField(
      'tags',
      AiList('Tag IDs', itemType: AiInt('tag id')),
    ),
  ];

  @override
  Future<dynamic> handle(String action, Map<String, dynamic> data) =>
      switch (action) {
        'save' => _repo.savePhrase(
          data['linked_word_id'] as int,
          data['phrase'] as String,
          definition: data['definition'] as String?,
          tags: data['tags'] as List<int>?,
        ),
        'delete' => _repo.deletePhrase(data['id'] as int),
        'mark_review' => _repo.markPhraseReview(data['id'] as int),
        'mark_repeat' => _repo.markPhraseRepeat(data['id'] as int),
        'mark_test' => _repo.markPhraseTest(data['id'] as int),
        _ => throw UnimplementedError(
          'Action $action not supported for target phrase',
        ),
      };
}
