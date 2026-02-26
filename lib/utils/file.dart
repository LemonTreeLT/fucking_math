import 'dart:io';

import 'package:path/path.dart' as p;

class FileHelper {
  /// 将一个路径分离为所在目录与文件名
  static ({String? path, String? name}) separatePath(String fullPath) {
    if (fullPath.trim().isEmpty) return (path: null, name: null);

    final directory = p.dirname(fullPath);
    final fileName = p.basename(fullPath);

    // 逻辑处理：
    // 1. 如果 dirname 返回 "."，说明输入路径中没有目录分隔符（只是个文件名）
    // 2. 如果 basename 为空，说明路径以分隔符结尾（是个目录路径）

    final String? finalDir =
        (directory == '.' && !fullPath.contains(p.separator))
        ? null
        : directory;

    final String? finalName = fileName.isEmpty ? null : fileName;
    return (path: finalDir, name: finalName);
  }

  static bool isValidAbsolutePath(String input) {
    String path = input.trim();
    if (path.isEmpty) return false;

    // 1. 获取当前平台的路径处理上下文
    // Windows 使用 p.windows, Android/iOS/macOS 使用 p.posix
    final context = Platform.isWindows ? p.windows : p.posix;

    // 2. 首先检查格式上是否为绝对路径
    // 它能识别 C:\, \\Server\Share (Windows) 和 / (POSIX)
    if (!context.isAbsolute(path)) {
      return false;
    }

    // 3. 校验非法字符
    // 即使格式是绝对的，字符也可能非法，例如 "C:\<Invalid>"
    if (Platform.isWindows) {
      return _checkWindowsValidity(path, context);
    } else {
      return _checkPosixValidity(path);
    }
  }

  static bool _checkWindowsValidity(String path, p.Context context) {
    // Windows 非法字符（不含冒号，因为绝对路径必含冒号）
    final illegalChars = RegExp(r'[<>"|?*]');
    if (illegalChars.hasMatch(path)) return false;

    // 检查冒号：除了盘符位(C:)，其他地方不能有冒号
    // 比如 "C:\Data:Stream" 是非法的
    final parts = path.split(':');
    if (parts.length > 2) return false; // 超过一个冒号必错

    // 检查 Windows 保留设备名 (CON, NUL, AUX 等)
    final pathParts = context.split(path);
    final reserved = {
      'CON', 'PRN', 'AUX', 'NUL', 'COM1', 'COM2',
      'COM3', 'COM4', 'COM5', 'COM6', 'COM7', 'COM8', 'COM9',
      'LPT1', 'LPT2', 'LPT3', 'LPT4', 'LPT5', 'LPT6', 'LPT7',
      'LPT8', 'LPT9', // 内置
    };

    for (var part in pathParts) {
      // 提取文件名（去除扩展名并转大写）
      final name = p.basenameWithoutExtension(part).toUpperCase();
      if (reserved.contains(name)) return false;
    }

    return true;
  }

  static bool _checkPosixValidity(String path) {
    // POSIX 极其简单：只要不包含 Null 字符 (\x00) 即可
    // 因为正斜杠 / 已经被 context.isAbsolute 校验过了
    return !path.contains('\x00');
  }
}

class TomlEditor {
  static Future<void> updateValue({
    required File file,
    required String section,
    required String key,
    required String newValue,
  }) async {
    if (!await file.exists()) {
      // 如果文件都不存在，直接创建并写入
      await file.writeAsString(
        '[$section]\n$key = ${_formatValue(newValue)}\n',
      );
      return;
    }

    final lines = await file.readAsLines();
    final List<String> output = [];

    int sectionHeaderIndex = -1; // 目标 Section 开始的行索引
    int nextSectionIndex = -1; // 下一个 Section 开始的行索引
    int keyIndex = -1; // 目标 Key 所在的行索引

    // 1. 第一遍扫描：确定结构
    final sectionPattern = RegExp(
      r'^\s*\[\s*' + RegExp.escape(section) + r'\s*\]',
    );
    final anySectionPattern = RegExp(r'^\s*\[.*\]');
    final keyPattern = RegExp(r'^\s*' + RegExp.escape(key) + r'\s*=');

    for (int i = 0; i < lines.length; i++) {
      String trimmed = lines[i].trim();

      // 寻找目标 Section
      if (sectionHeaderIndex == -1 && sectionPattern.hasMatch(trimmed)) {
        sectionHeaderIndex = i;
        continue;
      }

      // 如果已经进入了目标 Section
      if (sectionHeaderIndex != -1) {
        // 寻找目标 Key (且还没找到过)
        if (keyIndex == -1 && keyPattern.hasMatch(trimmed)) {
          keyIndex = i;
        }
        // 寻找下一个 Section 的开始
        if (nextSectionIndex == -1 && anySectionPattern.hasMatch(trimmed)) {
          nextSectionIndex = i;
        }
      }
    }

    // 2. 第二遍处理：根据扫描结果重组内容
    String formattedValue = _formatValue(newValue);

    if (sectionHeaderIndex != -1 && keyIndex != -1) {
      // --- 情况 1: Section 和 Key 都存在 -> 修改 ---
      for (int i = 0; i < lines.length; i++) {
        if (i == keyIndex) {
          // 保留原有的缩进，只替换等号后面的部分
          final prefix = lines[i].split('=')[0];
          output.add('$prefix= $formattedValue');
        } else {
          output.add(lines[i]);
        }
      }
    } else if (sectionHeaderIndex != -1 && keyIndex == -1) {
      // --- 情况 2: Section 存在，但 Key 不存在 -> 插入 ---
      // 插入点：如果有下一个 Section，就插在它前面；否则插在文件末尾
      int insertPoint = (nextSectionIndex != -1)
          ? nextSectionIndex
          : lines.length;

      for (int i = 0; i < lines.length; i++) {
        if (i == insertPoint) {
          output.add('$key = $formattedValue');
        }
        output.add(lines[i]);
      }
      if (insertPoint == lines.length) output.add('$key = $formattedValue');
    } else {
      // --- 情况 3: Section 都不存在 -> 追加 ---
      output.addAll(lines);
      if (output.isNotEmpty && output.last.trim().isNotEmpty) {
        output.add(''); // 补一个空行，美观
      }
      output.add('[$section]');
      output.add('$key = $formattedValue');
    }

    // 3. 写回文件
    await file.writeAsString('${output.join('\n')}\n');
  }

  static String _formatValue(String v) {
    // 简单的类型识别
    if (v == 'true' || v == 'false') return v;
    if (RegExp(r'^-?\d+(\.\d+)?$').hasMatch(v)) return v;
    // 如果已经是引号包裹了，不再加引号
    if ((v.startsWith('"') && v.endsWith('"')) ||
        (v.startsWith("'") && v.endsWith("'"))) {
      return v;
    }
    return "'$v'";
  }
}
