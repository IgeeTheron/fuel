import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:fuel/core/exceptions/exceptions.dart';
import 'package:fuel/data/models/depot/account_balance_model.dart';
import 'package:fuel/data/models/depot/depot_model.dart';
import 'package:fuel/data/repositories/depot_repository.dart';
import 'package:general_utilities/general_utilities.dart';

part 'depot_details_state.dart';

class DepotDetailsCubit extends Cubit<DepotDetailsState> {
  final DepotRepository _depotRepository;

  DepotDetailsCubit({
    required DepotRepository depotRepository,
    required DepotModel depot,
  })  : _depotRepository = depotRepository,
        super(DepotDetailsState.initial(depot: depot)) {
    getAccountBalance();
  }

  Future<void> getAccountBalance() async {
    try {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress, userMessage: ""));

      AccountBalanceModel accountBalance = await _depotRepository.getAccountBalance();

      emit(
        state.copyWith(
          status: FormzSubmissionStatus.success,
          accountBalance: accountBalance,
        ),
      );
    } on AppException catch (e) {
      emit(
        state.copyWith(
          status: FormzSubmissionStatus.failure,
          userMessage: e.message,
        ),
      );
    } catch (e, st) {
      // TODO: Implement Crash reports
      // await FirebaseCrashlytics.instance.recordError(e, st);
      PrintColor.red(e);
      PrintColor.red(st);
      emit(
        state.copyWith(
          status: FormzSubmissionStatus.failure,
          userMessage: "We're having trouble loading the depots and prices right now. Please try again later.",
        ),
      );
    }
  }
}
