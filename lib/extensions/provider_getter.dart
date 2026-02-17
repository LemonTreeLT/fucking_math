import 'package:flutter/material.dart';
import 'package:fucking_math/providers/mistakes.dart';
import 'package:provider/provider.dart';

extension MistakesProviderGetterForContext on BuildContext {
  MistakesProvider get misRead => read();
}
