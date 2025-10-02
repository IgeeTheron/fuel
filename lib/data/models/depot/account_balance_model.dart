import 'package:equatable/equatable.dart';
import 'package:fuel/core/utils/json_utlis.dart';

class AccountBalanceModel extends Equatable {
  final double availableCredit;
  final double pendingOrders;

  const AccountBalanceModel({
    required this.availableCredit,
    required this.pendingOrders,
  });

  static const AccountBalanceModel empty = AccountBalanceModel(
    availableCredit: 0,
    pendingOrders: 0,
  );

  bool get isEmpty => this == AccountBalanceModel.empty;

  bool get isNotEmpty => this != AccountBalanceModel.empty;

  factory AccountBalanceModel.fromJson(Map<String, dynamic> json) {
    final Map<String, List<Type?>?> expectedTypes = {
      "availableCredit": [double],
      "pendingOrders": [double],
    };

    JsonUtils.assertJsonKeys(json: json, expectedTypes: expectedTypes);

    return AccountBalanceModel(
      availableCredit: json["availableCredit"]?.toDouble(),
      pendingOrders: json["pendingOrders"]?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        "availableCredit": availableCredit,
        "pendingOrders": pendingOrders,
      };

  AccountBalanceModel copyWith({
    double? availableCredit,
    double? pendingOrders,
  }) {
    return AccountBalanceModel(
      availableCredit: availableCredit ?? this.availableCredit,
      pendingOrders: pendingOrders ?? this.pendingOrders,
    );
  }

  @override
  List<Object> get props => [availableCredit, pendingOrders];

  @override
  String toString() {
    return 'AccountBalanceModel{availableCredit: $availableCredit, pendingOrders: $pendingOrders}';
  }
}
