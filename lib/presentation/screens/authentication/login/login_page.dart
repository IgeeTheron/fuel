import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:fuel/data/repositories/user_management_repository.dart';
import 'package:fuel/logic/cubit/authentication/login/login_cubit.dart';
import 'package:fuel/logic/cubit/loading/loading_cubit.dart';
import 'package:fuel/presentation/screens/authentication/login/login_view.dart';
import 'package:fuel/presentation/widgets/dialogs/custom_snack_bars.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(
        userManagementRepository: RepositoryProvider.of<UserManagementRepository>(context),
        loadingCubit: BlocProvider.of<LoadingCubit>(context),
      ),
      child: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.status.isInProgress) {
            context.read<LoadingCubit>().start();
          } else {
            context.read<LoadingCubit>().stop();
          }

          if (state.status.isFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                CustomSnackBars.createErrorSnackBar(
                  key: UniqueKey(),
                  errorMessage: state.userMessage,
                ),
              );
          }
        },
        child: LoginView(),
      ),
    );
  }
}
