part of 'shop_bloc.dart';

@freezed
class ShopState with _$ShopState {

  const ShopState._();

  bool get isError => error.isNotEmpty;

  factory ShopState({
    @Default('') String error,
    @Default(false) bool loading,
    @Default(null) String? shopName,
    @Default(null) List<Product>? products,
  }) = _ShopState;
}