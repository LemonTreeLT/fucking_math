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
    bool noneOption = true,
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
        if (noneOption)
          const DropdownMenuItem(value: null, child: Text("None")),
        ...items.map((e) => DropdownMenuItem(value: e, child: Text(e.name))),
      ],
    );
  }

  static Widget colorPicker({
    required BuildContext context,
    required Color currentColor,
    required ValueChanged<Color> onColorChanged,
  }) {
    return InkWell(
      onTap: () =>
          _showColorPickerDialog(context, currentColor, onColorChanged),
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

  static Widget deleteObject({
    required void Function() delete,
    String labelText = "删除",
  }) {
    return _DeleteButton(onDelete: delete, labelText: labelText);
  }
}

class _DeleteButton extends StatefulWidget {
  final void Function() onDelete;
  final String labelText;

  const _DeleteButton({required this.onDelete, required this.labelText});

  @override
  State<_DeleteButton> createState() => _DeleteButtonState();
}

class _DeleteButtonState extends State<_DeleteButton> {
  final MenuController _menuController = MenuController();

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      controller: _menuController,
      menuChildren: [
        MenuItemButton(
          onPressed: () {
            widget.onDelete();
            _menuController.close();
          },
          child: const Row(
            children: [
              Icon(Icons.check, color: Colors.red, size: 20),
              SizedBox(width: 8),
              Text('确认删除', style: TextStyle(color: Colors.red)),
            ],
          ),
        ),
        MenuItemButton(
          onPressed: () {
            _menuController.close();
          },
          child: const Row(
            children: [
              Icon(Icons.close, size: 20),
              SizedBox(width: 8),
              Text('取消'),
            ],
          ),
        ),
      ],
      builder: (context, controller, child) {
        return ElevatedButton.icon(
          onPressed: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
          icon: const Icon(Icons.delete),
          label: Text(widget.labelText),
          style: ElevatedButton.styleFrom(foregroundColor: Colors.red),
        );
      },
    );
  }
}
