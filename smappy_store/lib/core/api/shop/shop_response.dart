import 'package:freezed_annotation/freezed_annotation.dart';

part 'shop_response.g.dart';

@JsonSerializable()
class ShopResponse {

  ShopResponse();

  factory ShopResponse.fromJson(Map<String, dynamic> json) => _$ShopResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ShopResponseToJson(this);

}
