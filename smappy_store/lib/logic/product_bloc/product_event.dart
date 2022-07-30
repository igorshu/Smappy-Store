part of 'product_bloc.dart';

@freezed
class ProductEvent with _$ProductEvent {

  const factory ProductEvent.error({required String error}) = ProductError;
  const factory ProductEvent.productEdit() = ProductEdit;
  const factory ProductEvent.productDelete({required Product product}) = ProductDelete;
  const factory ProductEvent.productSaving() = ProductSaving;
  const factory ProductEvent.saveProduct({
    required String productId,
    required bool outOfStock,
    required bool digital,
    required String name,
    required double? price,
    required String link,
    required String description,
    required List<String> categories,
    required String tags,
    required List<String> photos,
  }) = ProductSave;
  const factory ProductEvent.addProduct({
    required bool outOfStock,
    required bool digital,
    required String name,
    required double? price,
    required String link,
    required String description,
    required List<String> categories,
    required String tags,
    required List<String> photos,
  }) = AddProduct;

}