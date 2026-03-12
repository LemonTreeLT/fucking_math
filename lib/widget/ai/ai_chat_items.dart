import 'package:flutter/material.dart';
import 'package:fucking_math/ai/types.dart';

Widget buildChatBubble({
  required bool isUser,
  required String content,
  bool isThinking = false,
  bool isLoadingSpinner = false,
}) => Align(
  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
  child: Container(
    margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
    constraints: const BoxConstraints(maxWidth: 600),
    decoration: BoxDecoration(
      color: isUser
          ? Colors.blue[600]!
          : isThinking
              ? Colors.grey[300]!
              : Colors.grey[200]!,
      borderRadius: BorderRadius.circular(12),
    ),
    child: isLoadingSpinner
        ? const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator.adaptive(strokeWidth: 2),
          )
        : SelectableText(
            content,
            style: TextStyle(
              color: isUser ? Colors.white : Colors.black87,
              fontStyle: isThinking ? FontStyle.italic : FontStyle.normal,
            ),
          ),
  ),
);

Widget buildToolRow(String content, void Function(String) onExpand) => Container(
  margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
  decoration: BoxDecoration(
    border: Border(
      top: BorderSide(color: Colors.grey.shade300),
      bottom: BorderSide(color: Colors.grey.shade300),
    ),
  ),
  padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
  child: Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      const Icon(Icons.build_outlined, size: 14, color: Colors.teal),
      const SizedBox(width: 6),
      Expanded(
        child: SelectableText(
          content.length > 120 ? '${content.substring(0, 120)}...' : content,
          style: const TextStyle(
            fontSize: 12,
            fontFamily: 'monospace',
            color: Colors.black87,
          ),
        ),
      ),
      if (content.length > 120)
        TextButton(
          onPressed: () => onExpand(content),
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: const Size(40, 24),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: const Text('展开', style: TextStyle(fontSize: 12)),
        ),
    ],
  ),
);

Widget buildMessageActions(
  Message msg, {
  required bool isLoading,
  required void Function(Message) onDelete,
  required void Function(Message) onDeleteFromHere,
  required void Function(Message) onRegenerate,
}) {
  if (isLoading) return const SizedBox.shrink();
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (msg.role == Roles.assistant)
          _actionBtn(Icons.refresh, '重新生成', () => onRegenerate(msg)),
        _actionBtn(Icons.delete_outline, '删除此条', () => onDelete(msg)),
        _actionBtn(Icons.delete_sweep_outlined, '删除此条及之后', () => onDeleteFromHere(msg)),
      ],
    ),
  );
}

IconButton _actionBtn(IconData icon, String tooltip, VoidCallback onPressed) => IconButton(
  onPressed: onPressed,
  icon: Icon(icon),
  iconSize: 14,
  padding: EdgeInsets.zero,
  constraints: const BoxConstraints(minWidth: 24, minHeight: 24),
  tooltip: tooltip,
);
