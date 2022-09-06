import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smappy_store/core/api/shop/shop_response.dart';
import 'package:smappy_store/core/repository/api_repo.dart';
import 'package:smappy_store/core/repository/local_repo.dart';
import 'package:smappy_store/logic/other/base_bloc.dart';
import 'package:smappy_store/logic/settings_bloc/shop_data.dart';

part 'auth_bloc.freezed.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends BaseBloc<AuthEvent, AuthState> {

  StreamSubscription<String?>? authSub;

  @override
  AuthEvent getErrorEvent(String error) => LoginError(error: error);

  AuthBloc() : super(const AuthState()) {
    on<Login>(_login);
    on<LoginError>(_loginError);
    on<Logout>(_logout);
    on<UpdateToken>(_updateToken);

    authSub = LocalRepo.listenToken().listen((token) => add(UpdateToken(token: token ?? '')));
  }

  _login(Login event, Emitter<AuthState> emit) async {
    emit(const AuthState(logging: true));
    ShopResponse shopResponse = await ApiRepo.shopLogin(event.phone, event.password);
    await LocalRepo.saveToken(shopResponse.token);
    await LocalRepo.saveShopData(ShopData.fromShopResponse(shopResponse));
    await LocalRepo.saveCountryDelivery(shopResponse.allowCountryDelivery);
    await LocalRepo.savePhoto(shopResponse.photo);
    ApiRepo.setAuthToken(shopResponse.token);
    await LocalRepo.saveShopId(shopResponse.id);
    emit(AuthState(token: shopResponse.token, logging: false));
  }

  _loginError(LoginError event, Emitter<AuthState> emit) {
    emit(AuthState(error: event.error, logging: false));
  }

  _logout(Logout event, Emitter<AuthState> emit) async {
    await LocalRepo.clearToken();
    await LocalRepo.saveShopData(null);
  }

  @override
  Future<void> close() async {
    authSub?.cancel();
    await super.close();
  }

  _updateToken(UpdateToken event, Emitter<AuthState> emit) {
    emit(state.copyWith(token: event.token));
  }
}
