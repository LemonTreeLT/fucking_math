import 'package:flutter/material.dart';
import 'package:fucking_math/pages/debug.dart';
import 'package:fucking_math/pages/english/editor.dart';
import 'package:fucking_math/pages/english/home.dart';
import 'package:fucking_math/pages/english/learning.dart';
import 'package:fucking_math/pages/home.dart';
import 'package:fucking_math/pages/mistakes/editor.dart';
import 'package:fucking_math/pages/mistakes/home.dart';
import 'package:fucking_math/pages/mistakes/practise.dart';
import 'package:fucking_math/pages/knowledge/home.dart';
import 'package:fucking_math/pages/knowledge/editor.dart';
import 'package:fucking_math/pages/knowledge/learning.dart';
import 'package:fucking_math/pages/setting/settings.dart';
import 'package:fucking_math/pages/setting/tags_manager.dart';
import 'package:fucking_math/providers/knowledge_page_state.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

final _englishNavigatorKey = GlobalKey<NavigatorState>();
final _mistakesNavigatorKey = GlobalKey<NavigatorState>();
final _knowledgeNavigatorKey = GlobalKey<NavigatorState>();

final List<RouterConfig> _routesConfig = [
  // 首页
  RouterConfig(
    path: '/home',
    name: '首页',
    builder: (context, state) => const Home(),
    showInNav: true,
    navLablel: '主页',
    navIcon: Icons.home_outlined,
    navSelectedIcon: Icons.home,
  ),
  // 英语模块 (这是一个包含子路由的 Shell)
  RouterConfig(
    // 注意：对于有子路由的 Shell，我们不需要 path 和 builder，
    // 因为它的作用是包裹子路由。但为了结构统一，可以给个虚拟的。
    path: '/english_shell', // 虚拟路径，不会被直接访问
    name: 'English Shell',
    builder: (c, s) => Container(), // 虚拟 builder
    shellBuilder: (context, state, child) => EnglishShell(child: child),
    navigatorKey: _englishNavigatorKey,
    routes: [
      RouterConfig(
        path: '/english',
        name: '学习页',
        builder: (context, state) => const EnglishLearning(),
        // 这一项代表了整个“英语”模块在导航栏中的位置
        showInNav: true,
        navLablel: '英语',
        navIcon: Icons.abc_outlined,
        navSelectedIcon: Icons.abc,
      ),
      RouterConfig(
        path: '/english/editor',
        name: '单词编辑器',
        builder: (context, state) => EnglishEditor(),
        // 这个子页面不在导航栏中直接显示
      ),
    ],
  ),
  // 错题本模块
  RouterConfig(
    path: '/mistakes_shell',
    name: 'Mistakes Shell',
    builder: (c, s) => Container(),
    shellBuilder: (context, state, child) => MistakesHome(child: child),
    navigatorKey: _mistakesNavigatorKey,
    routes: [
      RouterConfig(
        path: '/mistakes',
        name: '错误练习',
        builder: (context, state) => const MistakesPractise(),
        showInNav: true,
        navLablel: '错题本',
        navIcon: Icons.edit_note_outlined,
        navSelectedIcon: Icons.edit_note,
      ),
      RouterConfig(
        path: '/mistakes/editor',
        name: '错误编辑',
        builder: (context, state) => const MistakesEditor(),
      ),
    ],
  ),
  // 知识点模块
  RouterConfig(
    path: '/knowledge_shell',
    name: 'Knowledge Shell',
    builder: (c, s) => Container(),
    shellBuilder: (context, state, child) => KnowledgeShell(child: child),
    navigatorKey: _knowledgeNavigatorKey,
    routes: [
      RouterConfig(
        path: '/knowledge',
        name: '复习知识点',
        builder: (c, s) => const KnowledgeLearning(),
        showInNav: true,
        navLablel: "知识点",
        navIcon: Icons.checklist,
        navSelectedIcon: Icons.checklist_outlined,
      ),
      RouterConfig(
        path: '/knowledge/editor',
        name: '知识点编辑器',
        builder: (c, s) => ChangeNotifierProvider(
          create: (c) => KnowledgePageState(),
          child: const KnowledgeEditor(),
        ),
      ),
    ],
  ),
  RouterConfig(
    path: '/tags',
    name: 'Tag Manager',
    builder: (c, s) => const TagsManager(),
    showInNav: true,
    navLablel: "Tags",
    navIcon: Icons.tag,
    navSelectedIcon: Icons.tag_outlined,
  ),
  RouterConfig(
    path: '/setting',
    name: 'Settings',
    builder: (c, s) => const Settings(),
    showInNav: true,
    navLablel: 'Settings',
    navIcon: Icons.settings,
    navSelectedIcon: Icons.settings_outlined,
  ),
  // 调试页面
  RouterConfig(
    path: '/debug',
    name: '调试页面',
    builder: (context, state) => const Debug(),
    showInNav: true,
    navLablel: '调试',
    navIcon: Icons.bug_report,
    navSelectedIcon: Icons.bug_report_outlined,
  ),
];

// GoRoute 路由生成
final goRoutes = _routesConfig.map((config) => config.toGoRoute()).toList();

// 导航栏配置生成
List<RouterConfig> getNavRailRoutes(List<RouterConfig> routes) {
  final List<RouterConfig> railRoutes = [];
  for (final route in routes) {
    if (route.showInNav) railRoutes.add(route);
    if (route.routes.isNotEmpty) {
      railRoutes.addAll(getNavRailRoutes(route.routes));
    }
  }
  return railRoutes;
}

final railRoutes = getNavRailRoutes(_routesConfig);

// 集合路由类定义
class RouterConfig {
  final String path;
  final String name;
  final Widget Function(BuildContext, GoRouterState) builder;
  // 用于导航栏
  final bool showInNav;
  final String? navLablel;
  final IconData? navIcon;
  final IconData? navSelectedIcon;

  // 管理嵌套路由
  final List<RouterConfig> routes;
  final Widget Function(BuildContext, GoRouterState, Widget)? shellBuilder;
  final GlobalKey<NavigatorState>? navigatorKey;

  RouterConfig({
    required this.path,
    required this.name,
    required this.builder,
    this.showInNav = false,
    this.navLablel,
    this.navIcon,
    this.navSelectedIcon,
    this.routes = const [],
    this.shellBuilder,
    this.navigatorKey,
  }) {
    if (showInNav) {
      assert(navIcon != null, 'navIcon 不能为空');
      assert(navSelectedIcon != null, 'navSelectedIcon 不能为空');
    }
    if (routes.isNotEmpty) {
      assert(shellBuilder != null, 'shellBuilder 不能为空');
      assert(navigatorKey != null, 'navigatorKey 不能为空');
    }
  }

  RouteBase toGoRoute() {
    if (routes.isNotEmpty) {
      return ShellRoute(
        navigatorKey: navigatorKey,
        builder: shellBuilder,
        routes: routes.map((e) => e.toGoRoute()).toList(),
      );
    } else {
      return GoRoute(path: path, name: name, builder: builder);
    }
  }
}
