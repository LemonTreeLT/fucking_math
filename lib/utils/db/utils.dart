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
