import 'package:freezed_annotation/freezed_annotation.dart';

part 'verify_phone_number_response.g.dart';

@JsonSerializable()
class VerifyPhoneNumberResponse {

  final int id;
  final String token;
  @JsonKey(name: "phone_number")
  final String phoneNumber;
  final String createdAt;
  final String updatedAt;

  VerifyPhoneNumberResponse(
      this.id,
      this.token,
      this.phoneNumber,
      this.createdAt,
      this.updatedAt,
      );

  factory VerifyPhoneNumberResponse.fromJson(Map<String, dynamic> json) => _$VerifyPhoneNumberResponseFromJson(json);
  Map<String, dynamic> toJson() => _$VerifyPhoneNumberResponseToJson(this);

  @override
  String toString() {
    return 'VerifyPhoneNumberResponse {id: $id, token: $token, phoneNumber: $phoneNumber, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}