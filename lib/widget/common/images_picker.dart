import 'dart:io';

import 'package:desktop_drop/desktop_drop.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fucking_math/utils/image.dart';
import 'package:fucking_math/widget/ui_constants.dart';

/// 图片选择器组件
/// 支持点击选择和拖拽上传图片
class ImagesPicker extends StatefulWidget {
  const ImagesPicker({
    super.key,
    this.horizontal = true,
    this.maxPreviewedImage = 3,
    this.height = double.infinity,
    this.width = double.infinity
  });

  /// 是否水平布局
  final bool horizontal;

  /// 最多预览的图片数量
  final int maxPreviewedImage;

  /// 宽度
  final double? width;

  /// 高度
  final double? height;

  @override
  State<StatefulWidget> createState() => ImagesPickerState();
}

class ImagesPickerState extends State<ImagesPicker> {
  /// 存储已选择的图片列表
  List<GenFile> images = [];

  /// 是否正在拖拽中
  bool _isDragging = false;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: _pickFile, // 点击触发文件选择
    child: DropTarget(
      onDragDone: _onDragDone, // 拖拽完成时的回调
      onDragEntered: (d) => setState(() => _isDragging = true), // 拖拽进入区域
      onDragExited: (d) => setState(() => _isDragging = false), // 拖拽离开区域
      child: Container(
        width: widget.width,
        height: widget.height,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(
            // 拖拽时显示蓝色边框，否则显示灰色边框
            color: _isDragging ? Colors.blueAccent : Colors.grey,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        // 根据 horizontal 属性决定使用行布局还是列布局
        child: widget.horizontal
            ? Row(children: _mainWidgetList())
            : Column(children: _mainWidgetList()),
      ),
    ),
  );

  /// 构建主要的 Widget 列表
  List<Widget> _mainWidgetList() => [
    Padding(
      padding: const EdgeInsets.all(8.0),
      // 根据拖拽状态显示不同的提示文本
      child: Text(!_isDragging ? "Upload Image" : "Release to Upload"),
    ),
    const Spacer(),
    // 显示已选择图片的预览列表
    Row(spacing: 8, children: _buildPreviewImageList()),
  ];

  /// 处理拖拽完成事件
  /// 过滤出图片文件并添加到列表中
  void _onDragDone(DropDoneDetails details) => images.addAll(
    details.files
        .where((f) => ImageHelper.isImageFile(f.name.toLowerCase()))
        .map((f) => (path: f.path, name: f.name)),
  );

  /// 打开文件选择器选择图片
  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image, // 只允许选择图片类型
    );
    if (result == null) return; // 用户取消选择

    setState(
      () => images.addAll(
        result.files.map((f) => (path: f.path ?? "", name: f.name)),
      ),
    );
  }

  /// 构建图片预览列表
  List<Widget> _buildPreviewImageList() => [
    // 映射每个图片路径为预览组件
    ..._getPreviewPaths().map((p) => PreviewedImage(imageFile: File(p.path))),
    // 如果图片数量超过最大预览数，显示省略号
    if (_isPathsTooLoog()) const Text("..."),
  ];

  /// 获取需要预览的图片路径列表
  /// 如果图片数量超过最大预览数，只返回前 maxPreviewedImage 个
  List<GenFile> _getPreviewPaths() => _isPathsTooLoog()
      ? images.getRange(0, widget.maxPreviewedImage).toList()
      : images;

  /// 判断图片数量是否超过限制（这里硬编码为4）
  bool _isPathsTooLoog() => images.length >= 4;
}

/// 图片预览组件
class PreviewedImage extends StatelessWidget {
  /// 要预览的图片文件
  final File? imageFile;

  /// 预览图片的宽度
  final double imageWidth;

  /// 预览图片的高度
  final double imageHeight;

  const PreviewedImage({
    super.key,
    this.imageFile,
    this.imageHeight = 30,
    this.imageWidth = 30,
  });

  @override
  Widget build(BuildContext context) => imageFile == null
      // 如果没有图片文件，显示占位符
      ? Container(
          width: imageWidth,
          height: imageHeight,
          color: grey,
          child: const Icon(Icons.image),
        )
      // 显示实际的图片预览
      : ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Image.file(
            imageFile!,
            width: imageWidth,
            height: imageHeight,
            fit: BoxFit.cover, // 填充模式
          ),
        );
}

/// 通用文件类型定义
/// path: 文件路径
/// name: 文件名
typedef GenFile = ({String path, String name});
