import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fuel/presentation/app/app.dart';

class ToastService {
  void showSuccessToast(String message) {
    final context = navigatorKey.currentContext;
    if (context == null || !context.mounted) {
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    }

    final theme = Theme.of(context);
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      backgroundColor: theme.colorScheme.primaryContainer,
      textColor: theme.colorScheme.onPrimaryContainer,
      fontSize: 16.0,
    );
  }

  void showErrorToast(String? errorMessage) {
    final context = navigatorKey.currentContext;
    if (context == null || !context.mounted) {
      Fluttertoast.showToast(
        msg: errorMessage ?? "An unexpected error occurred.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    }
    final theme = Theme.of(context);
    Fluttertoast.showToast(
      msg: errorMessage ?? "An unexpected error occurred.",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: theme.colorScheme.errorContainer,
      textColor: theme.colorScheme.onErrorContainer,
      fontSize: 16.0,
    );
  }
}
