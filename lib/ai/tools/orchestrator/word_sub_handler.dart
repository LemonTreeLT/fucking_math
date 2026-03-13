import 'package:fucking_math/ai/tools/_base_tool.dart';
import 'package:fucking_math/ai/tools/orchestrator/sub_action_handler.dart';
import 'package:fucking_math/utils/repository/english.dart';

class WordSubHandler implements SubActionHandler {
  final WordsRepository _repo;
  WordSubHandler(this._repo);

  @override
  String get target => 'word';

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
    const AiField('id', AiInt('Word ID; required for delete/mark_*')),
    const AiField('word', AiString('The English word'), isRequired: true),
    const AiField('definition', AiString('Full definition')),
    const AiField('definition_preview', AiString('Short preview of definition')),
    const AiField(
      'tags',
      AiList('Tag IDs', itemType: AiInt('tag id')),
    ),
  ];

  @override
  Future<dynamic> handle(String action, Map<String, dynamic> data) =>
      switch (action) {
        'save' => _repo.saveWord(
          data['word'] as String,
          definition: data['definition'] as String?,
          definitionPreview: data['definition_preview'] as String?,
          tags: data['tags'] as List<int>?,
        ),
        'delete' => _repo.deleteWord(data['id'] as int),
        'mark_review' => _repo.markWordReview(data['id'] as int),
        'mark_repeat' => _repo.markWordRepeat(data['id'] as int),
        'mark_test' => _repo.markWordTest(data['id'] as int),
        _ => throw UnimplementedError(
          'Action $action not supported for target word',
        ),
      };
}
