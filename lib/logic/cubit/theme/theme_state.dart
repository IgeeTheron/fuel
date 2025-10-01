part of 'theme_cubit.dart';

class ThemeState extends Equatable {
  final ThemeMode themeMode;

  const ThemeState({required this.themeMode});

  factory ThemeState.initial() {
    return const ThemeState(themeMode: ThemeMode.light);
  }

  @override
  List<Object?> get props => [themeMode];

  Map<String, dynamic> toJson() {
    return {
      'themeMode': themeMode.toString().split('.').last,
    };
  }

  factory ThemeState.fromJson(Map<String, dynamic> map) {
    try {
      return ThemeState(
        themeMode: ThemeMode.values.firstWhere((e) => e.toString().split('.').last == map['themeMode']),
      );
    } catch (_) {
      return ThemeState.initial();
    }
  }

  @override
  String toString() {
    return 'ThemeState{themeMode: $themeMode}';
  }
}
