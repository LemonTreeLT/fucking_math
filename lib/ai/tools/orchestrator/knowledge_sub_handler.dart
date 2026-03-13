import 'package:fucking_math/ai/tools/_base_tool.dart';
import 'package:fucking_math/ai/tools/orchestrator/sub_action_handler.dart';
import 'package:fucking_math/utils/repository/knowledge.dart';
import 'package:fucking_math/utils/types.dart';

class KnowledgeSubHandler implements SubActionHandler {
  final KnowledgeRepository _repo;
  KnowledgeSubHandler(this._repo);

  @override
  String get target => 'knowledge';

  @override
  List<String> get supportedActions => ['save', 'delete', 'mark_retry'];

  @override
  List<AiField> get fields => [
    const AiField('id', AiInt('Knowledge ID; required for delete/mark_retry')),
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
          'geography',
          'politics',
        ],
      ),
      isRequired: true,
    ),
    const AiField('head', AiString('Title/heading'), isRequired: true),
    const AiField('body', AiString('Full content body'), isRequired: true),
    const AiField(
      'tags',
      AiList('Tag IDs', itemType: AiInt('tag id')),
    ),
  ];

  @override
  Future<dynamic> handle(String action, Map<String, dynamic> data) =>
      switch (action) {
        'save' => _repo.saveKnowledge(
          Subject.values.byName((data['subject'] as String?) ?? 'math'),
          (data['head'] as String?) ?? '',
          (data['body'] as String?) ?? '',
          tags: data['tags'] as List<int>?,
        ),
        'delete' => _repo.deleteKnowledge(data['id'] as int),
        'mark_retry' => _repo.markKnowledgeRetry(data['id'] as int),
        _ => throw UnimplementedError(
          'Action $action not supported for target knowledge',
        ),
      };
}
