part of 'depot_details_cubit.dart';

final class DepotDetailsState extends Equatable {
  final FormzSubmissionStatus status;
  final DepotModel depot;
  final AccountBalanceModel accountBalance;
  final String? userMessage;

  const DepotDetailsState({
    this.status = FormzSubmissionStatus.inProgress,
    this.depot = DepotModel.empty,
    this.accountBalance = AccountBalanceModel.empty,
    this.userMessage,
  });

  factory DepotDetailsState.initial({required DepotModel depot}) {
    return DepotDetailsState(depot: depot);
  }

  DepotDetailsState copyWith({
    FormzSubmissionStatus? status,
    DepotModel? depot,
    AccountBalanceModel? accountBalance,
    String? userMessage,
  }) {
    return DepotDetailsState(
      status: status ?? this.status,
      depot: depot ?? this.depot,
      accountBalance: accountBalance ?? this.accountBalance,
      userMessage: userMessage ?? this.userMessage,
    );
  }

  @override
  List<Object?> get props => [status, depot, accountBalance, userMessage];

  @override
  String toString() {
    return 'DepotDetailsState{status: $status, depot: $depot, accountBalance: $accountBalance, userMessage: $userMessage}';
  }
}
