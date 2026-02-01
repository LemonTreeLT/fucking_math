import 'dart:io';

import 'package:desktop_drop/desktop_drop.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fucking_math/utils/image.dart';
import 'package:fucking_math/widget/ui_constants.dart';

class ImagesPicker extends StatefulWidget {
  const ImagesPicker({
    super.key,
    required this.selectedImageIDs,
    required this.onSelectionChanged,
    this.horizontal = true,
    this.maxPreviewedImage = 3,
  });

  final bool horizontal;
  final int maxPreviewedImage;
  final List<int> selectedImageIDs;
  final ValueChanged<List<int>> onSelectionChanged;

  @override
  State<StatefulWidget> createState() => _ImagesPickerState();
}

class _ImagesPickerState extends State<ImagesPicker> {
  final List<String> _paths = [];
  bool _isDragging = false;
  @override
  Widget build(BuildContext context) => InkWell(
    onTap: _pickFile,
    child: DropTarget(
      onDragDone: _onDragDone,
      onDragEntered: (d) => setState(() => _isDragging = true),
      onDragExited: (d) => setState(() => _isDragging = false),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(
            color: _isDragging ? Colors.blueAccent : Colors.grey,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: widget.horizontal
            ? Row(children: _mainWidgetList())
            : Column(children: _mainWidgetList()),
      ),
    ),
  );

  List<Widget> _mainWidgetList() => [
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(!_isDragging ? "Uploader Image" : "Release to Upload"),
    ),
    const Spacer(),
    Row(spacing: 8, children: _buildPreviewImageList()),
  ];

  void _onDragDone(DropDoneDetails details) => _paths.addAll(
    details.files
        .where((f) => ImageHelper.isImageFile(f.name.toLowerCase()))
        .map((f) => f.path),
  );

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result != null && result.files.single.path != null) {
      setState(() => _paths.add(result.files.single.path!));
    }
  }

  List<Widget> _buildPreviewImageList() => [
    ..._getPreviewPaths().map((p) => PreviewedImage(imageFile: File(p))),
    if (_isPathsTooLoog()) const Text("..."),
  ];

  List<String> _getPreviewPaths() => _isPathsTooLoog()
      ? _paths.getRange(0, widget.maxPreviewedImage).toList()
      : _paths;

  bool _isPathsTooLoog() => _paths.length >= 4;
}

class PreviewedImage extends StatelessWidget {
  final File? imageFile;
  final double imageWidth;
  final double imageHeight;
  const PreviewedImage({
    super.key,
    this.imageFile,
    this.imageHeight = 30,
    this.imageWidth = 30,
  });

  @override
  Widget build(BuildContext context) => imageFile == null
      ? Container(
          width: imageWidth,
          height: imageHeight,
          color: grey,
          child: const Icon(Icons.image),
        )
      : ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Image.file(
            imageFile!,
            width: imageWidth,
            height: imageHeight,
            fit: BoxFit.cover,
          ),
        );
}

final dev = Container(
  padding: EdgeInsets.all(16),
  decoration: BoxDecoration(
    border: Border.all(color: grey),
    borderRadius: BorderRadius.circular(8),
  ),
  child: Center(child: const Text("IN DEVING")),
);
