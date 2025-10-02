import 'package:equatable/equatable.dart';
import 'package:fuel/core/utils/json_utlis.dart';

// TODO: remove all unused fields when done implementing the model
class DepotModel extends Equatable {
  final int id;
  final String name;
  final bool active;
  final String description;
  final String location;
  final String address;
  final String pastelCode;
  final String itemCode;
  final String itemDescription;
  final String address1;
  final String address2;
  final String address3;
  final String address4;
  final String geo;
  final String googleMaps;
  final String hoursText;
  final String extraInfo;
  final String directions;
  final String contact;
  final String contactNumber;
  final String email;
  final DateTime? createdDate;
  final String orderSmsNotification;
  final bool allowFill;
  final bool isDepotOutOfStock;
  final String outOfStockMessage;
  final String latitude;
  final String longitude;
  final String country;

  const DepotModel({
    required this.id,
    required this.name,
    required this.active,
    required this.description,
    required this.location,
    required this.address,
    required this.pastelCode,
    required this.itemCode,
    required this.itemDescription,
    required this.address1,
    required this.address2,
    required this.address3,
    required this.address4,
    required this.geo,
    required this.googleMaps,
    required this.hoursText,
    required this.extraInfo,
    required this.directions,
    required this.contact,
    required this.contactNumber,
    required this.email,
    required this.orderSmsNotification,
    required this.allowFill,
    required this.isDepotOutOfStock,
    required this.outOfStockMessage,
    required this.latitude,
    required this.longitude,
    required this.country,
    this.createdDate,
  });

  static const DepotModel empty = DepotModel(
    id: -1,
    name: '',
    active: false,
    description: '',
    location: '',
    address: '',
    pastelCode: '',
    itemCode: '',
    itemDescription: '',
    address1: '',
    address2: '',
    address3: '',
    address4: '',
    geo: '',
    googleMaps: '',
    hoursText: '',
    extraInfo: '',
    directions: '',
    contact: '',
    contactNumber: '',
    email: '',
    orderSmsNotification: '',
    allowFill: false,
    isDepotOutOfStock: false,
    outOfStockMessage: '',
    latitude: '',
    longitude: '',
    country: '',
  );

  bool get isEmpty => this == DepotModel.empty;

  bool get isNotEmpty => this != DepotModel.empty;

  factory DepotModel.fromJson(Map<String, dynamic> json) {
    final Map<String, List<Type?>?> expectedTypes = {
      "id": [int],
      "name": [String],
      "active": [bool],
      "description": [String],
      "location": [String],
      "address": [String],
      "pastelCode": [String],
      "itemCode": [String],
      "itemDescription": [String],
      "address1": [String],
      "address2": [String],
      "address3": [String],
      "address4": [String],
      "geo": [String],
      "googleMaps": [String],
      "hoursText": [String],
      "extraInfo": [String],
      "directions": [String],
      "contact": [String],
      "contactNumber": [String],
      "email": [String],
      "createdDate": [null, String],
      "orderSmsNotification": [String],
      "allowFill": [bool],
      "isDepotOutOfStock": [bool],
      "outOfStockMessage": [String],
      "latitude": [String],
      "longitude": [String],
      "country": [String],
    };

    JsonUtils.assertJsonKeys(json: json, expectedTypes: expectedTypes);

    return DepotModel(
      id: json["id"],
      name: json["name"],
      active: json["active"],
      description: json["description"],
      location: json["location"],
      address: json["address"],
      pastelCode: json["pastelCode"],
      itemCode: json["itemCode"],
      itemDescription: json["itemDescription"],
      address1: json["address1"],
      address2: json["address2"],
      address3: json["address3"],
      address4: json["address4"],
      geo: json["geo"],
      googleMaps: json["googleMaps"],
      hoursText: json["hoursText"],
      extraInfo: json["extraInfo"],
      directions: json["directions"],
      contact: json["contact"],
      contactNumber: json["contactNumber"],
      email: json["email"],
      createdDate: (json["createdDate"] == null) ? null : DateTime.parse(json["createdDate"]),
      orderSmsNotification: json["orderSmsNotification"],
      allowFill: json["allowFill"],
      isDepotOutOfStock: json["isDepotOutOfStock"],
      outOfStockMessage: json["outOfStockMessage"],
      latitude: json["latitude"],
      longitude: json["longitude"],
      country: json["country"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "active": active,
        "description": description,
        "location": location,
        "address": address,
        "pastelCode": pastelCode,
        "itemCode": itemCode,
        "itemDescription": itemDescription,
        "address1": address1,
        "address2": address2,
        "address3": address3,
        "address4": address4,
        "geo": geo,
        "googleMaps": googleMaps,
        "hoursText": hoursText,
        "extraInfo": extraInfo,
        "directions": directions,
        "contact": contact,
        "contactNumber": contactNumber,
        "email": email,
        "createdDate": createdDate?.toIso8601String(),
        "orderSmsNotification": orderSmsNotification,
        "allowFill": allowFill,
        "isDepotOutOfStock": isDepotOutOfStock,
        "outOfStockMessage": outOfStockMessage,
        "latitude": latitude,
        "longitude": longitude,
        "country": country,
      };

  DepotModel copyWith({
    int? id,
    String? name,
    bool? active,
    String? description,
    String? location,
    String? address,
    String? pastelCode,
    String? itemCode,
    String? itemDescription,
    String? address1,
    String? address2,
    String? address3,
    String? address4,
    String? geo,
    String? googleMaps,
    String? hoursText,
    String? extraInfo,
    String? directions,
    String? contact,
    String? contactNumber,
    String? email,
    DateTime? createdDate,
    String? orderSmsNotification,
    bool? allowFill,
    bool? isDepotOutOfStock,
    String? outOfStockMessage,
    String? latitude,
    String? longitude,
    String? country,
  }) {
    return DepotModel(
      id: id ?? this.id,
      name: name ?? this.name,
      active: active ?? this.active,
      description: description ?? this.description,
      location: location ?? this.location,
      address: address ?? this.address,
      pastelCode: pastelCode ?? this.pastelCode,
      itemCode: itemCode ?? this.itemCode,
      itemDescription: itemDescription ?? this.itemDescription,
      address1: address1 ?? this.address1,
      address2: address2 ?? this.address2,
      address3: address3 ?? this.address3,
      address4: address4 ?? this.address4,
      geo: geo ?? this.geo,
      googleMaps: googleMaps ?? this.googleMaps,
      hoursText: hoursText ?? this.hoursText,
      extraInfo: extraInfo ?? this.extraInfo,
      directions: directions ?? this.directions,
      contact: contact ?? this.contact,
      contactNumber: contactNumber ?? this.contactNumber,
      email: email ?? this.email,
      createdDate: createdDate ?? this.createdDate,
      orderSmsNotification: orderSmsNotification ?? this.orderSmsNotification,
      allowFill: allowFill ?? this.allowFill,
      isDepotOutOfStock: isDepotOutOfStock ?? this.isDepotOutOfStock,
      outOfStockMessage: outOfStockMessage ?? this.outOfStockMessage,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      country: country ?? this.country,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        active,
        description,
        location,
        address,
        pastelCode,
        itemCode,
        itemDescription,
        address1,
        address2,
        address3,
        address4,
        geo,
        googleMaps,
        hoursText,
        extraInfo,
        directions,
        contact,
        contactNumber,
        email,
        createdDate,
        orderSmsNotification,
        allowFill,
        isDepotOutOfStock,
        outOfStockMessage,
        latitude,
        longitude,
        country,
      ];

  @override
  String toString() {
    return 'DepotModel{id: $id, name: $name, active: $active, description: $description, location: $location, address: $address, pastelCode: $pastelCode, itemCode: $itemCode, itemDescription: $itemDescription, address1: $address1, address2: $address2, address3: $address3, address4: $address4, geo: $geo, googleMaps: $googleMaps, hoursText: $hoursText, extraInfo: $extraInfo, directions: $directions, contact: $contact, contactNumber: $contactNumber, email: $email, createdDate: $createdDate, orderSmsNotification: $orderSmsNotification, allowFill: $allowFill, isDepotOutOfStock: $isDepotOutOfStock, outOfStockMessage: $outOfStockMessage, latitude: $latitude, longitude: $longitude, country: $country}';
  }
}
