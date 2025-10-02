import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:fuel/data/models/depot/depot_model.dart';
import 'package:fuel/data/repositories/depot_repository.dart';
import 'package:fuel/logic/cubit/depot_details/depot_details_cubit.dart';
import 'package:fuel/presentation/screens/home/depot_details/depot_details_view.dart';
import 'package:fuel/presentation/widgets/dialogs/custom_snack_bars.dart';

class DepotDetailsPage extends StatelessWidget {
  final DepotModel depot;

  const DepotDetailsPage({
    required this.depot,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DepotDetailsCubit>(
      create: (context) => DepotDetailsCubit(
        depotRepository: RepositoryProvider.of<DepotRepository>(context),
        depot: depot,
      ),
      lazy: false,
      child: BlocListener<DepotDetailsCubit, DepotDetailsState>(
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
        child: const DepotDetailsView(),
      ),
    );
  }
}
