import 'package:freezed_annotation/freezed_annotation.dart';

part 'shop_registration_response.g.dart';

@JsonSerializable()
class ShopRegistrationResponse {

  final int id;
  @JsonKey(name: "phone_number") final String? phoneNumber;
  @JsonKey(name: "verification_code") final String? verificationCode;
  final String? updatedAt;
  final String? createdAt;
  final String? token;
  @JsonKey(name: "verification_time") final String? verificationTime;
  final String? address;
  final String? addressApt;
  final String? addressComment;
  final String? name;
  final String? password;
  final String? email;
  final String? addresses;

  ShopRegistrationResponse(
    this.id,
    this.verificationCode,
    this.phoneNumber,
    this.updatedAt,
    this.createdAt,
    this.token,
    this.verificationTime,
    this.address,
    this.addressApt,
    this.addressComment,
    this.name,
    this.password,
    this.email,
    this.addresses,
  );

  factory ShopRegistrationResponse.fromJson(Map<String, dynamic> json) => _$ShopRegistrationResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ShopRegistrationResponseToJson(this);
}