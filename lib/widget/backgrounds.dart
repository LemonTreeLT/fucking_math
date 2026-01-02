import 'package:flutter/material.dart';

/// 带顶部标签的边框容器组件
/// 标签文字会嵌入到顶部边框中，形成缺口效果
class BorderedContainerWithTopText extends StatelessWidget {
  // 常量定义
  static const double _defaultGapPadding = 4.0;
  static const double _defaultLabelLeftMargin = 16.0;
  static const double _defaultContentPadding = 12.0;
  static const double _defaultBorderWidth = 1.0;
  static const double _defaultBorderRadius = 8.0;
  static const double _defaultFontSize = 14.0;

  // 基础属性
  final String labelText;
  final Widget child;

  // 布局属性
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  // 样式属性
  final Color borderColor;
  final double borderWidth;
  final double borderRadius;

  // 文字样式
  final TextStyle? labelStyle;
  final double labelLeftMargin;

  const BorderedContainerWithTopText({
    super.key,
    required this.labelText,
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.borderColor = Colors.grey,
    this.borderWidth = _defaultBorderWidth,
    this.borderRadius = _defaultBorderRadius,
    this.labelStyle,
    this.labelLeftMargin = _defaultLabelLeftMargin,
  });

  @override
  Widget build(BuildContext context) {
    final textMetrics = _measureLabelText(context);
    final gapConfig = _calculateGapConfig(textMetrics);

    return Container(
      width: width,
      height: height,
      margin: margin,
      child: Stack(
        fit: _getStackFit(),
        clipBehavior: Clip.none,
        children: [
          _buildBorderedContent(textMetrics.topOffset, gapConfig),
          _buildLabel(textMetrics.style),
        ],
      ),
    );
  }

  /// 测量标签文字尺寸
  _TextMetrics _measureLabelText(BuildContext context) {
    final defaultStyle = DefaultTextStyle.of(context).style;
    final userStyle = labelStyle ??
        TextStyle(
          color: Theme.of(context).textTheme.bodyLarge?.color,
          fontSize: _defaultFontSize,
          fontWeight: FontWeight.bold,
        );

    final finalStyle = defaultStyle.merge(userStyle);
    final maxWidth = _calculateMaxLabelWidth(context);

    final textPainter = TextPainter(
      text: TextSpan(text: labelText, style: finalStyle),
      textDirection: Directionality.of(context),
      textScaler: MediaQuery.of(context).textScaler,
      maxLines: 1,
    )..layout(maxWidth: maxWidth);

    return _TextMetrics(
      width: textPainter.size.width,
      height: textPainter.size.height,
      style: finalStyle,
      topOffset: textPainter.size.height / 2,
    );
  }

  /// 计算标签文字的最大宽度
  double _calculateMaxLabelWidth(BuildContext context) {
    final containerWidth = width ?? MediaQuery.of(context).size.width;
    return containerWidth - labelLeftMargin - _defaultLabelLeftMargin;
  }

  /// 计算缺口配置
  _GapConfig _calculateGapConfig(_TextMetrics metrics) {
    final gapWidth = metrics.width + (_defaultGapPadding * 2);
    final gapStart = labelLeftMargin - _defaultGapPadding;

    return _GapConfig(
      start: gapStart,
      width: gapWidth,
    );
  }

  /// 确定 Stack 的适配方式
  StackFit _getStackFit() {
    return (width != null || height != null) 
        ? StackFit.expand 
        : StackFit.loose;
  }

  /// 构建带边框的内容区域
  Widget _buildBorderedContent(double topOffset, _GapConfig gapConfig) {
    return CustomPaint(
      painter: _HollowBorderPainter(
        borderColor: borderColor,
        borderWidth: borderWidth,
        borderRadius: borderRadius,
        gapStart: gapConfig.start,
        gapWidth: gapConfig.width,
        topOffset: topOffset,
      ),
      child: Padding(
        padding: _calculateContentPadding(topOffset),
        child: child,
      ),
    );
  }

  /// 计算内容区域的内边距
  EdgeInsets _calculateContentPadding(double topOffset) {
    final basePadding = padding as EdgeInsets? ?? 
        const EdgeInsets.all(_defaultContentPadding);
    return basePadding + EdgeInsets.only(top: topOffset);
  }

  /// 构建标签文字
  Widget _buildLabel(TextStyle style) {
    return Positioned(
      top: 0,
      left: labelLeftMargin,
      child: Text(
        labelText,
        style: style,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

/// 文字测量结果
class _TextMetrics {
  final double width;
  final double height;
  final TextStyle style;
  final double topOffset;

  const _TextMetrics({
    required this.width,
    required this.height,
    required this.style,
    required this.topOffset,
  });
}

/// 缺口配置
class _GapConfig {
  final double start;
  final double width;

  const _GapConfig({
    required this.start,
    required this.width,
  });
}

/// 自定义边框画笔 - 在顶部留出缺口以容纳标签
class _HollowBorderPainter extends CustomPainter {
  final Color borderColor;
  final double borderWidth;
  final double borderRadius;
  final double gapStart;
  final double gapWidth;
  final double topOffset;

  const _HollowBorderPainter({
    required this.borderColor,
    required this.borderWidth,
    required this.borderRadius,
    required this.gapStart,
    required this.gapWidth,
    required this.topOffset,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    final path = _createBorderPath(size);
    canvas.drawPath(path, paint);
  }

  /// 创建带缺口的边框路径
  Path _createBorderPath(Size size) {
    final path = Path();
    final bounds = _BorderBounds(
      top: topOffset,
      bottom: size.height,
      left: 0,
      right: size.width,
      radius: borderRadius,
    );

    final gapEnd = gapStart + gapWidth;

    // 从缺口右侧开始，顺时针绘制边框
    path.moveTo(gapEnd, bounds.top);

    // 顶部右段 + 右上角
    path.lineTo(bounds.right - bounds.radius, bounds.top);
    path.arcToPoint(
      Offset(bounds.right, bounds.top + bounds.radius),
      radius: Radius.circular(bounds.radius),
    );

    // 右侧 + 右下角
    path.lineTo(bounds.right, bounds.bottom - bounds.radius);
    path.arcToPoint(
      Offset(bounds.right - bounds.radius, bounds.bottom),
      radius: Radius.circular(bounds.radius),
    );

    // 底部 + 左下角
    path.lineTo(bounds.left + bounds.radius, bounds.bottom);
    path.arcToPoint(
      Offset(bounds.left, bounds.bottom - bounds.radius),
      radius: Radius.circular(bounds.radius),
    );

    // 左侧 + 左上角
    path.lineTo(bounds.left, bounds.top + bounds.radius);
    path.arcToPoint(
      Offset(bounds.left + bounds.radius, bounds.top),
      radius: Radius.circular(bounds.radius),
    );

    // 顶部左段到缺口左侧（不闭合路径，保留缺口）
    path.lineTo(gapStart, bounds.top);

    return path;
  }

  @override
  bool shouldRepaint(covariant _HollowBorderPainter oldDelegate) {
    return oldDelegate.borderColor != borderColor ||
        oldDelegate.borderWidth != borderWidth ||
        oldDelegate.borderRadius != borderRadius ||
        oldDelegate.gapStart != gapStart ||
        oldDelegate.gapWidth != gapWidth ||
        oldDelegate.topOffset != topOffset;
  }
}

/// 边框边界信息
class _BorderBounds {
  final double top;
  final double bottom;
  final double left;
  final double right;
  final double radius;

  const _BorderBounds({
    required this.top,
    required this.bottom,
    required this.left,
    required this.right,
    required this.radius,
  });
}
