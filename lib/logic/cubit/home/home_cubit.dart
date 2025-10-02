import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:fuel/core/exceptions/exceptions.dart';
import 'package:fuel/data/models/depot/depot_model.dart';
import 'package:fuel/data/models/depot/depot_price_model.dart';
import 'package:fuel/data/repositories/depot_repository.dart';
import 'package:general_utilities/general_utilities.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final DepotRepository _depotRepository;

  HomeCubit({
    required DepotRepository depotRepository,
  })  : _depotRepository = depotRepository,
        super(HomeState.initial()) {
    getDepotsAndPrices();
  }

  Future<void> getDepotsAndPrices() async {
    try {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress, userMessage: ""));

      final List<dynamic> results = await Future.wait([
        _depotRepository.getDepots(),
        _depotRepository.getPricing(),
      ]);

      final List<DepotModel> depots = results[0] as List<DepotModel>;
      final List<DepotPriceModel> depotPrices = results[1] as List<DepotPriceModel>;

      emit(
        state.copyWith(
          status: FormzSubmissionStatus.success,
          depots: depots,
          depotPrices: depotPrices,
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
