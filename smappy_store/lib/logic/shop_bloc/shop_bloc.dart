import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smappy_store/core/api/products/product.dart';
import 'package:smappy_store/core/repository/api_repo.dart';
import 'package:smappy_store/core/repository/local_repo.dart';
import 'package:smappy_store/logic/other/base_bloc.dart';

part 'shop_event.dart';
part 'shop_state.dart';

part 'shop_bloc.freezed.dart';

class ShopBloc extends BaseBloc<ShopEvent, ShopState> {

  @override
  getErrorEvent(String error) => ShopError(error: error);

  ShopBloc() : super(ShopState()) {
    on<ShopError>(_shopError);
    on<LoadProducts>(_loadProducts);
  }

  _shopError(ShopError event, Emitter<ShopState> emit) {
    emit(state.copyWith(error: event.error, loading: false));
  }


  _loadProducts(LoadProducts event, Emitter<ShopState> emit) async {
    emit(state.copyWith(loading: true));
    var categories = await ApiRepo.getCategories('RU'); // Available values : RU, EN
    await LocalRepo.saveCategories(categories);

    var shopId = await LocalRepo.getShopId();
    var remoteProducts = await ApiRepo.getProducts(shopId: shopId!);

    var localProducts = await LocalRepo.syncProductRecords(remoteProducts);
    emit(state.copyWith(loading: false, products: localProducts));
  }

}
