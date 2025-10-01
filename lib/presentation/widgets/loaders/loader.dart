import 'package:flutter/material.dart';

/// The `Loader` class is a stateless widget that displays a centered circular progress indicator with a customizable size.
class Loader extends StatelessWidget {
  final double _size;

  const Loader({
    super.key,
    double size = 80,
  }) : _size = size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: _size,
        width: _size,
        child: CircularProgressIndicator(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
