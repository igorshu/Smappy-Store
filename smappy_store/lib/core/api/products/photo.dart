import 'package:freezed_annotation/freezed_annotation.dart';

part 'photo.g.dart';

@JsonSerializable()
class Photo {
  final int id;
  final String photo;
  final int? productId;

  Photo(this.id, this.photo, this.productId);

  factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);
  Map<String, dynamic> toJson() => _$PhotoToJson(this);
}