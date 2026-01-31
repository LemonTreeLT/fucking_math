import 'package:flutter/material.dart';

// 假设的自定义标签组件
class CustomTag extends StatelessWidget {
  final String text;

  const CustomTag({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.blue.shade100,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.blue.shade400),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 14, color: Colors.blue),
      ),
    );
  }
}

class Debug extends StatelessWidget {
  final List<String> tags = const [
      '标签1', '非常长的标签2', '标签3', '标签4', '标签5', '最后一个标签6'
  ];
  
  const Debug({super.key});

  @override
  Widget build(BuildContext context) {
    const double maxWidth = 250.0;
    
    // 我们需要一个可以容纳和定位 '...' 的容器
    return Scaffold(
      body: Center(
        child: Container(
          width: maxWidth,
          height: 40,
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          
          // 使用 Stack 来实现内容和省略号的叠加
          child: Stack(
            alignment: Alignment.centerLeft,
            clipBehavior: Clip.hardEdge, // 必须开启裁剪
            children: [
              // 1. 内容部分：尝试全部显示
              Row(
                // 这里允许 Row 溢出
                mainAxisSize: MainAxisSize.min, 
                children: tags.map((text) => CustomTag(text: text)).toList(),
              ),
        
              // 2. 覆盖物（用于显示 '...'）：
              // 这是一个渐变遮罩或一个简单的省略号组件
              Positioned(
                right: 0,
                // 使用 LayoutBuilder 确保覆盖物总是粘在父容器的最右侧边界
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    // 假设我们总是显示这个覆盖物，它只会覆盖溢出部分
                    return Container(
                      width: 40, // 覆盖物的宽度
                      height: 40,
                      alignment: Alignment.center,
                      // 这里的颜色应该和背景色一致，以遮盖住被裁剪的 Tag
                      color: Theme.of(context).scaffoldBackgroundColor, 
                      child: const Text('...', style: TextStyle(fontWeight: FontWeight.bold)),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

