import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuel/logic/cubit/loading/loading_cubit.dart';
import 'package:fuel/presentation/widgets/loaders/full_screen_loader.dart';

/// The `LoadingOverlay` class is a widget that displays a full-screen loader when a `LoadingCubit` state is true, and renders its child widget otherwise.
class LoadingOverlay extends StatelessWidget {
  final Widget child;

  const LoadingOverlay({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaler: mediaQueryData.textScaler.clamp(minScaleFactor: 0.9, maxScaleFactor: 1.0),
      ),
      child: Stack(
        children: [
          child,
          BlocBuilder<LoadingCubit, LoadingState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const FullscreenLoader();
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
