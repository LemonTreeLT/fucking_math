import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'debug.dart';
import 'home.dart';
import 'english_learning.dart';
import 'shell_screen.dart';

final _shellNavigatorKey = GlobalKey<NavigatorState>();
final GoRouter appRouter = GoRouter(
  initialLocation: '/home',

  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => ShellScreen(
        title: state.topRoute?.name,
        path: state.uri.toString(),
        child: child,
      ),
      routes: [
        GoRoute(
          path: "/home",
          name: "首页",
          builder: (context, state) => const Home(),
        ),
        GoRoute(
          path: "/english",
          name: '英语相关',
          builder: (context, state) => const English(),
        ),
        GoRoute(
          path: "/debug",
          name: '调试页面',
          builder: (context, state) => const Debug(),
        ),
      ],
    ),
  ],
  errorBuilder: (context, state) => const ErrorScreen(),
);

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('404 页面未找到', style: TextStyle(color: Colors.red)),
      ),
    );
  }
}
