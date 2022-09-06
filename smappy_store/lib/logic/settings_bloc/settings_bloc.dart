import 'dart:async';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:rxdart/rxdart.dart';
import 'package:smappy_store/core/api/orders/order.dart';
import 'package:smappy_store/core/api/payment_info/payment_info.dart';
import 'package:smappy_store/core/api/shop/shop_response.dart';
import 'package:smappy_store/core/keys/keys.dart';
import 'package:smappy_store/core/repository/api_repo.dart';
import 'package:smappy_store/core/repository/local_repo.dart';
import 'package:smappy_store/logic/other/base_bloc.dart';
import 'package:smappy_store/logic/settings_bloc/city.dart';
import 'package:smappy_store/logic/settings_bloc/shop_data.dart';
import 'package:smappy_store/ui/other/ui_utils.dart';

part 'settings_bloc.freezed.dart';
part 'settings_event.dart';
part 'settings_state.dart';
part 'status.dart';

class SettingsBloc extends BaseBloc<SettingsEvent, SettingsState> {

  final _shopNameStream = BehaviorSubject<String?>();
  final _shopDescriptionStream = BehaviorSubject<String?>();
  final _shopAddressStream = BehaviorSubject<String?>();
  final _shopWhatsappStream = BehaviorSubject<String?>();
  final _shopTelegramStream = BehaviorSubject<String?>();
  final _shopEmailStream = BehaviorSubject<String?>();

  final _searchStream = BehaviorSubject<String>();

  SettingsBloc() : super(SettingsState()) {
    on<SettingsPageChanged>(_pageChanged);
    on<SettingsError>(_settingsError);
    on<DeliveryError>(_deliveryError);
    on<RequisitesError>(_requisitesError);
    on<TypeChanged>(_typeChanged);
    on<SaveSelfEmployed>(_saveSelfEmployed);
    on<SaveEnterprise>(_saveEnterprise);
    on<OfferAccepted>(_offerAccepted);
    on<GetSettingsData>(_getSettingsData);
    on<ResetRequisitesSaved>(_resetRequisitesSaved);
    on<ResetOrderStatusChanged>(_resetOrderStatusChanged);
    on<GetBalance>(_getBalance);
    on<ChangeStatus>(_changeStatus);

    //main
    on<SearchChanged>(_searchChanged);
    on<CitySelected>(_citySelected);
    on<DeliveryEverywhere>(_deliveryEverywhere);
    on<EditCities>(_editCities);
    on<CityForDeleting>(_cityForDeleting);
    on<RemoveCities>(_removeCities);
    on<AddImage>(_addImage);
    on<UploadLogo>(_uploadLogo);
    on<_SearchResults>(_searchResults);

    // Support
    on<SupportEmail>(_supportEmail);
    on<SupportAbout>(_supportAbout);
    on<SupportPolicy>(_supportPolicy);
    on<SupportTerms>(_supportTerms);

    // 4
    on<ChangePassword>(_changePassword);
    on<DeleteShop>(_deleteShop);

    // shop data changed
    on<_ChangedShopData>(_changedShopData);
    on<ChangedShopName>(_changedShopName);
    on<ChangedShopDescription>(_changedShopDescription);
    on<ChangedShopAddress>(_changedShopAddress);
    on<ChangedShopWhatsapp>(_changedShopWhatsapp);
    on<ChangedShopTelegram>(_changedShopTelegram);
    on<ChangedShopEmail>(_changedShopEmail);
  }

  @override
  SettingsEvent getErrorEvent(String error) {
    switch (state.page) {
      case 0: // delivery modal
        return DeliveryError(error: error);
      case 2: // requisites, all orders, order
        return RequisitesError(error: error);
    }
    return SettingsError(error: error);
  }

  _settingsError(SettingsError event, Emitter<SettingsState> emit) {
    emit(state.copyWith(error: event.error, loading: false));
  }

  _deliveryError(DeliveryError event, Emitter<SettingsState> emit) {
    emit(state.copyWith(deliveryError: event.error, loading: false));
  }

  _pageChanged(SettingsPageChanged event, Emitter<SettingsState> emit) {
    emit(state.copyWith(page: event.page));
  }

  _typeChanged(TypeChanged event, Emitter<SettingsState> emit) {
    emit(state.copyWith(selfEmployed: event.selfEmployed));
  }

  _requisitesError(RequisitesError event, Emitter<SettingsState> emit) {
    emit(state.copyWith(requisitesError: event.error, buttonActive: true));
  }

  _saveSelfEmployed(SaveSelfEmployed event, Emitter<SettingsState> emit) async {
    emit(state.copyWith(loading: true, buttonActive: false));
    await ApiRepo.savePaymentInfo(
      PaymentInfo.fromSelfEmployedEvent(event, state)
    );
    emit(state.copyWith(loading: false, buttonActive: true, requisitesSaved: true));
  }

  _saveEnterprise(SaveEnterprise event, Emitter<SettingsState> emit) async {
    emit(state.copyWith(loading: true, buttonActive: false));
    await ApiRepo.savePaymentInfo(
        PaymentInfo.fromEnterpriseEvent(event, state) // TODO check this
    );
    emit(state.copyWith(loading: false, buttonActive: true));
  }

  _offerAccepted(OfferAccepted event, Emitter<SettingsState> emit) {
    emit(state.copyWith(buttonActive: event.checked));
  }

  _resetRequisitesSaved(ResetRequisitesSaved event, Emitter<SettingsState> emit) => emit(state.copyWith(requisitesSaved: false));

  _resetOrderStatusChanged(ResetOrderStatusChanged event, Emitter<SettingsState> emit) => emit(state.copyWith(orderStatusChanged: false));

  _supportEmail(SupportEmail event, Emitter<SettingsState> emit) {
    sendEmail(
      recipient: 'stores@smappy.co',
      subject: 'Smappy',
      text: 'Email: ${event.email}\n'
          'Phone: ${event.phone}\n'
          'Message: ${event.message}\n'
    );
  }

  _supportAbout(SupportAbout event, Emitter<SettingsState> emit) async {
    String url = 'https://smappy.ru';
    if (!await openUrl(url)) {
      emit(state.copyWith(error: 'settings_cant_launch_url'.tr(namedArgs: {'url': url})));
    }
  }

  _supportPolicy(SupportPolicy event, Emitter<SettingsState> emit) async {
    String url = 'https://smappy.ru/agreements';
    if (!await openUrl(url)) {
      emit(state.copyWith(error: 'settings_cant_launch_url'.tr(namedArgs: {'url': url})));
    }
  }

  _supportTerms(SupportTerms event, Emitter<SettingsState> emit) async {
    String url = 'https://smappy.ru/agreements';
    if (!await openUrl(url)) {
      emit(state.copyWith(error: 'settings_cant_launch_url'.tr(namedArgs: {'url': url})));
    }
  }

  _changePassword(ChangePassword event, Emitter<SettingsState> emit) async {
    String url = 'https://smappy.ru/password-store';
    if (!await openUrl(url)) {
      emit(state.copyWith(error: 'settings_cant_launch_url'.tr(namedArgs: {'url': url})));
    }
  }

  _deleteShop(DeleteShop event, Emitter<SettingsState> emit) async {
    await ApiRepo.deleteShop(event.phone);
    await LocalRepo.clearToken(); // check authBloc
    await LocalRepo.saveShopData(null);
  }

  _getSettingsData(GetSettingsData event, Emitter<SettingsState> emit) async {
    emit(state.copyWith(loading: true));

    var paymentInfo = await ApiRepo.getPaymentInfo();
    emit(state.copyWith(paymentInfo: paymentInfo));

    var orders = await ApiRepo.getOrders();
    emit(state.copyWith(orders: orders));

    var cities = await ApiRepo.getMyCities();
    emit(state.copyWith(deliveryCities: cities));

    var shopResponse = await ApiRepo.getShop();

    await LocalRepo.saveShopData(ShopData.fromShopResponse(shopResponse));
    await LocalRepo.saveCountryDelivery(shopResponse.allowCountryDelivery);
    await LocalRepo.savePhoto(shopResponse.photo);

    var shopData = ShopData.fromShopResponse(shopResponse);
    var allowCountryDelivery = shopResponse.allowCountryDelivery;
    var photo = shopResponse.photo;

    emit(state.copyWith(
      loading: false,
      shopData: shopData,
      allowCountryDelivery: allowCountryDelivery ?? false,
      photo: photo,
    ));

    CombineLatestStream.combine6<String?, String?, String?, String?, String?, String?, ShopData>(
        _shopNameStream,
        _shopDescriptionStream,
        _shopAddressStream,
        _shopWhatsappStream,
        _shopTelegramStream,
        _shopEmailStream,
          (name, description, address, whatsapp, telegram, email) {
            return ShopData(
              name: name,
              description: description,
              address: address,
              whatsapp: whatsapp,
              instagram: telegram,
              email: email,
            );
          }
    )
      .debounceTime(const Duration(milliseconds: 700))
      .distinct()
      .listen((data) {
        if (data != state.shopData) {
          add(_ChangedShopData(data: data));
        }
      });

    _shopNameStream.add(shopData.name);
    _shopDescriptionStream.add(shopData.description);
    _shopAddressStream.add(shopData.address);
    _shopWhatsappStream.add(shopData.whatsapp);
    _shopTelegramStream.add(shopData.instagram);
    _shopEmailStream.add(shopData.email);

    _searchStream
        .debounceTime(const Duration(milliseconds: 700))
        .distinct()
        .listen((searchText) async {
          if (searchText.isEmpty) {
            add(const _SearchResults(searchResults: [], searchText: ''));
            return;
          }

          var response = await GoogleMapsPlaces(apiKey: Keys.placesGoogleApiKey)
              .autocomplete(searchText, language: 'ru', types: ['(cities)'], region: 'ru');
          if (response.status == GoogleResponseStatus.okay) {
            List<City> results = response.predictions
                .where((e) => e.placeId != null && e.terms.isNotEmpty)
                .map((e) => City(placeId: e.placeId!, name: e.terms[0].value))
                .toList();
            add(_SearchResults(searchResults: results, searchText: searchText));
          } else if (response.status == GoogleResponseStatus.zeroResults) {
            add(const _SearchResults(searchResults: [], searchText: ''));
            return;
          } else {
            add(DeliveryError(error: response.errorMessage ?? 'settings_google_places_error'.tr()));
          }
        });
  }

  _getBalance(event, Emitter<SettingsState> emit) async {
    var balanceResponse = await ApiRepo.getBalance();
    emit(state.copyWith(balance: balanceResponse.balance));
  }

  _changeStatus(ChangeStatus event, Emitter<SettingsState> emit) async {
    await ApiRepo.changeOrderStatus(event.orderId, event.status.status);

    var orders = await ApiRepo.getOrders();
    emit(state.copyWith(orders: orders, orderStatusChanged: true));
  }

  @override
  Future<void> close() async {
    _shopNameStream.close();
    _shopDescriptionStream.close();
    _shopAddressStream.close();
    _shopWhatsappStream.close();
    _shopTelegramStream.close();
    _shopEmailStream.close();
    _searchStream.close();
    await super.close();
  }

  _changedShopName(ChangedShopName event, Emitter<SettingsState> emit) => _shopNameStream.add(event.name);

  _changedShopDescription(ChangedShopDescription event, Emitter<SettingsState> emit) => _shopDescriptionStream.add(event.description);

  _changedShopAddress(ChangedShopAddress event, Emitter<SettingsState> emit) => _shopAddressStream.add(event.address);

  _changedShopWhatsapp(ChangedShopWhatsapp event, Emitter<SettingsState> emit) => _shopWhatsappStream.add(event.whatsapp);

  _changedShopTelegram(ChangedShopTelegram event, Emitter<SettingsState> emit) => _shopTelegramStream.add(event.telegram);

  _changedShopEmail(ChangedShopEmail event, Emitter<SettingsState> emit) => _shopEmailStream.add(event.email);

  _changedShopData(_ChangedShopData event, Emitter<SettingsState> emit) async {
    var shopResponse = await ApiRepo.saveShop(
      name: event.data.name,
      description: event.data.description,
      address: event.data.address,
      whatsapp: event.data.whatsapp,
      telegram: event.data.instagram,
      email: event.data.email,
    );
    await LocalRepo.saveShopData(ShopData.fromShopResponse(shopResponse));
    await LocalRepo.saveCountryDelivery(shopResponse.allowCountryDelivery);
    await LocalRepo.savePhoto(shopResponse.photo);
    emit(state.copyWith(shopData: ShopData.fromShopResponse(shopResponse)));
  }

  _searchChanged(SearchChanged event, Emitter<SettingsState> emit) async {
    _searchStream.add(event.searchText);
  }

  _citySelected(CitySelected event, Emitter<SettingsState> emit) async {
    emit(state.copyWith(citySearchResults: []));

    await ApiRepo.addCity(city: event.city);
    var cities = await ApiRepo.getMyCities();
    emit(state.copyWith(deliveryCities: cities, citySearchResults: [], searchText: ''));
  }

  _deliveryEverywhere(DeliveryEverywhere event, Emitter<SettingsState> emit) async {
    ShopResponse shopResponse = await ApiRepo.saveDelivery(everywhere: event.everywhere);
    emit(state.copyWith(
      shopData: ShopData.fromShopResponse(shopResponse),
      allowCountryDelivery: shopResponse.allowCountryDelivery ?? false,
      photo: shopResponse.photo,
    ));
  }

  _editCities(EditCities event, Emitter<SettingsState> emit) => emit(state.copyWith(editCities: event.edit));

  _cityForDeleting(CityForDeleting event, Emitter<SettingsState> emit) {
    var citiesForDeleting = List.from(state.citiesForDeleting).cast<City>();
    if (event.delete) {
      citiesForDeleting.remove(event.city);
    } else {
      citiesForDeleting.add(event.city);
    }
    emit(state.copyWith(citiesForDeleting: citiesForDeleting));
  }

  _addImage(AddImage event, Emitter<SettingsState> emit) {}

  _uploadLogo(UploadLogo event, Emitter<SettingsState> emit) async {
    emit(state.copyWith(loading: true));
    ShopResponse shopResponse = await ApiRepo.addAvatar(image: File(event.path));
    emit(state.copyWith(
      loading: false,
      shopData: ShopData.fromShopResponse(shopResponse),
      allowCountryDelivery: shopResponse.allowCountryDelivery ?? false,
      photo: shopResponse.photo,
    ));
  }

  _removeCities(RemoveCities event, Emitter<SettingsState> emit) async {
    await Future.forEach(state.citiesForDeleting, (City city) async {
      await ApiRepo.removeCity(placeId: city.placeId);
    });
    var cities = await ApiRepo.getMyCities();
    emit(state.copyWith(
      citiesForDeleting: [],
      deliveryCities: cities,
      editCities: false,
    ));
  }

  _searchResults(_SearchResults event, Emitter<SettingsState> emit) {
    if (event.searchResults.isNotEmpty) {
      emit(state.copyWith(
          citySearchResults: event.searchResults,
          searchText: event.searchText,
          deliveryError: '',
      ));
    } else {
      emit(state.copyWith(
        citySearchResults: event.searchResults,
        searchText: event.searchText,
      ));
    }
  }
}
