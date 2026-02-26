import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fucking_math/configs/config.dart';
import 'package:fucking_math/utils/file.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<StatefulWidget> createState() => _SettingState();
}

class _SettingState extends State<Settings> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text("User Setting"),
      actions: [const Text("Any change require restart app")],
    ),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Column(
            children: [
              Form(key: _formKey, child: _buildDbPathInputer()),
              const Spacer(),
              _buildActionButtons(),
            ],
          ),
        ],
      ),
    ),
  );

  final _pathInputerController = TextEditingController();

  Widget _buildDbPathInputer() => Card(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          const Text("Database Config"),
          Row(
            mainAxisAlignment: .center,
            children: [
              SizedBox(
                width: 260,
                child: TextFormField(
                  controller: _pathInputerController,
                  decoration: InputDecoration(hintText: "Type path"),
                  validator: (text) =>
                      text != null && FileHelper.isValidAbsolutePath(text)
                      ? null
                      : "Input must be a path",
                ),
              ),
              IconButton(onPressed: _pickFile, icon: Icon(Icons.upload)),
            ],
          ),
        ],
      ),
    ),
  );

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null || result.files.isEmpty) return; // Cancel select

    final path = result.files.first.path;
    if (path == null) return;

    _pathInputerController.text = result.files.first.path ?? "";
  }

  Widget _buildActionButtons() => Row(
    spacing: 4,
    children: [
      ElevatedButton.icon(
        onPressed: saveConfig,
        label: const Text("Save"),
        icon: Icon(Icons.save),
      ),
      ElevatedButton.icon(
        onPressed: restoreConfig,
        label: const Text("Restore"),
        icon: Icon(Icons.restore),
      ),
    ],
  );

  // TODO 实现还原配置功能
  Future<void> restoreConfig() async {}

  Future<void> saveConfig() async {
    if (!_formKey.currentState!.validate()) return;

    final pathInfo = FileHelper.separatePath(
      _pathInputerController.text.trim(),
    );

    if (pathInfo.name != null) await Config.saveDbNameConfig(pathInfo.name!);
    if (pathInfo.path != null) await Config.saveDbPathConfig(pathInfo.path!);
    print("name: ${pathInfo.name} path: ${pathInfo.path}");
  }

  @override
  void dispose() {
    _pathInputerController.dispose();
    super.dispose();
  }
}
