import 'package:flutter/material.dart';
import 'package:fucking_math/widget/mistake/answer_edit.dart';

class Debug extends StatelessWidget {
  const Debug({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Layout Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter 布局示例')),
      body: Column(
        children: [
          // 区域1 - 上部分（自适应高度）
          Container(
            color: Colors.blue.shade50,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '区域 1',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  maxLines: 1,
                  decoration: const InputDecoration(
                    labelText: '字段 1',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: '字段 2 (多行)',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  maxLines: 1,
                  decoration: const InputDecoration(
                    labelText: '字段 3',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),

          // 区域2 - 下部分（自适应高度，包含Row）
          Expanded(
            child: Container(
              color: Colors.green.shade50,
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Text(
                    '区域 2',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 区域3 - 左侧（占2/3）
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.orange.shade50,
                              border: Border.all(color: Colors.orange),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  '区域 3',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                  ),
                                  height: 60,
                                ),
                                const SizedBox(height: 10),
                                TextFormField(
                                  maxLines: 1,
                                  decoration: const InputDecoration(
                                    labelText: '字段 2',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                TextFormField(
                                  maxLines: 1,
                                  decoration: const InputDecoration(
                                    labelText: '字段 3',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        // 区域4 - 右侧（占1/3）
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.purple.shade50,
                              border: Border.all(color: Colors.purple),
                            ),
                            child: ShowAnswerButtonWithPreview(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 区域5 - 底部按钮行（恒定在最底部）
          Container(
            color: Colors.grey.shade200,
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: () {}, child: const Text('按钮 1')),
                ElevatedButton(onPressed: () {}, child: const Text('按钮 2')),
                ElevatedButton(onPressed: () {}, child: const Text('按钮 3')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
