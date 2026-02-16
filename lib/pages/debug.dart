// ignore_for_file: unused_element

/* 

This file includes draft codes, rubbish, horrible logics and so on 

*/

import 'package:flutter/material.dart';
import 'package:fucking_math/widget/mistake/mistakes_display.dart';
import 'package:fucking_math/widget/ui_constants.dart';

class Debug extends StatelessWidget {
  const Debug({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text("Debug 页面"),
      actions: [const Text("Warning: 任何按钮都可能导致毁灭性的数据丢失")],
    ),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        spacing: 16,
        children: [
          Expanded(child: _area1()),
          Expanded(child: _area2()),
          Expanded(child: _area3()),
        ],
      ),
    ),
  );

  // ======================= LAYOUT CODES ABOVE =======================

  Widget _area2() => SearchBarApp();
  Widget _area3() => ListView.builder(
    itemCount: 20,
    itemBuilder: (context, index) =>
        ListTile(title: const Text("Title"), subtitle: const Text("Subtitle"),trailing: const Text("trailing"),),
    
  );

  Widget _area1() => MistakesDisplay();

  Widget _buttonAndText({String? text, String? text2, VoidCallback? action}) =>
      Row(
        spacing: 16,
        children: [
          ElevatedButton(onPressed: action, child: Text(text ?? "按钮")),
          Text(text2 ?? "按钮的描述文本"),
        ],
      );
}

class SearchBarApp extends StatefulWidget {
  const SearchBarApp({super.key});

  @override
  State<SearchBarApp> createState() => _SearchBarAppState();
}

class _SearchBarAppState extends State<SearchBarApp> {
  bool isDark = true;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = ThemeData(
      brightness: isDark ? Brightness.dark : Brightness.light,
    );

    return MaterialApp(
      theme: themeData,
      home: Scaffold(
        appBar: AppBar(title: const Text('Search Bar Sample')),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SearchAnchor(
            builder: (BuildContext context, SearchController controller) {
              return SearchBar(
                controller: controller,
                padding: const WidgetStatePropertyAll<EdgeInsets>(
                  EdgeInsets.symmetric(horizontal: 16.0),
                ),
                onTap: () {
                  controller.openView();
                },
                onChanged: (_) {
                  controller.openView();
                },
                leading: const Icon(Icons.search),
                trailing: <Widget>[
                  Tooltip(
                    message: 'Change brightness mode',
                    child: IconButton(
                      isSelected: isDark,
                      onPressed: () {
                        setState(() {
                          isDark = !isDark;
                        });
                      },
                      icon: const Icon(Icons.wb_sunny_outlined),
                      selectedIcon: const Icon(Icons.brightness_2_outlined),
                    ),
                  ),
                ],
              );
            },
            suggestionsBuilder:
                (BuildContext context, SearchController controller) {
                  return List<ListTile>.generate(5, (int index) {
                    final String item = 'item $index';
                    return ListTile(
                      title: Text(item),
                      onTap: () {
                        setState(() {
                          controller.closeView(item);
                        });
                      },
                    );
                  });
                },
          ),
        ),
      ),
    );
  }
}
