import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:fucking_math/configs/config.dart';

class Debug extends StatelessWidget {
  const Debug({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'File Picker & Drop Demo',
      theme: Config.darkTheme,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 使用 cross_file 包中的 XFile，因为 desktop_drop 返回的是 XFile
  // file_picker 获取的路径也可以轻松转换为 XFile
  bool _isDragging = false; // 用于控制拖拽时的 UI 效果
  File? _selectedFile;

  /// 使用 file_picker 库来选择文件
  Future<void> _pickFile() async {
    // 允许的文件类型仅为图片
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null && result.files.single.path != null) {
      // 将获取到的文件路径转换为 XFile 对象并更新状态
      final path = result.files.single.path!;
      setState(() {
        _selectedFile = File(path);
      });
      _showFileDetails(File(path));
    } else {
      // 用户取消了选择
      debugPrint("用户取消了文件选择");
    }
  }

  /// 文件拖拽完成后的回调
  void _onDragDone(DropDoneDetails details) {
    // details.files 是一个 XFile 列表
    if (details.files.isNotEmpty) {
      // 简单起见，我们只处理第一个文件
      // 你可以根据需求检查文件类型，例如检查后缀名
      final file = details.files.first;
      if (_isImageFile(file.path)) {
        setState(() {
          _selectedFile = File(file.path);
          // _isDragging = false;
        });
        _showFileDetails(File(file.path));
      } else {
        // 如果不是图片文件，可以给用户一个提示
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("请拖拽图片文件！")));
        setState(() {
          // _isDragging = false;
        });
      }
    }
  }

  /// 简单的辅助函数，通过文件后缀名判断是否为图片
  bool _isImageFile(String path) {
    final lowerCasePath = path.toLowerCase();
    return lowerCasePath.endsWith('.jpg') ||
        lowerCasePath.endsWith('.jpeg') ||
        lowerCasePath.endsWith('.png') ||
        lowerCasePath.endsWith('.gif') ||
        lowerCasePath.endsWith('.bmp') ||
        lowerCasePath.endsWith('.webp');
  }

  /// 显示获取到的文件信息（用于演示）
  void _showFileDetails(File file) {
    debugPrint("获取到文件:");
    debugPrint("  路径 (Path): ${file.path}");
    // 在这里，你可以调用你已有的展示逻辑，例如：
    // yourDisplayFunction(File(file.path));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('文件选择与拖拽上传')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // 使用 DropTarget 包装你的拖拽区域
            DropTarget(
              onDragDone: _onDragDone,
              onDragEntered: (detail) {
                setState(() {
                  _isDragging = true;
                });
              },
              onDragExited: (detail) {
                setState(() {
                  _isDragging = false;
                });
              },
              child: Container(
                width: 400,
                height: 250,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: _isDragging
                        ? Colors.blue.shade300
                        : Colors.grey.shade400,
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  color: _isDragging
                      ? Colors.blue.withOpacity(0.1)
                      : Colors.transparent,
                ),
                child: const Center(
                  child: Text(
                    "将图片文件拖拽到此处",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Text("或者", style: TextStyle(fontSize: 16)),
            const SizedBox(height: 20),

            // 用于触发 file_picker 的按钮
            ElevatedButton.icon(
              icon: const Icon(Icons.folder_open),
              label: const Text('选择图片文件'),
              onPressed: _pickFile,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 15,
                ),
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),

            const SizedBox(height: 40),

            // 显示已选择文件的信息
            if (_selectedFile != null)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "当前选择的文件:",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _selectedFile!.path,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                      ), // 等宽字体更适合显示路径
                    ),
                    // 在这里，你可以直接使用 `_selectedFile` 来展示图片
                    // 比如: Image.file(File(_selectedFile!.path))
                  ],
                ),
              )
            else
              const Text("尚未选择任何文件"),
          ],
        ),
      ),
    );
  }
}
