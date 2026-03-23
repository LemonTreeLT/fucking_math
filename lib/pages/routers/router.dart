import 'package:flutter/material.dart';
import 'package:fucking_math/pages/router_config.dart';
import 'package:go_router/go_router.dart';

import 'shell_screen.dart';

final _shellNavigatorKey = GlobalKey<NavigatorState>();

StatelessWidget _buildShellScreen(GoRouterState state, Widget child) =>
    ShellScreen(path: state.uri.toString(), child: child);

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: .center,
        children: [
          const Text(
            '404 页面未找到',
            style: TextStyle(color: Colors.red, fontSize: 32),
          ),
          TextButton(
            onPressed: () => context.go("/home"),
            child: const Text("我要回家呜呜呜"),
          ),
        ],
      ),
    ),
  );
}

final GoRouter appRouter = GoRouter(
  initialLocation: '/home',

  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => _buildShellScreen(state, child),
      routes: goRoutes,
    ),
  ],
  errorBuilder: (context, state) => const ErrorScreen(),
);
