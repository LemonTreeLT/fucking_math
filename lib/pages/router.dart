import 'package:flutter/material.dart';
import 'package:fucking_math/pages/english_editor.dart';
import 'package:fucking_math/pages/english_learning.dart';
import 'package:go_router/go_router.dart';

import 'debug.dart';
import 'home.dart';
import 'english_home.dart';
import 'shell_screen.dart';

final _shellNavigatorKey = GlobalKey<NavigatorState>();
final _englishNavigatorKey = GlobalKey<NavigatorState>();

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
        ShellRoute(
          navigatorKey: _englishNavigatorKey,
          builder:(context, state, child) => EnglishShell(child: child),

          routes: [
            GoRoute(
              path: '/english/editor',
              name: '编辑器',
              builder: (context, state) => EnglishEditor(),
            ),
            GoRoute(
              path: '/english',
              name: '学习页',
              builder: (context, state) => const EnglishLearning(),
            ),
          ],
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
