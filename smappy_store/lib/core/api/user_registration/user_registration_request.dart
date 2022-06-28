import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_registration_request.g.dart';

@JsonSerializable()
class UserRegistrationRequest {

  @JsonKey(name: 'phone_number')
  final String phoneNumber;

  UserRegistrationRequest(this.phoneNumber);

  factory UserRegistrationRequest.fromJson(Map<String, dynamic> json) => _$UserRegistrationRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UserRegistrationRequestToJson(this);
}