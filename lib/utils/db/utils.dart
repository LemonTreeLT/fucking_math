// 辅助函数: 转换数据库 Tag 到应用 Tag
import 'package:fucking_math/db/app_database.dart' as db;
import 'package:fucking_math/utils/types.dart';

Tag dbTagToTag(db.Tag dbTag) => Tag(
  id: dbTag.id,
  name: dbTag.tag,
  description: dbTag.description,
  color: dbTag.color,
  subject: dbTag.subject,
);

Knowledge dbKnowledgeToKnowledge(
  db.KnowledgeTableData dbKnowledge,
  List<Tag> tags, {
  int? editCount,
  String? note,
}) =>
    Knowledge(
      id: dbKnowledge.id,
      subject: dbKnowledge.subject,
      head: dbKnowledge.head,
      body: dbKnowledge.body,
      tags: tags,
      editCount: editCount ?? 0,
      note: note,
      createdAt: dbKnowledge.createdAt,
    );

