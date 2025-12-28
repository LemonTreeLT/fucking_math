import 'package:flutter/material.dart';
import 'package:fucking_math/pages/router_config.dart';
import 'package:go_router/go_router.dart';

class ShellScreen extends StatelessWidget {
  const ShellScreen({super.key, required this.child, required this.path});

  final Widget child;
  final String path;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        NavigationRail(
          selectedIndex: _getSelectedIndex(path),
          onDestinationSelected: (index) => context.go(railRoutes[index].path),
          labelType: NavigationRailLabelType.all,
          destinations: railRoutes
              .map(
                (r) => NavigationRailDestination(
                  icon: Icon(r.navIcon),
                  selectedIcon: Icon(r.navSelectedIcon),
                  label: Text(r.navLablel!),
                ),
              )
              .toList(),
        ),

        const VerticalDivider(thickness: 1, width: 1),
        Expanded(child: child),
      ],
    );
  }

  int _getSelectedIndex(String path) {
    final index = railRoutes.indexWhere((route) => path.startsWith(route.path));
    return index == -1 ? 0 : index;
  }
}
