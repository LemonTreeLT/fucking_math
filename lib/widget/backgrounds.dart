import 'package:flutter/material.dart';

class BorderedContainerWithTopText extends StatelessWidget {
  // 1. 基础属性
  final String labelText;
  final Widget child;

  // 2. 布局属性
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  // 3. 样式属性
  final Color borderColor;
  final double borderWidth;
  final double borderRadius;

  // 4. 文字样式
  final TextStyle? labelStyle;
  final double labelLeftMargin; // 文字距离左边的距离

  const BorderedContainerWithTopText({
    super.key,
    required this.labelText,
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.borderColor = Colors.grey,
    this.borderWidth = 1.0,
    this.borderRadius = 8.0,
    this.labelStyle,
    this.labelLeftMargin = 16.0, // 默认文字离左边框 16px
  });

  @override
  Widget build(BuildContext context) {
    // 1. 准备文字样式
    final effectiveLabelStyle = labelStyle ??
        TextStyle(
          color: Theme.of(context).textTheme.bodyLarge?.color,
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
        );

    // 2. 测量文字宽度 (为了告诉画笔哪里需要“留白”)
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: labelText, style: effectiveLabelStyle),
      textDirection: Directionality.of(context),
      maxLines: 1,
    )..layout();

    final double labelWidth = textPainter.size.width;
    // 文字两边留一点点空隙，看起来不拥挤
    final double gapPadding = 4.0; 
    final double gapWidth = labelWidth + (gapPadding * 2);
    
    // 文字垂直居中于边框线，所以需要计算偏移
    final double labelHeight = textPainter.size.height;
    final double topOffset = labelHeight / 2;

    return Container(
      width: width,
      height: height,
      margin: margin,
      child: Stack(
        // 如果有固定宽高则撑满，否则由子组件决定
        fit: (width != null || height != null) ? StackFit.expand : StackFit.loose,
        clipBehavior: Clip.none, // 允许文字稍微突出一点点（如果需要）
        children: [
          // --- 层级 1: 自定义绘制的边框 ---
          CustomPaint(
            painter: _HollowBorderPainter(
              borderColor: borderColor,
              borderWidth: borderWidth,
              borderRadius: borderRadius,
              gapStart: labelLeftMargin - gapPadding, // 缺口开始位置
              gapWidth: gapWidth,                     // 缺口宽度
              topOffset: topOffset,                   // 边框整体下移半个文字高度
            ),
            child: Padding(
              // 内容的 Padding 需要加上顶部偏移量
              padding: (padding as EdgeInsets? ?? EdgeInsets.all(12.0)) + 
                       EdgeInsets.only(top: topOffset),
              child: child,
            ),
          ),

          // --- 层级 2: 文字组件 ---
          Positioned(
            top: 0, // 紧贴最顶部
            left: labelLeftMargin,
            child: Text(
              labelText,
              style: effectiveLabelStyle,
            ),
          ),
        ],
      ),
    );
  }
}

// --- 核心逻辑: 会跳过缺口的画笔 ---
class _HollowBorderPainter extends CustomPainter {
  final Color borderColor;
  final double borderWidth;
  final double borderRadius;
  final double gapStart;
  final double gapWidth;
  final double topOffset;
  _HollowBorderPainter({
    required this.borderColor,
    required this.borderWidth,
    required this.borderRadius,
    required this.gapStart,
    required this.gapWidth,
    required this.topOffset,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;
    final Path path = Path();
    // 边框的实际边界
    final double top = topOffset;
    final double bottom = size.height;
    final double left = 0;
    final double right = size.width;
    final double radius = borderRadius;
    // 计算缺口结束的位置 (文字右侧)
    final double gapEnd = gapStart + gapWidth;
    // === 开始绘制 ===
    // 逻辑：从缺口的右边开始，顺时针画一圈，最后在缺口的左边结束。
    
    // 1. 移动起点到 [文字右侧]
    path.moveTo(gapEnd, top);
    // 2. 顶部线条 (右半段)：画到右上圆角开始处
    path.lineTo(right - radius, top);
    // 3. 右上角圆角
    path.arcToPoint(
      Offset(right, top + radius),
      radius: Radius.circular(radius),
    );
    // 4. 右侧线条
    path.lineTo(right, bottom - radius);
    // 5. 右下角圆角
    path.arcToPoint(
      Offset(right - radius, bottom),
      radius: Radius.circular(radius),
    );
    // 6. 底部线条
    path.lineTo(left + radius, bottom);
    // 7. 左下角圆角
    path.arcToPoint(
      Offset(left, bottom - radius),
      radius: Radius.circular(radius),
    );
    // 8. 左侧线条
    path.lineTo(left, top + radius);
    // 9. 左上角圆角
    path.arcToPoint(
      Offset(left + radius, top),
      radius: Radius.circular(radius),
    );
    // 10. 顶部线条 (左半段)：画到 [文字左侧] 结束
    path.lineTo(gapStart, top);
    // ⚠️ 重点：千万不要调用 path.close()
    // 因为我们要的就是一个开口的形状，close() 会把终点(文字左侧)和起点(文字右侧)连起来，导致横穿文字。
    canvas.drawPath(path, paint);
  }
  @override
  bool shouldRepaint(covariant _HollowBorderPainter oldDelegate) {
    return oldDelegate.gapWidth != gapWidth ||
           oldDelegate.gapStart != gapStart ||
           oldDelegate.borderColor != borderColor ||
           oldDelegate.size != size; // 监听尺寸变化
  }
  
  // 这是一个好习惯，在尺寸可能变化时通知重绘
  Size? size;
}
