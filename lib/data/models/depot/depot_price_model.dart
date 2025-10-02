import 'package:equatable/equatable.dart';
import 'package:fuel/core/utils/json_utlis.dart';

class DepotPriceModel extends Equatable {
  final String depotName;
  final int price;

  const DepotPriceModel({
    required this.depotName,
    required this.price,
  });

  static const DepotPriceModel empty = DepotPriceModel(
    depotName: '',
    price: 0,
  );

  bool get isEmpty => this == DepotPriceModel.empty;

  bool get isNotEmpty => this != DepotPriceModel.empty;

  factory DepotPriceModel.fromJson(Map<String, dynamic> json) {
    final Map<String, List<Type?>?> expectedTypes = {
      "depotName": [String],
      "price": [int],
    };

    JsonUtils.assertJsonKeys(json: json, expectedTypes: expectedTypes);

    return DepotPriceModel(
      depotName: json["depotName"],
      price: json["price"],
    );
  }

  Map<String, dynamic> toJson() => {
        "depotName": depotName,
        "price": price,
      };

  DepotPriceModel copyWith({
    String? depotName,
    int? price,
  }) {
    return DepotPriceModel(
      depotName: depotName ?? this.depotName,
      price: price ?? this.price,
    );
  }

  @override
  List<Object> get props => [depotName, price];

  @override
  String toString() {
    return 'DepotPriceModel{depotName: $depotName, price: $price}';
  }
}
