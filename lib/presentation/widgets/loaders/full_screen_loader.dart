import 'package:flutter/material.dart';
import 'package:fuel/core/theme/colors/dark_theme_colors.dart';

class FullscreenLoader extends StatelessWidget {
  final double _size;

  const FullscreenLoader({super.key, double size = 50}) : _size = size;

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Colors.black.withValues(alpha: 0.75);

    return Container(
      color: backgroundColor,
      child: Center(
        child: SizedBox(
          height: _size,
          width: _size,
          child: CircularProgressIndicator(
            color: DarkThemeColors.colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
