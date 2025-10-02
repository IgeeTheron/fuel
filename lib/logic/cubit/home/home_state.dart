part of 'home_cubit.dart';

final class HomeState extends Equatable {
  final FormzSubmissionStatus status;
  final List<DepotModel> depots;
  final List<DepotPriceModel> depotPrices;
  final String? userMessage;

  const HomeState({
    this.status = FormzSubmissionStatus.inProgress,
    this.depots = const <DepotModel>[],
    this.depotPrices = const <DepotPriceModel>[],
    this.userMessage,
  });

  factory HomeState.initial() {
    return const HomeState();
  }

  HomeState copyWith({
    FormzSubmissionStatus? status,
    List<DepotModel>? depots,
    List<DepotPriceModel>? depotPrices,
    String? userMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      depots: depots ?? this.depots,
      depotPrices: depotPrices ?? this.depotPrices,
      userMessage: userMessage ?? this.userMessage,
    );
  }

  @override
  List<Object?> get props => [status, depots, depotPrices, userMessage];

  @override
  String toString() {
    return 'HomeState{status: $status, depots: $depots, depotPrices: $depotPrices, userMessage: $userMessage}';
  }
}
