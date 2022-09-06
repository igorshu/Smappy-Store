part of 'product_bloc.dart';

@freezed
class ProductState with _$ProductState {

  const ProductState._();

  bool get isError => error.isNotEmpty;
  bool get isShow => action == ProductAction.show;
  bool get isEdit => action == ProductAction.edit;
  bool get isAdd => action == ProductAction.add;

  factory ProductState({
    @Default('') String error,
    @Default(false) bool loading,
    @Default(false) bool saving,
    @Default(false) bool added,
    @Default(false) bool deleted,
    @Default(ProductAction.show) ProductAction action,
    @Default(null) Product? product,
    @Default(null) List<Category>? categories,
  }) = _ProductState;
}