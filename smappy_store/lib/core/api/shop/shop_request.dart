import 'package:freezed_annotation/freezed_annotation.dart';

part 'shop_request.g.dart';

@JsonSerializable(includeIfNull: false)
class ShopRequest {

  final int? id;
  final String? name;
  final String? email;
  final String? password;
  final String? address;
  final String? description;
  @JsonKey(name: 'web_site') final String? webSite;
  final String? mail;
  final String? whatsapp;
  final String? instagram;
  final String? country;
  final bool? best;

  ShopRequest({
    this.id,
    this.name,
    this.email,
    this.password,
    this.address,
    this.description,
    this.webSite,
    this.mail,
    this.whatsapp,
    this.instagram,
    this.country,
    this.best,
  });

  factory ShopRequest.fromJson(Map<String, dynamic> json) => _$ShopRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ShopRequestToJson(this);

  @override
  String toString() {
    return 'ShopRequest {id: $id, name: $name, email: $email, password: $password, address: $address, description: $description, webSite: $webSite, mail: $mail, whatsapp: $whatsapp, instagram: $instagram, country: $country, best: $best}';
  }
}