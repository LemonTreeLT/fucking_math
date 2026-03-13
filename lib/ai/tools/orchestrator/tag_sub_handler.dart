import 'package:fucking_math/ai/tools/_base_tool.dart';
import 'package:fucking_math/ai/tools/orchestrator/sub_action_handler.dart';
import 'package:fucking_math/utils/repository/tag.dart';
import 'package:fucking_math/utils/types.dart';

class TagSubHandler implements SubActionHandler {
  final TagRepository _repo;
  TagSubHandler(this._repo);

  @override
  String get target => 'tag';

  @override
  List<String> get supportedActions => ['save', 'delete'];

  @override
  List<AiField> get fields => [
    const AiField('id', AiInt('Tag ID; required for delete')),
    const AiField('name', AiString('Tag name'), isRequired: true),
    const AiField('description', AiString('Tag description')),
    AiField(
      'subject',
      AiString(
        'Subject scope',
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
    ),
    const AiField('color', AiInt('Color code (int)')),
  ];

  @override
  Future<dynamic> handle(String action, Map<String, dynamic> data) =>
      switch (action) {
        'save' => _repo.saveTag(
          name: data['name'] as String,
          description: data['description'] as String?,
          subject: data['subject'] != null
              ? Subject.values.byName(data['subject'] as String)
              : null,
          color: data['color'] as int?,
        ),
        'delete' => _repo.deleteTag(data['id'] as int),
        _ => throw UnimplementedError(
          'Action $action not supported for target tag',
        ),
      };
}
