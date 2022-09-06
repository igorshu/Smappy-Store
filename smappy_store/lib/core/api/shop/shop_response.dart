import 'package:freezed_annotation/freezed_annotation.dart';

part 'shop_response.g.dart';

@JsonSerializable()
class ShopResponse {

  final int id;
  final String token;

  final String? name;
  final String? address;
  @JsonKey(name: 'phone_number') final String? phoneNumber;
  final String? password;
  final String? description;
  final String? email;
  final String? photo;
  @JsonKey(name: 'web_site') final String? webSite;
  final String? whatsapp;
  final String? instagram;
  final String? country;
  final bool? best;
  final bool? allowPurchases;
  final bool? allowCountryDelivery;

  ShopResponse({
    required this.id,
    required this.token,
    this.name,
    this.address,
    this.phoneNumber,
    this.password,
    this.description,
    this.email,
    this.photo,
    this.webSite,
    this.whatsapp,
    this.instagram,
    this.country,
    this.best,
    this.allowPurchases,
    this.allowCountryDelivery,
  });

  factory ShopResponse.fromJson(Map<String, dynamic> json) => _$ShopResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ShopResponseToJson(this);

}
