import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ShellScreen extends StatelessWidget {
  const ShellScreen({
    super.key,
    required this.child,
    required this.title,
    required this.path,
  });

  final Widget child;
  final String? title;
  final String path;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // 导航栏
        NavigationRail(
          selectedIndex: _getSelectedIndex(),
          onDestinationSelected: (index) {
            switch (index) {
              case 0:
                context.go('/home');
              case 1:
                context.go('/english');
              case 2:
                context.go('/debug');
            }
          },
          labelType: NavigationRailLabelType.all,
          destinations: const [
            NavigationRailDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: Text('主页'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.abc),
              selectedIcon: Icon(Icons.abc_outlined),
              label: Text('英语'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.developer_mode),
              selectedIcon: Icon(Icons.developer_mode_outlined),
              label: Text('调试'),
            ),
          ],
        ),

        const VerticalDivider(thickness: 1, width: 1),
        Expanded(child: child),
      ],
    );
  }

  int _getSelectedIndex() {
    if (path.startsWith('/home')) return 0;
    if (path.startsWith('/english')) return 1;
    if (path.startsWith('/debug')) return 2;
    return 0;
  }
}
