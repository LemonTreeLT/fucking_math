// 辅助函数: 转换数据库 Tag 到应用 Tag
import 'package:fucking_math/db/app_database.dart' as db;
import 'package:fucking_math/utils/types.dart';

Tag dbTagToTag(db.Tag dbTag) {
  return (
    name: dbTag.tag,
    id: dbTag.id,
    description: dbTag.description,
    color: dbTag.color,
    subject: dbTag.subject,
  );
}
