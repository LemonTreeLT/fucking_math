import 'package:flutter/material.dart';
import 'package:fucking_math/providers/questions.dart';
import 'package:provider/provider.dart';

extension QuestionsProviderGetterForContext on BuildContext {
  QuestionsProvider get quesRead => read();
}
