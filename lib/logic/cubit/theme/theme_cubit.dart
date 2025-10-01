import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fuel/core/theme/app_theme.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'theme_state.dart';

class ThemeCubit extends HydratedCubit<ThemeState> {
  ThemeCubit() : super(ThemeState.initial()) {
    _changeThemeOfStatusBarAndNavigationBar();
  }

  void _changeThemeOfStatusBarAndNavigationBar() {
    AppTheme.setStatusBarAndNavigationBarColors(state.themeMode);
  }

  Future<void> changeToLightTheme() async {
    emit(const ThemeState(themeMode: ThemeMode.light));
    _changeThemeOfStatusBarAndNavigationBar();
  }

  Future<void> changeToDarkTheme() async {
    emit(const ThemeState(themeMode: ThemeMode.dark));
    _changeThemeOfStatusBarAndNavigationBar();
  }

  @override
  ThemeState? fromJson(Map<String, dynamic> json) {
    return ThemeState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(ThemeState state) {
    return state.toJson();
  }
}
