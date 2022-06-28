// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_phone_number_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyPhoneNumberResponse _$VerifyPhoneNumberResponseFromJson(
        Map<String, dynamic> json) =>
    VerifyPhoneNumberResponse(
      json['id'] as int,
      json['token'] as String,
      json['phone_number'] as String,
      json['createdAt'] as String,
      json['updatedAt'] as String,
    );

Map<String, dynamic> _$VerifyPhoneNumberResponseToJson(
        VerifyPhoneNumberResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'token': instance.token,
      'phone_number': instance.phoneNumber,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
