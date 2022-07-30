import 'package:freezed_annotation/freezed_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class Category {

  final int id;
  @JsonKey(name: 'name') final String? nam;
  final String? nameEN;
  final String? nameRU;
  @JsonKey(name: 'image_url') final String imageUrl;
  final String createdAt;
  final String emoji;
  final bool accessory;

  String? get name => nam ?? nameRU ?? nameEN;

  Category(this.id, this.nam, this.nameEN, this.nameRU, this.imageUrl, this.createdAt, this.emoji, this.accessory);

  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
