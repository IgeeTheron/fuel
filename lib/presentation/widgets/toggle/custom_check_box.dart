import 'package:flutter/material.dart';

/// The CustomCheckBox class is a stateless widget that displays a checkbox with
/// accompanying text and allows for a callback function to be executed when tapped.
class CustomCheckBox extends StatelessWidget {
  final VoidCallback _onTap;
  final bool? value;
  final Color? _color;
  final Color? _backGroundColor;
  final Widget? _text;

  const CustomCheckBox({
    required VoidCallback onTap,
    required this.value,
    Widget? text,
    Color? color,
    Color? backGroundColor,
    super.key,
  })  : _color = color,
        _backGroundColor = backGroundColor,
        _onTap = onTap,
        _text = text;

  /// This function returns a widget that displays a checkbox and text in a row,
  /// with an onTap function that is triggered when the widget is tapped.
  ///
  /// Args:
  ///   context (BuildContext): The BuildContext is a handle to the location of a
  /// widget in the widget tree. It is used to access the theme, media query, and
  /// other properties of the parent widget. It is required to build any widget in
  /// Flutter.
  ///
  /// Returns:
  ///   A widget that displays a row with a checkbox and text, wrapped in an InkWell
  /// widget that responds to taps. The checkbox is not interactive as the onChanged
  /// property is set to null.
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: _onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 20,
            width: 20,
            child: Transform.scale(
              scale: 1.2,
              child: Checkbox(
                value: value,
                onChanged: null,
                fillColor: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.selected)) {
                    return _color ?? themeData.colorScheme.primary;
                  }

                  return _backGroundColor ?? themeData.colorScheme.surfaceContainerLowest;
                }),
                side: WidgetStateBorderSide.resolveWith((states) {
                  if (states.contains(WidgetState.selected)) {
                    return BorderSide(
                      width: 1,
                      color: _color ?? themeData.colorScheme.primary,
                    );
                  }

                  return BorderSide(
                    width: 1,
                    color: _color ?? themeData.colorScheme.primary,
                  );
                }),
              ),
            ),
          ),
          const SizedBox(width: 8),
          if (_text != null) Flexible(child: _text),
        ],
      ),
    );
  }
}
