import 'package:json_annotation/json_annotation.dart';

part 'city_request.g.dart';

@JsonSerializable(includeIfNull: false)
class CityRequest {

  final String placeId;
  final String? name;
  final String? lang;

  CityRequest({required this.placeId, this.name, this.lang});

  factory CityRequest.fromJson(Map<String, dynamic> json) => _$CityRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CityRequestToJson(this);

}