import 'package:fucking_math/db/app_database.dart' as db;
import 'package:fucking_math/utils/types.dart';
import 'package:fucking_math/utils/image.dart';

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


/// 转换数据库 Image 到应用 ImageStorage
ImageStorage dbImageToImageStorage(db.Image dbImage) => ImageStorage(
  imagePath: ImageHelper.buildPath(dbImage.name),
  id: dbImage.id,
  name: dbImage.name,
  desc: dbImage.desc,
  path: dbImage.path,
);

/// 转换数据库 Mistake 到应用 Mistake
Mistake dbMistakeToMistake(
  db.Mistake dbMistake,
  MistakeState state,
  List<ImageStorage> images,
) => Mistake(
  id: dbMistake.id,
  subject: dbMistake.subject,
  head: dbMistake.questionHeader,
  body: dbMistake.questionBody,
  source: dbMistake.source,
  state: state,
  images: images,
);

/// 转换数据库 Answer 到应用 Answer
Answer dbAnswerToAnswer(
  db.Answer dbAnswer,
  List<Tag> tags,
  List<ImageStorage> images,
) => Answer(
  id: dbAnswer.id,
  questionID: dbAnswer.mistakeId,
  head: dbAnswer.head,
  body: dbAnswer.answer,
  note: dbAnswer.note,
  tags: tags,
  images: images,
);

