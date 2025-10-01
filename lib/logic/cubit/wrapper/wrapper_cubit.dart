import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:fuel/core/constants/enums/authentication_status.dart';
import 'package:fuel/core/constants/enums/wrapper_screen_state.dart';
import 'package:fuel/logic/bloc/authentication/authentication_bloc.dart';
import 'package:fuel/presentation/app/app.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'wrapper_state.dart';

class WrapperCubit extends Cubit<WrapperState> {
  final AuthenticationBloc authenticationBloc;
  StreamSubscription? onboardingSubscription;
  StreamSubscription? initialFlowSubscription;
  StreamSubscription? authenticationSubscription;

  static AuthenticationState? _previousAuthenticationState;

  WrapperCubit({
    required this.authenticationBloc,
  }) : super(
          _getWrapperState(
            previousAuthenticationState: null,
            authenticationState: authenticationBloc.state,
          ),
        ) {
    authenticationSubscription = authenticationBloc.stream.listen((authenticationState) {
      emit(
        _getWrapperState(
          previousAuthenticationState: _previousAuthenticationState,
          authenticationState: authenticationState,
        ),
      );
    });
  }

  static NavigatorState? get _navigator => navigatorKey.currentState;

  static WrapperState _getWrapperState({
    required AuthenticationState? previousAuthenticationState,
    required AuthenticationState authenticationState,
  }) {
    _previousAuthenticationState = authenticationState;

    if (authenticationState.status == AuthenticationStatus.authenticated) {
      if (previousAuthenticationState != null && previousAuthenticationState.status != AuthenticationStatus.authenticated && _navigator != null) {
        _navigator!.popUntil((route) => route.isFirst);
      }

      return const WrapperState(
        wrapperScreenState: WrapperScreenState.mainHome,
      );
    } else {
      return const WrapperState(wrapperScreenState: WrapperScreenState.authentication);
    }
  }

  Future<void> goToAuthentication({BuildContext? context}) async {
    if (context != null) {
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
    emit(
      const WrapperState(
        wrapperScreenState: WrapperScreenState.authentication,
      ),
    );
  }

  Future<void> goToMainHome({BuildContext? context}) async {
    if (context != null) {
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
    emit(const WrapperState(wrapperScreenState: WrapperScreenState.mainHome));
  }

  @override
  Future<void> close() {
    onboardingSubscription?.cancel();
    initialFlowSubscription?.cancel();
    authenticationSubscription?.cancel();
    return super.close();
  }
}
