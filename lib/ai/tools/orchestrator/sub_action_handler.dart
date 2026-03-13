import 'package:fucking_math/ai/tools/_base_tool.dart';

abstract class SubActionHandler {
  String get target;
  List<String> get supportedActions;
  List<AiField> get fields;
  Future<dynamic> handle(String action, Map<String, dynamic> data);
}
