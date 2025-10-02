import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:fuel/data/repositories/depot_repository.dart';
import 'package:fuel/logic/cubit/home/home_cubit.dart';
import 'package:fuel/presentation/screens/home/home_view.dart';
import 'package:fuel/presentation/widgets/dialogs/custom_snack_bars.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (context) => HomeCubit(
        depotRepository: RepositoryProvider.of<DepotRepository>(context),
      ),
      lazy: false,
      child: BlocListener<HomeCubit, HomeState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
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
        child: const HomeView(),
      ),
    );
  }
}
