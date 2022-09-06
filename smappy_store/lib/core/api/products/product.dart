import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smappy_store/core/api/add_save_product/add_product_response.dart';
import 'package:smappy_store/core/api/products/category.dart';
import 'package:smappy_store/core/api/products/photo.dart';
import 'package:smappy_store/core/api/products/tag.dart';

part 'product.g.dart';

@JsonSerializable(explicitToJson: true)
class Product {

  final int id;
  final String name;
  @JsonKey(name: 'web_site') final String webSite;
  final String description;
  final String price;
  @JsonKey(name: 'create_time') final String? createdAt;
  final List<Tag>? tags;
  final List<Category>? categories;
  final bool available;
  final bool isDigital;
  final String likesCount;
  final String dislikesCount;
  final String reviewsCount;
  final String? avgRating;
  @JsonKey(name: 'product_photos') final List<Photo>? productPhotos;

  Product({
    required this.id,
    required this.name,
    required this.webSite,
    required this.description,
    required this.price,
    this.createdAt,
    required this.tags,
    required this.categories,
    required this.available,
    required this.isDigital,
    required this.likesCount,
    required this.dislikesCount,
    required this.reviewsCount,
    this.avgRating,
    required this.productPhotos,
  }
  );

  factory Product.fromProductResponse(ProductResponse response) {
    return Product(
      id: response.id,
      name: response.name,
      webSite: response.webSite,
      description: response.description,
      price: response.price,
      tags: response.tags,
      categories: response.categories,
      available: response.available,
      isDigital: response.isDigital,
      likesCount: response.likesCount?.toString() ?? '0',
      dislikesCount: response.dislikesCount?.toString() ?? '0',
      reviewsCount: response.reviewsCount?.toString() ?? '0',
      productPhotos: response.productPhotos,
    );
  }

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);

  String get tags2String => tags?.map((tag) => '#${tag.name}').toList().join(', ') ?? '';
}