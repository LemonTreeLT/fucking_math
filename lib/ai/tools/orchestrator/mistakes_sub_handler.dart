import 'package:fucking_math/ai/tools/_base_tool.dart';
import 'package:fucking_math/ai/tools/orchestrator/sub_action_handler.dart';
import 'package:fucking_math/utils/repository/mistakes.dart';
import 'package:fucking_math/utils/types.dart';

class MistakesSubHandler implements SubActionHandler {
  final MistakesRepository _repo;
  MistakesSubHandler(this._repo);

  @override
  String get target => 'mistake';

  @override
  List<String> get supportedActions => [
    'save',
    'delete',
    'mark_review',
    'mark_repeat',
    'mark_answer',
  ];

  @override
  List<AiField> get fields => [
    const AiField('id', AiInt('Mistake ID; omit to create new')),
    AiField(
      'subject',
      AiString(
        'Subject',
        enums: [
          'math',
          'chinese',
          'english',
          'physics',
          'chemistry',
          'biology',
          'history',
          'politics',
          'geography',
        ],
      ),
      isRequired: true,
    ),
    const AiField('head', AiString('Question title/header'), isRequired: true),
    const AiField('body', AiString('Question body/content'), isRequired: true),
    const AiField('source', AiString('Source book or exam name')),
    const AiField(
      'tags',
      AiList('Tag IDs to associate', itemType: AiInt('tag id')),
    ),
  ];

  @override
  Future<dynamic> handle(String action, Map<String, dynamic> data) =>
      switch (action) {
        'save' => _repo.saveMistake(
          id: data['id'] as int?,
          subject: Subject.values.byName(
            (data['subject'] as String?) ?? 'math',
          ),
          head: (data['head'] as String?) ?? '',
          body: (data['body'] as String?) ?? '',
          source: data['source'] as String?,
          tags: data['tags'] as List<int>?,
        ),
        'delete' => _repo.deleteMistake(data['id'] as int),
        'mark_review' => _repo.markMistakeReview(data['id'] as int),
        'mark_repeat' => _repo.markMistakeRepeat(data['id'] as int),
        'mark_answer' => _repo.markMistakeAnswer(data['id'] as int),
        _ => throw UnimplementedError(
          'Action $action not supported for target mistake',
        ),
      };
}
