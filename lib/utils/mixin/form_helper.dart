import 'package:flutter/material.dart';

mixin FormClearable<T extends StatefulWidget> on State<T> {
  List<TextEditingController> get controllers;
  Set<int>? get tagSelection => null;

  void clearForm() {
    for (var controller in controllers) {
      controller.clear();
    }
    if (tagSelection != null) {
      setState(() => tagSelection!.clear());
    }
  }
}

