import 'package:flutter/material.dart';
import 'package:flutter_color_picker_plus/flutter_color_picker_plus.dart';

class FormBuilders {
  static Widget textField({
    required TextEditingController controller,
    required String labelText,
    String? hintText,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: const OutlineInputBorder(),
      ),
      validator: validator,
      maxLines: maxLines,
    );
  }

  static Widget enumDropdown<T extends Enum>({
    required String label,
    required List<T> items,
    required ValueChanged<T?> onChanged,
    T? initialValue,
    Key? key,
  }) {
    return DropdownButtonFormField<T?>(
      key: key,
      initialValue: initialValue,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      items: [
        const DropdownMenuItem(value: null, child: Text("None")),
        ...items.map((e) => DropdownMenuItem(
          value: e,
          child: Text(e.name),
        )),
      ],
    );
  }

  static Widget colorPicker({
    required BuildContext context,
    required Color currentColor,
    required ValueChanged<Color> onColorChanged,
  }) {
    return InkWell(
      onTap: () => _showColorPickerDialog(
        context,
        currentColor,
        onColorChanged,
      ),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.grey),
        ),
        child: Row(
          children: [
            const SizedBox(width: 16),
            const Text('点击编辑颜色'),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: currentColor,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Future<void> _showColorPickerDialog(
    BuildContext context,
    Color initialColor,
    ValueChanged<Color> onColorChanged,
  ) async {
    Color pickedColor = initialColor;
    return showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('选择颜色'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: pickedColor,
            onColorChanged: (color) => pickedColor = color,
          ),
        ),
        actions: [
          ElevatedButton(
            child: const Text('确定'),
            onPressed: () {
              onColorChanged(pickedColor);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
