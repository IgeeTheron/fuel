import 'package:flutter/material.dart';
import 'package:fuel/presentation/widgets/loaders/loader.dart';

class BottomLoader extends StatelessWidget {
  const BottomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Loader(size: 24),
    );
  }
}
