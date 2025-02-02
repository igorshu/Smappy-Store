import 'package:freezed_annotation/freezed_annotation.dart';

part 'tag.g.dart';

@JsonSerializable()
class Tag {

  final int id;
  final String name;

  Tag(this.id, this.name);

  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);
  Map<String, dynamic> toJson() => _$TagToJson(this);
}
