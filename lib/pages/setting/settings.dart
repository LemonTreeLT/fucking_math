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
            children: [_buildDbPathInputer(), _buildGlobalResPathInputer()],
          ),
        ],
      ),
    ),
  );

  String? _pathValidator(String? text) =>
      text != null && FileHelper.isValidAbsolutePath(text)
      ? null
      : "Input must be a path";

  // ================= DATABASE CONFIG START =================

  final _databasePathInputerController = TextEditingController();
  final _dbFormKey = GlobalKey<FormState>();

  Widget _buildDbPathInputer() => Form(
    key: _dbFormKey,
    child: _getGenLabelAndInputerCard(
      labelHint: "Database Config",
      inputHint: "Type path",
      controller: _databasePathInputerController,
      onFileResultGet: _pickDatabaseFile,
      validator: _pathValidator,
      onSave: _saveDbConfig,
    ),
  );

  Future<void> _pickDatabaseFile() async =>
      _databasePathInputerController.text = await _pickFileRequest() ?? "";

  Future<void> _saveDbConfig() async {
    if (!_dbFormKey.currentState!.validate()) return;

    final pathInfo = FileHelper.separatePath(
      _databasePathInputerController.text.trim(),
    );

    if (pathInfo.name != null) await Config.saveDbNameConfig(pathInfo.name!);
    if (pathInfo.path != null) await Config.saveDbPathConfig(pathInfo.path!);
  }

  // ================= DATABASE CONFIG END =================

  // ================= GLOBAL RES PATH CONFIG START =================
  final _globalResPathInputerController = TextEditingController();
  final _globalResFormKey = GlobalKey<FormState>();

  Widget _buildGlobalResPathInputer() => Form(
    key: _globalResFormKey,
    child: _getGenLabelAndInputerCard(
      labelHint: "Global Res Path",
      inputHint: "Type path",
      controller: _globalResPathInputerController,
      validator: _pathValidator,
      onFileResultGet: _pickGlobal,
      onSave: _saveGlobalResConfig,
    ),
  );

  Future<void> _pickGlobal() async =>
      _globalResPathInputerController.text = await _pickFileRequest() ?? "";

  Future<void> _saveGlobalResConfig() async {
    if (!_globalResFormKey.currentState!.validate()) return;
    Config.saveGlobalResPath(_globalResPathInputerController.text.trim());
  }

  // ================= GLOBAL RES PATH CONFIG START =================

  /// 一个通用的 文字label + 输入框 + 按钮的布局组件
  Widget _getGenLabelAndInputerCard({
    required String labelHint,
    required String inputHint,
    required TextEditingController controller,
    String? Function(String?)? validator,
    void Function()? onSave,
    void Function()? onFileResultGet,
  }) => _getGenSettingCard(
    hint: labelHint,
    child: Row(
      mainAxisAlignment: .center,
      children: [
        SizedBox(
          width: 260,
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(hintText: inputHint),
            validator: validator,
          ),
        ),
        if (onFileResultGet != null)
          IconButton(onPressed: onFileResultGet, icon: Icon(Icons.upload)),
        if (onSave != null)
          IconButton(onPressed: onSave, icon: Icon(Icons.save)),
      ],
    ),
  );

  /// 一个通用的 Column 结构，上方是label，下方是 自定义child
  Widget _getGenSettingCard({required String hint, required Widget child}) =>
      Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: .start,
            children: [Text(hint), child],
          ),
        ),
      );

  Future<String?> _pickFileRequest() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null || result.files.isEmpty) return null; // Cancel select

    final path = result.files.first.path;
    if (path == null) return null;
    return result.files.first.path;
  }

  @override
  void dispose() {
    _databasePathInputerController.dispose();
    _globalResPathInputerController.dispose();
    super.dispose();
  }
}
