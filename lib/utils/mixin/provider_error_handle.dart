import 'package:flutter/material.dart';

mixin ProviderErrorHandler<T extends StatefulWidget> on State<T> {
  String? _lastError;

  void handleProviderError(String? currentError) {
    if (currentError != null && currentError != _lastError) {
      _lastError = currentError;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(currentError),
              backgroundColor: Colors.red,
              action: SnackBarAction(
                label: '关闭',
                textColor: Colors.white,
                onPressed: () {},
              ),
            ),
          );
        }
      });
    } else if (currentError == null){
      _lastError = null;
    }
  }
}
