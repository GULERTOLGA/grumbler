
import 'dart:convert';

import 'address_item.dart';

class Complaint {
  Complaint({
    required this.addressItem,
    required this.publishName,
    required this.publishToTwitter,
    required this.publishToFacebook,
    required this.description,
    required this.type,
    required this.images,
  });

  final AddressItem addressItem;
  final bool publishName;
  final bool publishToTwitter;
  final bool publishToFacebook;
  final String description;
  final int type;
  final List<String> images;

  Complaint copyWith({
    AddressItem? addressItem,
    bool? publishName,
    bool? publishToTwitter,
    bool? publishToFacebook,
    String? description,
    int? type,
    List<String>? images,
  }) =>
      Complaint(
        addressItem: addressItem ?? this.addressItem,
        publishName: publishName ?? this.publishName,
        publishToTwitter: publishToTwitter ?? this.publishToTwitter,
        publishToFacebook: publishToFacebook ?? this.publishToFacebook,
        description: description ?? this.description,
        type: type ?? this.type,
        images: images ?? this.images,
      );

  factory Complaint.fromRawJson(String str) => Complaint.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Complaint.fromJson(Map<String, dynamic> json) => Complaint(
    addressItem: AddressItem.fromJson(json["addressItem"]),
    publishName: json["publishName"],
    publishToTwitter: json["publishToTwitter"],
    publishToFacebook: json["publishToFacebook"],
    description: json["description"],
    type: json["type"],
    images: List<String>.from(json["images"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "addressItem": addressItem.toJson(),
    "publishName": publishName,
    "publishToTwitter": publishToTwitter,
    "publishToFacebook": publishToFacebook,
    "description": description,
    "type": type,
    "images": List<dynamic>.from(images.map((x) => x)),
  };
}