import 'package:flutter/material.dart';

class BorderedContainerWithTopText extends StatelessWidget {
  final String labelText;
  final Widget child;
  final Color borderColor;
  final double borderWidth;
  final double borderRadius;
  final Color? labelBackgroundColor; // 文字背景色
  final Color? labelTextColor; // 文字颜色
  final double labelPaddingHorizontal; // 文字左右内边距
  final double labelVerticalOffset; // 文字垂直偏移量，用于调整文字在边框上的位置
  const BorderedContainerWithTopText({
    super.key,
    required this.labelText,
    required this.child,
    this.borderColor = Colors.grey,
    this.borderWidth = 1.0,
    this.borderRadius = 8.0,
    this.labelBackgroundColor,
    this.labelTextColor,
    this.labelPaddingHorizontal = 8.0,
    this.labelVerticalOffset = 0.0, // 默认不偏移
  });
  @override
  Widget build(BuildContext context) {
    // 默认文字背景色为 Scaffold 的背景色，以实现“文字镂空”效果
    final effectiveLabelBackgroundColor =
        labelBackgroundColor ?? Theme.of(context).scaffoldBackgroundColor;
    final effectiveLabelTextColor = labelTextColor ?? Theme.of(context).textTheme.bodyLarge?.color;
    return Stack(
      // clipBehavior: Clip.none, // 允许子组件超出 Stack 范围，但在这里不需要，因为文字在内部被定位
      children: [
        // 1. 底部内容和边框
        Container(
          margin: EdgeInsets.only(top: 10 + labelVerticalOffset), // 留出顶部空间给文字
          padding: EdgeInsets.only(
            top: 10 + labelVerticalOffset, // 增加顶部内边距，确保内容不被文字覆盖
            left: 12.0,
            right: 12.0,
            bottom: 12.0,
          ),
          decoration: BoxDecoration(
            border: Border.all(color: borderColor, width: borderWidth),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: child,
        ),
        // 2. 顶部文字
        Positioned(
          top: labelVerticalOffset, // 调整文字的垂直位置
          left: 15.0, // 调整文字的水平位置
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: labelPaddingHorizontal, vertical: 2.0),
            decoration: BoxDecoration(
              color: effectiveLabelBackgroundColor, // 文字背景色，覆盖边框
              borderRadius: BorderRadius.circular(4.0), // 文字背景的圆角
            ),
            child: Text(
              labelText,
              style: TextStyle(
                color: effectiveLabelTextColor,
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}