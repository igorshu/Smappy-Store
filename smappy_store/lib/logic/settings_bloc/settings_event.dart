part of 'settings_bloc.dart';

@freezed
class SettingsEvent with _$SettingsEvent {
  const factory SettingsEvent.error({required String error}) = SettingsError;
  const factory SettingsEvent.deliveryError({required String error}) = DeliveryError;
  const factory SettingsEvent.requisitesError({required String error}) = RequisitesError;
  const factory SettingsEvent.pageChanged({required int page}) = SettingsPageChanged;
  const factory SettingsEvent.getSettingsData() = GetSettingsData;
  const factory SettingsEvent.getOrdersData() = GetOrdersData;

  // main
  const factory SettingsEvent.offerAccepted({required bool checked}) = OfferAccepted;
  const factory SettingsEvent.searchChanged({required String searchText}) = SearchChanged;
  const factory SettingsEvent.citySelected({required City city}) = CitySelected;
  const factory SettingsEvent.deliveryEverywhere({required bool everywhere}) = DeliveryEverywhere;
  const factory SettingsEvent.editCities({required bool edit}) = EditCities;
  const factory SettingsEvent.removeCities() = RemoveCities;
  const factory SettingsEvent.cityForDeleting({required bool delete, required City city}) = CityForDeleting;
  const factory SettingsEvent.addImage({required String name, required File image}) = AddImage;
  const factory SettingsEvent.uploadLogo({required String path}) = UploadLogo;
  const factory SettingsEvent.searchResults({required List<City> searchResults, required String searchText}) = _SearchResults;

  // orders
  const factory SettingsEvent.typeChanged({required bool selfEmployed}) = TypeChanged;
  const factory SettingsEvent.getBalance() = GetBalance;
  const factory SettingsEvent.resetRequisitesSaved() = ResetRequisitesSaved;
  const factory SettingsEvent.resetOrderStatusChanged() = ResetOrderStatusChanged;
  const factory SettingsEvent.changeStatus({required String orderId, required Status status}) = ChangeStatus;
  const factory SettingsEvent.saveSelfEmployed({
    required String cardNumber,
    required String phoneNumber,
    required String email,
    required bool offer,
  }) = SaveSelfEmployed;
  const factory SettingsEvent.saveEnterprise({
    required String enterpriseName,
    required String enterpriseAccount,
    required String enterpriseBik,
    required String enterpriseLegalAddress,
    required String enterpriseRealAddress,
    required String enterpriseInn,
    required String enterpriseKpp,
    required String enterpriseSignatory,
    required String enterprisePhone,
    required String enterpriseEmail,
    required bool offer,
  }) = SaveEnterprise;

  // Support
  const factory SettingsEvent.supportEmail({required String email, required String phone, required String message}) = SupportEmail;
  const factory SettingsEvent.supportAbout() = SupportAbout;
  const factory SettingsEvent.supportPolicy() = SupportPolicy;
  const factory SettingsEvent.supportTerms() = SupportTerms;

  // 4
  const factory SettingsEvent.changePassword() = ChangePassword;
  // const factory SettingsEvent.logout() = SettingsLogout;
  const factory SettingsEvent.deleteShop({required String phone}) = DeleteShop;

  // shop Data changed
  const factory SettingsEvent.changedShopData({required ShopData data}) = _ChangedShopData;
  const factory SettingsEvent.changedShopName({required String name}) = ChangedShopName;
  const factory SettingsEvent.changedShopDescription({required String description}) = ChangedShopDescription;
  const factory SettingsEvent.changedShopAddress({required String address}) = ChangedShopAddress;
  const factory SettingsEvent.changedShopWhatsapp({required String whatsapp}) = ChangedShopWhatsapp;
  const factory SettingsEvent.changedShopTelegram({required String telegram}) = ChangedShopTelegram;
  const factory SettingsEvent.changedShopEmail({required String email}) = ChangedShopEmail;
}