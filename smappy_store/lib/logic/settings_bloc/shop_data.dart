import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smappy_store/core/api/shop/shop_response.dart';

part 'shop_data.g.dart';

@JsonSerializable(includeIfNull: false)
class ShopData {

  String? name;
  String? description;
  String? address;
  String? whatsapp;
  String? instagram;
  String? email;

  ShopData({
    this.name,
    this.description,
    this.address,
    this.whatsapp,
    this.instagram,
    this.email,
  });

  factory ShopData.fromShopResponse(ShopResponse shopResponse) {
    return ShopData(
      name: shopResponse.name,
      description: shopResponse.description,
      address: shopResponse.address,
      whatsapp: shopResponse.whatsapp,
      instagram: shopResponse.instagram,
      email: shopResponse.email,
    );
  }

  factory ShopData.fromJson(Map<String, dynamic> json) => _$ShopDataFromJson(json);
  Map<String, dynamic> toJson() => _$ShopDataToJson(this);

  ShopData copyWith({
    name,
    description,
    address,
    whatsapp,
    instagram,
    email,
  }) {
    return ShopData(
      name: name ?? this.name,
      description: description ?? this.description,
      address: address ?? this.address,
      whatsapp: whatsapp ?? this.whatsapp,
      instagram: instagram ?? this.instagram,
      email: email ?? this.email,
    );
  }


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShopData &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          description == other.description &&
          address == other.address &&
          whatsapp == other.whatsapp &&
          instagram == other.instagram &&
          email == other.email;

  @override
  int get hashCode => name.hashCode ^ description.hashCode ^ address.hashCode ^ whatsapp.hashCode ^ instagram.hashCode ^ email.hashCode;

  @override
  String toString() => 'ShopData {name: $name, description: $description, address: $address, whatsapp: $whatsapp, instagram: $instagram, email: $email}';
}