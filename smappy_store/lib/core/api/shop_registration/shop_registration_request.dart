import 'package:freezed_annotation/freezed_annotation.dart';

part 'shop_registration_request.g.dart';

@JsonSerializable()
class ShopRegistrationRequest {

  @JsonKey(name: 'phone_number')
  final String phoneNumber;
  final String code;

  ShopRegistrationRequest(this.phoneNumber, this.code);

  factory ShopRegistrationRequest.fromJson(Map<String, dynamic> json) => _$ShopRegistrationRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ShopRegistrationRequestToJson(this);
}