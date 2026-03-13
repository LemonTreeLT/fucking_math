import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:fucking_math/ai/types.dart';
import 'package:markdown/markdown.dart' as md;

// Inline syntax for display math: $$...$$
class _DisplayMathSyntax extends md.InlineSyntax {
  _DisplayMathSyntax() : super(r'\$\$([^\$]+)\$\$');

  @override
  bool onMatch(md.InlineParser parser, Match match) {
    parser.addNode(md.Element.text('math-display', match[1]!));
    return true;
  }
}

// Inline syntax for inline math: $...$
class _InlineMathSyntax extends md.InlineSyntax {
  _InlineMathSyntax() : super(r'\$([^\$\n]+)\$');

  @override
  bool onMatch(md.InlineParser parser, Match match) {
    parser.addNode(md.Element.text('math-inline', match[1]!));
    return true;
  }
}

class _MathBuilder extends MarkdownElementBuilder {
  final bool isDisplay;
  _MathBuilder({required this.isDisplay});

  @override
  Widget? visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    return Math.tex(
      element.textContent,
      mathStyle: isDisplay ? MathStyle.display : MathStyle.text,
      onErrorFallback: (err) => Text(
        element.textContent,
        style: preferredStyle?.copyWith(color: Colors.red),
      ),
    );
  }
}

Widget buildChatBubble({
  required bool isUser,
  required String content,
  required BuildContext context,
  bool isThinking = false,
  bool isLoadingSpinner = false,
}) {
  final cs = Theme.of(context).colorScheme;
  return Align(
    alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      constraints: const BoxConstraints(maxWidth: 600),
      decoration: BoxDecoration(
        color: isUser
            ? cs.primary
            : isThinking
                ? cs.surfaceContainerHighest
                : cs.surfaceContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: isLoadingSpinner
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator.adaptive(strokeWidth: 2),
            )
          : MarkdownBody(
              data: content,
              selectable: true,
              styleSheet: MarkdownStyleSheet.fromTheme(
                Theme.of(context),
              ).copyWith(
                p: TextStyle(
                  color: isUser ? cs.onPrimary : cs.onSurface,
                  fontStyle:
                      isThinking ? FontStyle.italic : FontStyle.normal,
                ),
                code: TextStyle(
                  backgroundColor: isUser
                      ? cs.primaryContainer
                      : cs.surfaceContainerHighest,
                  color: isUser ? cs.onPrimaryContainer : cs.onSurface,
                  fontFamily: 'monospace',
                  fontSize: 13,
                ),
              ),
              extensionSet: md.ExtensionSet(
                md.ExtensionSet.gitHubFlavored.blockSyntaxes,
                [
                  _DisplayMathSyntax(),
                  _InlineMathSyntax(),
                  ...md.ExtensionSet.gitHubFlavored.inlineSyntaxes,
                ],
              ),
              builders: {
                'math-display': _MathBuilder(isDisplay: true),
                'math-inline': _MathBuilder(isDisplay: false),
              },
            ),
    ),
  );
}

Widget buildToolRow(
  String content,
  void Function(String) onExpand,
  BuildContext context,
  Widget actionButtons
) {
  final cs = Theme.of(context).colorScheme;

  // Parse "[ToolName]\nresult" format written by AiTaskProcessor
  final newline = content.indexOf('\n');
  final bracketEnd = content.indexOf(']');
  final hasMeta =
      content.startsWith('[') && bracketEnd != -1 && bracketEnd < newline;
  final toolLabel = hasMeta ? content.substring(1, bracketEnd) : 'Tool';
  final body = hasMeta ? content.substring(newline + 1) : content;

  return Container(
    margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
    decoration: BoxDecoration(
      border: Border(
        top: BorderSide(color: cs.outlineVariant),
        bottom: BorderSide(color: cs.outlineVariant),
      ),
    ),
    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(Icons.build_outlined, size: 14, color: cs.primary),
        const SizedBox(width: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: cs.secondaryContainer,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            toolLabel,
            style: TextStyle(
              fontSize: 11,
              color: cs.onSecondaryContainer,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: SelectableText(
            body.length > 120 ? '${body.substring(0, 120)}...' : body,
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'monospace',
              color: cs.onSurface,
            ),
          ),
        ),
        if (body.length > 120)
          TextButton(
            onPressed: () => onExpand(content),
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: const Size(40, 24),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text('展开', style: TextStyle(fontSize: 12)),
          ),
          actionButtons
      ],
    ),
  );
}

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
        _actionBtn(
          Icons.delete_sweep_outlined,
          '删除此条及之后',
          () => onDeleteFromHere(msg),
        ),
      ],
    ),
  );
}

IconButton _actionBtn(
  IconData icon,
  String tooltip,
  VoidCallback onPressed,
) => IconButton(
  onPressed: onPressed,
  icon: Icon(icon),
  iconSize: 14,
  padding: EdgeInsets.zero,
  constraints: const BoxConstraints(minWidth: 24, minHeight: 24),
  tooltip: tooltip,
);
