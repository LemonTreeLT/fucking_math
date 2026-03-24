import 'package:flutter/material.dart';
import 'package:fucking_math/ai/types.dart';

class AiChatHistoryButton extends StatefulWidget {
  const AiChatHistoryButton({
    super.key,
    required this.sessions,
    required this.currentSessionId,
    required this.enabled,
    required this.onNewSession,
    required this.onLoadSession,
    required this.onRename,
    required this.onDelete,
  });

  final List<Session> sessions;
  final int? currentSessionId;
  final bool enabled;
  final VoidCallback onNewSession;
  final void Function(int sessionId) onLoadSession;
  final Future<void> Function(Session session, String newTitle) onRename;
  final Future<void> Function(Session session) onDelete;

  @override
  State<AiChatHistoryButton> createState() => AiChatHistoryButtonState();
}

class AiChatHistoryButtonState extends State<AiChatHistoryButton>
    with SingleTickerProviderStateMixin {
  // ──────────────── Layout ────────────────

  @override
  Widget build(BuildContext context) => CompositedTransformTarget(
    link: _layerLink,
    child: IconButton(
      icon: const Icon(Icons.history),
      style: IconButton.styleFrom(shape: const CircleBorder()),
      onPressed: widget.enabled ? toggle : null,
    ),
  );

  Widget _buildOverlay() {
    final animation = CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut);
    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: hide,
          ),
        ),
        CompositedTransformFollower(
          link: _layerLink,
          targetAnchor: Alignment.bottomLeft,
          followerAnchor: Alignment.topLeft,
          offset: const Offset(0, 4),
          child: AnimatedBuilder(
            animation: animation,
            builder: (ctx, child) => FadeTransition(
              opacity: animation,
              child: ScaleTransition(
                scale: Tween(begin: 0.85, end: 1.0).animate(animation),
                alignment: Alignment.topLeft,
                child: child,
              ),
            ),
            child: Material(
              elevation: 6,
              borderRadius: BorderRadius.circular(12),
              child: ConstrainedBox(
                constraints: const BoxConstraints(minWidth: 240, maxWidth: 320),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: const Icon(Icons.add),
                      title: const Text('新建对话'),
                      onTap: () {
                        hide();
                        widget.onNewSession();
                      },
                    ),
                    const Divider(height: 1),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxHeight: 280),
                      child: widget.sessions.isEmpty
                          ? const Padding(
                              padding: EdgeInsets.all(16),
                              child: Text('暂无历史对话',
                                  style: TextStyle(color: Colors.grey)),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: widget.sessions.length,
                              itemBuilder: (ctx, i) =>
                                  _buildSessionTile(widget.sessions[i]),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSessionTile(Session s) => ListTile(
    selected: s.id == widget.currentSessionId,
    leading: const Icon(Icons.chat_bubble_outline),
    title: Text(
      s.title?.isNotEmpty == true ? s.title! : '对话 #${s.id}',
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    ),
    trailing: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.edit, size: 18),
          visualDensity: VisualDensity.compact,
          onPressed: () => _showRenameDialog(s),
        ),
        IconButton(
          icon: const Icon(Icons.delete, size: 18),
          visualDensity: VisualDensity.compact,
          onPressed: () => _showDeleteDialog(s),
        ),
      ],
    ),
    onTap: () {
      hide();
      widget.onLoadSession(s.id!);
    },
  );

  // ============ LAYOUT CODES ABOVE ============

  final _layerLink = LayerLink();
  late final AnimationController _animCtrl;
  OverlayEntry? _overlay;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
  }

  @override
  void dispose() {
    _hideOverlay();
    _animCtrl.dispose();
    super.dispose();
  }

  void toggle() => _overlay != null ? hide() : show();

  void show() {
    _animCtrl.forward(from: 0);
    _overlay = OverlayEntry(builder: (_) => _buildOverlay());
    Overlay.of(context).insert(_overlay!);
  }

  void hide() => _hideOverlay();

  void _hideOverlay() {
    _overlay?.remove();
    _overlay = null;
  }

  Future<void> _showRenameDialog(Session s) async {
    final ctrl = TextEditingController(text: s.title ?? '');
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('重命名对话'),
        content: TextField(
          controller: ctrl,
          autofocus: true,
          decoration: const InputDecoration(
            labelText: '对话名称',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('确认'),
          ),
        ],
      ),
    );
    if (confirmed == true && s.id != null) {
      await widget.onRename(s, ctrl.text.trim());
    }
    ctrl.dispose();
  }

  Future<void> _showDeleteDialog(Session s) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('删除对话'),
        content: Text('确认删除"${s.title ?? '对话 #${s.id}'}"？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('取消'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('删除'),
          ),
        ],
      ),
    );
    if (confirmed == true) await widget.onDelete(s);
  }
}
