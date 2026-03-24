import 'package:flutter/material.dart';
import 'package:fucking_math/ai/types.dart';
import 'package:fucking_math/widget/ai/ai_chat_items.dart';

class AiChatMessageList extends StatelessWidget {
  const AiChatMessageList({
    super.key,
    required this.messages,
    required this.isLoading,
    required this.canRegenerate,
    required this.scrollController,
    required this.onRegenerate,
    required this.onDelete,
    required this.onDeleteFromHere,
    required this.onRegenerateFrom,
    required this.onShowContent,
    required this.onEdit,
  });

  final List<Message> messages;
  final bool isLoading;
  final bool canRegenerate;
  final ScrollController scrollController;
  final VoidCallback onRegenerate;
  final void Function(Message) onDelete;
  final void Function(Message) onDeleteFromHere;
  final void Function(Message) onRegenerateFrom;
  final void Function(String) onShowContent;
  final void Function(Message) onEdit;

  @override
  Widget build(BuildContext context) {
    final visible = messages
        .where((m) => !(m.role == Roles.assistant && m.content.trim().isEmpty))
        .toList();

    return ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount:
          visible.length + (isLoading ? 1 : 0) + (!isLoading && canRegenerate ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == visible.length && isLoading) {
          return buildChatBubble(
            isUser: false,
            content: '',
            isLoadingSpinner: true,
            context: context,
          );
        }
        if (index == visible.length && canRegenerate) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: TextButton.icon(
                onPressed: onRegenerate,
                icon: const Icon(Icons.refresh),
                label: const Text('重新生成'),
              ),
            ),
          );
        }
        final msg = visible[index];
        final actions = buildMessageActions(
          msg,
          isLoading: isLoading,
          onDelete: onDelete,
          onDeleteFromHere: onDeleteFromHere,
          onRegenerate: onRegenerateFrom,
          onEdit: onEdit,
        );
        final alignment = (msg.role == Roles.user || msg.role == Roles.tool)
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start;

        return Column(
          crossAxisAlignment: alignment,
          children: [
            if (msg.role == Roles.tool)
              buildToolRow(msg.content, onShowContent, context, actions)
            else
              Column(
                crossAxisAlignment: alignment,
                children: [
                  buildChatBubble(
                    isUser: msg.role == Roles.user,
                    content: msg.content,
                    context: context,
                    images: msg.images,
                  ),
                  actions,
                ],
              ),
          ],
        );
      },
    );
  }
}
