part of 'shop_bloc.dart';

@freezed
class ShopEvent with _$ShopEvent {
  const factory ShopEvent.error({required String error}) = ShopError;
  const factory ShopEvent.loadProduct() = LoadProducts;
}