import 'package:flutter/material.dart';

final boxW16 = const SizedBox(width: 16);
final boxH16 = const SizedBox(height: 16);
final border = const OutlineInputBorder();
final grey = Colors.grey.shade800;

/// 开发中的占位组件
final dev = Container(
  padding: EdgeInsets.all(16),
  decoration: BoxDecoration(
    border: Border.all(color: grey),
    borderRadius: BorderRadius.circular(8),
  ),
  child: Center(child: const Text("IN DEVING")),
);