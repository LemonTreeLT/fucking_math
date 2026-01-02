import 'package:flutter/material.dart';

Widget textInputer({
  required TextEditingController controller,
  required String labelText,
  String? Function(String?)? validator,
  int? maxLines = 1,
}) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      labelText: labelText,
      border: const OutlineInputBorder(),
    ),
    validator: validator,
    maxLines: maxLines,
  );
}
