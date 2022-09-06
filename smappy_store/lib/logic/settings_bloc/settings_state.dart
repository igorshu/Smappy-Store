part of 'settings_bloc.dart';

@freezed
class SettingsState with _$SettingsState {

  SettingsState._();

  List<Order?> get first3Orders {
    List<Order?> result = orders.take(3).map((e) => e as Order?).toList();
    result.addAll(List.filled(3 - result.length, null));
    return result;
  }

  List<Order> get ordersNew => orders.where((order) => order.status == Status.new_.status).toList();
  List<Order> get ordersDeliveredShop => orders.where((order) => order.status == Status.deliveredShop.status).toList();
  List<Order> get ordersCompleted => orders.where((order) => order.status == Status.completed.status).toList();
  List<Order> get ordersCanceled => orders.where((order) => order.status == Status.canceled.status).toList();

  bool get isSelfEmployed => selfEmployed;
  bool get isError => error.isNotEmpty;
  bool get isCitiesResultEmpty => citySearchResults.isEmpty;
  String get getFirstLetter => shopData?.name?.substring(0, 1) ?? '';

  bool isForDeleting(City city) => citiesForDeleting.contains(city);

  factory SettingsState({
    @Default('') String error, // settings screen
    @Default('') String deliveryError, // settings main modal
    @Default('') String requisitesError,
    @Default(0) int page,
    @Default([]) List<Order> orders,
    @Default(false) bool buttonActive,
    @Default(false) bool loading,
    @Default(true) bool selfEmployed,
    @Default(false) bool requisitesSaved,
    PaymentInfo? paymentInfo,
    @Default(0.0) double balance,
    @Default(false) bool orderStatusChanged,
    @Default([]) List<City> citySearchResults,
    @Default(false) bool editCities,
    @Default([]) List<City> citiesForDeleting,
    @Default(null) ShopData? shopData,
    @Default(null) String? photo,
    @Default(false) bool allowCountryDelivery,
    @Default([]) List<City> deliveryCities,
    @Default('') String searchText,
  }) = _SettingsState;
}
