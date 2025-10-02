import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuel/core/constants/enums/wrapper_screen_state.dart';
import 'package:fuel/logic/cubit/wrapper/wrapper_cubit.dart';
import 'package:fuel/presentation/screens/authentication/login/login_page.dart';
import 'package:fuel/presentation/screens/home/home_page.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  Widget _buildWrapperScreens(WrapperScreenState wrapperScreenState) {
    switch (wrapperScreenState) {
      case WrapperScreenState.login:
        return const LoginPage();
      case WrapperScreenState.mainHome:
        return const HomePage();
    }
  }

  Widget _buildWrapperBody() {
    return BlocBuilder<WrapperCubit, WrapperState>(
      builder: (context, state) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
          child: _buildWrapperScreens(state.wrapperScreenState),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildWrapperBody();
  }
}
