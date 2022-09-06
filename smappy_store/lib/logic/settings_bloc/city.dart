import 'package:json_annotation/json_annotation.dart';

part 'city.g.dart';

@JsonSerializable(includeIfNull: false)
class City {

  // final int id;
  final String placeId;
  final String name;
  final String? nameEng;

  City({
    // required this.id,
    required this.placeId,
    required this.name,
    this.nameEng,
  });

  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);
  Map<String, dynamic> toJson() => _$CityToJson(this);
}