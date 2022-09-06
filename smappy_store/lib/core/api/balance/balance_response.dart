import 'package:freezed_annotation/freezed_annotation.dart';

part 'balance_response.g.dart';

@JsonSerializable()
class BalanceResponse {

  final double balance;

  BalanceResponse(this.balance);

  factory BalanceResponse.fromJson(Map<String, dynamic> json) => _$BalanceResponseFromJson(json);
  Map<String, dynamic> toJson() => _$BalanceResponseToJson(this);
}