import 'package:meta/meta.dart';
import 'dart:convert';

class AddressItem {
  AddressItem({
    required this.province,
    required this.district,
    this.town,
    this.street,
    required this.country,
    required this.latitude,
    required this.longitude,
  });

  final String province;
  final String district;
  final String? town;
  final String? street;
  final String country;
  final double latitude;
  final double longitude;

  AddressItem copyWith({
    String? province,
    String? district,
    String? town,
    String? street,
    String? country,
    double? latitude,
    double? longitude,
  }) =>
      AddressItem(
        province: province ?? this.province,
        district: district ?? this.district,
        town: town ?? this.town,
        street: street ?? this.street,
        country: country ?? this.country,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
      );

  factory AddressItem.fromRawJson(String str) => AddressItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AddressItem.fromJson(Map<String, dynamic> json) => AddressItem(
    province: json["province"],
    district: json["district"],
    town: json["town"],
    street: json["street"],
    country: json["country"],
    latitude: json["latitude"].toDouble(),
    longitude: json["longitude"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "province": province,
    "district": district,
    "town": town,
    "street": street,
    "country": country,
    "latitude": latitude,
    "longitude": longitude,
  };
}
