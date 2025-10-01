import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuel/core/di/injection.dart';
import 'package:fuel/core/theme/app_theme.dart';
import 'package:fuel/data/repositories/user_management_repository.dart';
import 'package:fuel/logic/bloc/authentication/authentication_bloc.dart';
import 'package:fuel/logic/cubit/connectivity/internet_cubit.dart';
import 'package:fuel/logic/cubit/loading/loading_cubit.dart';
import 'package:fuel/logic/cubit/theme/theme_cubit.dart';
import 'package:fuel/logic/cubit/wrapper/wrapper_cubit.dart';
import 'package:fuel/presentation/router/app_router.dart';
import 'package:fuel/presentation/widgets/layouts/loading_screen_builder.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Fuel extends StatelessWidget {
  final InternetCubit _internetCubit;

  const Fuel({
    required InternetCubit internetCubit,
    super.key,
  }) : _internetCubit = internetCubit;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<UserManagementRepository>.value(
          value: getIt<UserManagementRepository>(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<InternetCubit>.value(value: _internetCubit),
          BlocProvider<ThemeCubit>(
            create: (context) => ThemeCubit(),
            lazy: false,
          ),
          BlocProvider<LoadingCubit>(
            create: (context) => LoadingCubit(),
            lazy: false,
          ),
          BlocProvider<AuthenticationBloc>(
            create: (context) => AuthenticationBloc(
              userManagementRepository: RepositoryProvider.of<UserManagementRepository>(
                context,
              ),
            ),
          ),
          BlocProvider<WrapperCubit>(
            create: (context) => WrapperCubit(
              authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
            ),
          ),
        ],
        child: ResponsiveSizer(
          builder: (context, orientation, screenType) {
            return GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: MaterialApp(
                navigatorKey: navigatorKey,
                builder: LoadingScreenBuilder.init(),
                debugShowCheckedModeBanner: false,
                theme: AppTheme.lightTheme(),
                darkTheme: AppTheme.darkTheme(),
                themeMode: context.watch<ThemeCubit>().state.themeMode,
                onGenerateInitialRoutes: (String initialRouteName) {
                  return [
                    AppRouter.onGenerateRoute(
                      const RouteSettings(
                        name: AppRouter.wrapper,
                      ),
                    ),
                  ];
                },
                onGenerateRoute: AppRouter.onGenerateRoute,
              ),
            );
          },
        ),
      ),
    );
  }
}
