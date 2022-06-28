import 'package:freezed_annotation/freezed_annotation.dart';

part 'smappy_code_response.g.dart';

@JsonSerializable()
class SmappyCodeResponse {

  SmappyCodeResponse();

  factory SmappyCodeResponse.fromJson(Map<String, dynamic> json) => _$SmappyCodeResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SmappyCodeResponseToJson(this);
}