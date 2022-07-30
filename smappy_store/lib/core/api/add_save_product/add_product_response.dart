import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smappy_store/core/api/products/category.dart';
import 'package:smappy_store/core/api/products/photo.dart';
import 'package:smappy_store/core/api/products/tag.dart';

part 'add_product_response.g.dart';

@JsonSerializable()
class ProductResponse {

  final int id;
  final String name;
  @JsonKey(name: 'web_site') final String webSite;
  final String description;
  final String price;
  @JsonKey(name: 'create_time') String? createTime;
  final List<Tag>? tags;
  final List<Category>? categories;
  final bool available;
  final bool isDigital;
  final int? likesCount;
  final int? dislikesCount;
  final int? reviewsCount;
  final int? avgRating;
  final List<Photo>? productPhotos;

  ProductResponse(
    this.id, 
    this.name, 
    this.webSite,
    this.description,
    this.price, 
    this.createTime,
    this.tags,
    this.categories, 
    this.available, 
    this.isDigital,
    this.likesCount,
    this.dislikesCount, 
    this.reviewsCount, 
    this.avgRating,
    this.productPhotos,
  );

  factory ProductResponse.fromJson(Map<String, dynamic> json) => _$ProductResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ProductResponseToJson(this);
}