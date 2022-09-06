import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logger/logger.dart';
import 'package:smappy_store/core/api/add_save_product/add_product_response.dart';
import 'package:smappy_store/core/api/products/category.dart';
import 'package:smappy_store/core/api/products/product.dart';
import 'package:smappy_store/core/api/products/product_record.dart';
import 'package:smappy_store/core/repository/api_repo.dart';
import 'package:smappy_store/core/repository/local_repo.dart';
import 'package:smappy_store/logic/other/base_bloc.dart';

part 'product_bloc.freezed.dart';
part 'product_event.dart';
part 'product_state.dart';

enum ProductAction {add, edit, show}

class ProductBloc extends BaseBloc<ProductEvent, ProductState> {

  ProductBloc(ProductAction action, Product? product): super(ProductState(action: action, product: product)) {
    on<ProductError>(_addEditError);
    on<AddProduct>(_addProduct);
    on<ProductEdit>(_productEdit);
    on<ProductSave>(_productSave);
    on<ProductSaving>(_productSaving);
    on<ProductDelete>(_productDelete);
    on<GetCategories>(_getCategories);
  }

  _addEditError(ProductError event, Emitter<ProductState> emit) {
    emit(state.copyWith(error: event.error, loading: false));
  }

  _addProduct(AddProduct event, Emitter<ProductState> emit) async {
    emit(state.copyWith(loading: true));
    Logger().d(event);
    var imageList = event.photos.map((photo) => File(photo)).toList();

    ProductResponse productResponse = await ApiRepo.addProduct(
      name: event.name,
      price: event.price!,
      webSite: event.link,
      description: event.description,
      categories: event.categories.isEmpty ? null : event.categories.join(','),
      tags: event.tags.isEmpty ? null : event.tags, // "tags" is not allowed to be empty
      photos: imageList,
      inGiftForList: null, // TODO add
    );

    Product product = Product.fromProductResponse(productResponse);
    var productRecord = ProductRecord.fromProduct(product);
    var productRecords = await LocalRepo.getProductRecords();
    productRecords.add(productRecord);
    await LocalRepo.saveProductRecords(productRecords);

    emit(state.copyWith(loading: false, added: true));
  }

  @override
  ProductEvent getErrorEvent(String error) => ProductError(error: error);

  _productEdit(ProductEdit event, Emitter<ProductState> emit) {
    emit(state.copyWith(action: ProductAction.edit));
  }

  _productSave(ProductSave event, Emitter<ProductState> emit) async {
    emit(state.copyWith(loading: true, saving: false));
    Logger().d(event);

    var imageList = event.photos.map((photo) {
      return File(photo);
    }).toList();

    ProductResponse response = await ApiRepo.saveProduct(
      productId: event.productId,
      name: event.name,
      price: event.price!,
      webSite: event.link,
      description: event.description,
      categories: event.categories.isEmpty ? null : event.categories.join(','),
      tags: event.tags.isEmpty ? null : event.tags, // "tags" is not allowed to be empty
      photos: imageList,
      inGiftForList: null, // TODO add
    );

    Product product = Product.fromProductResponse(response);
    var productRecord = ProductRecord.fromProduct(product);
    var productRecords = await LocalRepo.getProductRecords();
    productRecords.removeWhere((pr) => pr.product.id == productRecord.product.id);
    productRecords.add(productRecord);
    await LocalRepo.saveProductRecords(productRecords);

    emit(state.copyWith(
      saving: false,
      loading: false,
      product: Product.fromProductResponse(response),
    ));
  }

  _productSaving(ProductSaving event, Emitter<ProductState> emit) {
    emit(state.copyWith(saving: true));
  }

  _productDelete(ProductDelete event, Emitter<ProductState> emit) async {
    emit(state.copyWith(loading: true));
    await ApiRepo.deleteProduct(event.product.id.toString());

    var productRecords = await LocalRepo.getProductRecords();
    productRecords.firstWhere((pr) => pr.product.id == event.product.id).deleted = true;
    await LocalRepo.saveProductRecords(productRecords);

    emit(state.copyWith(loading: false, deleted: true));
  }

  _getCategories(GetCategories event, Emitter<ProductState> emit) async {
    var categories = await LocalRepo.getCategories();
    emit(state.copyWith(categories: categories));
  }
}
