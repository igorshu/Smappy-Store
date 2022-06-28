import 'package:freezed_annotation/freezed_annotation.dart';

part 'verify_phone_number_request.g.dart';

@JsonSerializable()
class VerifyPhoneNumberRequest {

  final String code;

  VerifyPhoneNumberRequest(this.code);

  factory VerifyPhoneNumberRequest.fromJson(Map<String, dynamic> json) => _$VerifyPhoneNumberRequestFromJson(json);
  Map<String, dynamic> toJson() => _$VerifyPhoneNumberRequestToJson(this);
}