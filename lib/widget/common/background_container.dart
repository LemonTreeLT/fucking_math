import 'package:flutter/material.dart';
import 'package:fucking_math/widget/common/backgrounds.dart';

class GenericBackground extends StatelessWidget {
  final String label;
  final Widget child;
  final EdgeInsetsGeometry padding;

  const GenericBackground({
    super.key,
    required this.label,
    required this.child,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context) => BorderedContainerWithTopText(
    labelText: label,
    child: Padding(padding: padding, child: child),
  );
}
