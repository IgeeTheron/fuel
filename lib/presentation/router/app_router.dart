import 'package:flutter/material.dart';
import 'package:fuel/core/exceptions/route_exception.dart';
import 'package:fuel/presentation/screens/wrapper.dart';

class AppRouter {
  static const String wrapper = '/';

  const AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    return switch (routeSettings.name) {
      wrapper => MaterialPageRoute(builder: (_) => const Wrapper()),
      _ => throw const RouteException("Route not found!"),
    };
  }

  static Future<dynamic> pushWithoutNav(BuildContext context, String routeName, {Object? arguments, String? optional}) {
    return switch (routeName) { _ => throw const RouteException("Route not found!") };
  }
}
