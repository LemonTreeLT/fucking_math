import 'package:flutter/material.dart';
import 'package:fucking_math/utils/types.dart';

class TagBadge extends StatelessWidget {
  final Tag tag;
  final VoidCallback? onTap;
  final BorderRadius borderRadius;
  final double fontSize;
  final double scale;

  const TagBadge({
    super.key,
    required this.tag,
    this.onTap,
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
    this.fontSize = 12,
    this.scale = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    // 这里的逻辑保持不变，依然清晰
    final badge = _buildBadgeContent();
    final interactiveBadge = _wrapWithInteraction(badge);
    return _wrapWithTooltip(interactiveBadge);
  }

  /// 构建标签内容
  Widget _buildBadgeContent() {
    final bgColor = tag.color != null
        ? Color(tag.color!)
        : Colors.grey.shade300;
    final textColor = _getContrastingTextColor(bgColor);

    return Container(
      // 3. 根据 scale 缩放内边距
      padding: EdgeInsets.symmetric(
        horizontal: 10 * scale,
        vertical: 5 * scale,
      ),
      decoration: BoxDecoration(color: bgColor, borderRadius: borderRadius),
      child: Text(
        tag.name,
        style: TextStyle(
          color: textColor,
          // 4. 根据 scale 缩放字体大小
          fontSize: fontSize * scale,
          fontWeight: FontWeight.w500,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  /// 根据背景色获取对比文字颜色
  Color _getContrastingTextColor(Color bgColor) {
    return ThemeData.estimateBrightnessForColor(bgColor) == Brightness.dark
        ? Colors.white
        : Colors.black87;
  }

  /// 包装交互功能
  Widget _wrapWithInteraction(Widget content) {
    if (onTap == null) return content;
    return ClipRRect(
      borderRadius: borderRadius,
      child: Material(
        color: Colors.transparent,
        child: InkWell(onTap: onTap, child: content),
      ),
    );
  }

  /// 包装 Tooltip
  Widget _wrapWithTooltip(Widget child) {
    final description = tag.description?.trim() ?? '';
    if (description.isEmpty) return child;
    return Tooltip(message: description, child: child);
  }
}
