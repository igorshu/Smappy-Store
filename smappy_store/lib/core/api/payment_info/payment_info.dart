import 'package:json_annotation/json_annotation.dart';
import 'package:smappy_store/logic/settings_bloc/settings_bloc.dart';

part 'payment_info.g.dart';

@JsonSerializable(includeIfNull: false)
class PaymentInfo {

    final int? id;
    final String legalType;
    final String? legalPerson;
    final String? accountNumber;
    final String? bic;
    final String? cardNumber;
    final String? createdAt;
    final String? email;
    final String? kpp;
    final String? legalAddress;
    final String? address;
    final String? name;
    final String? phoneNumber;
    final int? shopId;
    final String? taxNumber;
    final String? updatedAt;

    PaymentInfo({
      required this.id,
      required this.accountNumber,
      required this.address,
      required this.bic,
      required this.cardNumber,
      required this.createdAt,
      required this.email,
      required this.kpp,
      required this.legalAddress,
      required this.legalPerson,
      required this.legalType,
      required this.name,
      required this.phoneNumber,
      required this.shopId,
      required this.taxNumber,
      required this.updatedAt,
    });

  factory PaymentInfo.fromJson(Map<String, dynamic> json) => _$PaymentInfoFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentInfoToJson(this);

  factory PaymentInfo.fromSelfEmployedEvent(SaveSelfEmployed event, SettingsState state) {
    return PaymentInfo(
      cardNumber: event.cardNumber,
      phoneNumber: event.phoneNumber,
      email: event.email,

      id: null, // is not allowed
      accountNumber: state.paymentInfo!.accountNumber,
      address: state.paymentInfo!.address,
      bic: state.paymentInfo!.bic,
      createdAt: null, // is not allowed
      kpp: state.paymentInfo!.kpp,
      legalAddress: state.paymentInfo!.legalAddress,
      legalPerson: state.paymentInfo!.legalPerson,
      legalType: state.paymentInfo!.legalType,
      name: state.paymentInfo!.name,
      taxNumber: state.paymentInfo!.taxNumber,
      shopId: null, // is not allowed
      updatedAt: null, // is not allowed
    );
  }

    factory PaymentInfo.fromEnterpriseEvent(SaveEnterprise event, SettingsState state) {
      return PaymentInfo(
        name: event.enterpriseName,
        accountNumber: event.enterpriseAccount,
        bic: event.enterpriseBik,
        legalAddress: event.enterpriseLegalAddress,
        address: event.enterpriseRealAddress,
        taxNumber: event.enterpriseInn,
        kpp: event.enterpriseKpp,
        legalPerson: event.enterpriseSignatory,
        phoneNumber: event.enterprisePhone,
        email: event.enterpriseEmail,

        id: state.paymentInfo!.id,
        shopId: state.paymentInfo!.shopId,
        legalType: state.paymentInfo!.legalType,
        createdAt: state.paymentInfo!.createdAt,
        updatedAt: state.paymentInfo!.updatedAt,
        cardNumber: state.paymentInfo!.cardNumber,
      );
    }
}