import 'package:flutter/material.dart';
import 'package:fuel/presentation/app/app.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomSnackBars {
  static SnackBar createErrorSnackBar({
    required String? errorMessage,
    Key? key,
  }) {
    return SnackBar(
      key: key,
      padding: const EdgeInsets.all(16),
      dismissDirection: DismissDirection.down,
      backgroundColor: Theme.of(navigatorKey.currentState!.context).colorScheme.errorContainer,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
            child: Text(
              errorMessage ?? "An unknown exception occurred.",
              style: Theme.of(navigatorKey.currentState!.context).textTheme.titleSmall?.copyWith(
                    fontSize: 16.sp,
                    height: 1.1,
                    letterSpacing: 0.1,
                    color: Theme.of(navigatorKey.currentState!.context).colorScheme.onErrorContainer,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  static SnackBar createSuccessSnackBar({required String message, Key? key}) {
    return SnackBar(
      key: key,
      padding: const EdgeInsets.all(16),
      dismissDirection: DismissDirection.down,
      backgroundColor: Theme.of(navigatorKey.currentState!.context).colorScheme.primaryContainer,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
            child: Text(
              message,
              style: Theme.of(navigatorKey.currentState!.context).textTheme.titleSmall?.copyWith(
                    fontSize: 16.sp,
                    height: 1.1,
                    letterSpacing: 0.1,
                    color: Theme.of(navigatorKey.currentState!.context).colorScheme.onPrimaryContainer,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
