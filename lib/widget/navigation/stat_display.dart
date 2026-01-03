import 'package:flutter/material.dart';

class StatDisplay extends StatelessWidget {
  final String label;
  final int count;
  const StatDisplay({
    super.key,
    required this.label,
    required this.count,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Center(
        child: Text(
          '$count $label',
          style: const TextStyle(fontSize: 14),
        ),
      ),
    );
  }
}