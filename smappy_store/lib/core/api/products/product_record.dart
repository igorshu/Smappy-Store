import 'package:json_annotation/json_annotation.dart';
import 'package:smappy_store/core/api/products/product.dart';

part 'product_record.g.dart';


@JsonSerializable(explicitToJson: true)
class ProductRecord {

  final Product product;
  bool deleted;

  ProductRecord({required this.product, required this.deleted});

  factory ProductRecord.fromProduct(Product product) {
    return ProductRecord(
      product: product,
      deleted: false,
    );
  }

  factory ProductRecord.fromJson(Map<String, dynamic> json) => _$ProductRecordFromJson(json);
  Map<String, dynamic> toJson() => _$ProductRecordToJson(this);
}