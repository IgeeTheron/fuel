import 'package:flutter/material.dart';
import 'package:fuel/presentation/widgets/loaders/loading_overlay.dart';

/// The LoadingScreenBuilder class provides a static method to initialize a loading overlay for a given widget.
class LoadingScreenBuilder {
  static TransitionBuilder init({TransitionBuilder? builder}) {
    return (BuildContext context, Widget? child) {
      if (builder != null) {
        return builder(context, LoadingOverlay(child: child!));
      } else {
        return LoadingOverlay(child: child!);
      }
    };
  }
}
