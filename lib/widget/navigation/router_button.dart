import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RouteButton extends StatelessWidget {
  final String label;
  final String targetRoute;

  const RouteButton({
    super.key,
    required this.label,
    required this.targetRoute,
  });

  @override
  Widget build(BuildContext context) {
    final currentRoute = GoRouterState.of(context).uri.path;
    final isActive = currentRoute == targetRoute;

    return ElevatedButton(
      onPressed: isActive ? null : () => context.go(targetRoute),
      style: ElevatedButton.styleFrom(
        backgroundColor: isActive ? Colors.grey : null,
      ),
      child: Text(label),
    );
  }
}
