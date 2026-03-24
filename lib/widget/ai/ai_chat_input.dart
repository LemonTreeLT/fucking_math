import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fucking_math/widget/ai/ai_chat_prompt_overlay.dart';

typedef OnSendMessage = Future<void> Function(
  String text,
  List<({String path, String name})> images,
);

class AiChatInput extends StatefulWidget {
  const AiChatInput({
    super.key,
    required this.isLoading,
    required this.onSend,
    required this.onCancel,
  });

  final bool isLoading;
  final OnSendMessage onSend;
  final VoidCallback onCancel;

  @override
  State<AiChatInput> createState() => _AiChatInputState();
}

class _AiChatInputState extends State<AiChatInput> {
  // ──────────────── Layout ────────────────

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      if (_pendingImages.isNotEmpty) _buildImageStrip(),
      Padding(
        padding: const EdgeInsets.only(top: 8),
        child: CompositedTransformTarget(
          link: _layerLink,
          child: Row(
            spacing: 8,
            children: [
              IconButton(
                icon: const Icon(Icons.attach_file),
                onPressed: widget.isLoading ? null : _pickImages,
              ),
              Expanded(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 120),
                  child: Scrollbar(
                    controller: _scrollCtrl,
                    child: TextField(
                      focusNode: _focusNode,
                      controller: _inputCtrl,
                      scrollController: _scrollCtrl,
                      decoration: const InputDecoration(
                        hintText: '输入消息...',
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                      onSubmitted: (_) =>
                          widget.isLoading ? null : _handleSend(),
                      maxLines: null,
                    ),
                  ),
                ),
              ),
              IconButton.filled(
                onPressed: widget.isLoading ? widget.onCancel : _handleSend,
                icon: Icon(widget.isLoading ? Icons.stop : Icons.send),
              ),
            ],
          ),
        ),
      ),
      AiChatPromptOverlay(
        key: _promptKey,
        inputController: _inputCtrl,
        inputLayerLink: _layerLink,
      ),
    ],
  );

  Widget _buildImageStrip() => SizedBox(
    height: 80,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      itemCount: _pendingImages.length,
      itemBuilder: (ctx, i) => Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 6),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.file(
                File(_pendingImages[i].path),
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stack) =>
                    const Icon(Icons.broken_image, size: 40),
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 6,
            child: GestureDetector(
              onTap: () => setState(
                () => _pendingImages = [..._pendingImages]..removeAt(i),
              ),
              child: Container(
                width: 18,
                height: 18,
                decoration: const BoxDecoration(
                  color: Colors.black54,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.close, size: 12, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    ),
  );

  // ============ LAYOUT CODES ABOVE ============

  late final TextEditingController _inputCtrl;
  late final ScrollController _scrollCtrl;
  late final FocusNode _focusNode;
  final _layerLink = LayerLink();
  final _promptKey = GlobalKey<AiChatPromptOverlayState>();
  List<({String path, String name})> _pendingImages = [];

  @override
  void initState() {
    super.initState();
    _inputCtrl = TextEditingController();
    _scrollCtrl = ScrollController();
    _focusNode = FocusNode(onKeyEvent: _handleKeyEvent);
  }

  @override
  void dispose() {
    _inputCtrl.dispose();
    _scrollCtrl.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  KeyEventResult _handleKeyEvent(FocusNode node, KeyEvent event) =>
      _promptKey.currentState?.handleKeyEvent(node, event) ??
      KeyEventResult.ignored;

  Future<void> _pickImages() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );
    if (result == null) return;
    final picked = result.files
        .where((f) => f.path != null)
        .map((f) => (path: f.path!, name: f.name))
        .toList();
    setState(() => _pendingImages = [..._pendingImages, ...picked]);
  }

  Future<void> _handleSend() async {
    final text = _inputCtrl.text.trim();
    if (text.isEmpty && _pendingImages.isEmpty) return;
    final images = List<({String path, String name})>.from(_pendingImages);
    _inputCtrl.clear();
    setState(() => _pendingImages = []);
    await widget.onSend(text, images);
  }
}
