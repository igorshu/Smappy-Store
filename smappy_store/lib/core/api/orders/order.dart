import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

@JsonSerializable(includeIfNull: false, )
class Order {

  String get contentList => items.map((item) => item.title).join('\n');

  final int id;
  final String? address;
  final String? date;
  final List<OrderItem> items;
  final String? name;
  final String? phoneNumber;
  final String? receiverName;
  final int shopId;
  final String? status;
  final String? subtotal;
  final String? tax;
  final String? total;
  final int? userId;

  Order({
    required this.id,
    required this.shopId,
    this.address,
    this.date,
    required this.items,
    this.name,
    this.phoneNumber,
    this.receiverName,
    this.status,
    this.subtotal,
    this.tax,
    this.total,
    this.userId,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  Map<String, dynamic> toJson() => _$OrderToJson(this);
}

@JsonSerializable(includeIfNull: false)
class OrderItem {

    final int id;
    final int count;
    final String imageURL;
    final int price;
    final String title;

    OrderItem({
      required this.count,
      required this.id,
      required this.imageURL,
      required this.price,
      required this.title,
    });

    factory OrderItem.fromJson(Map<String, dynamic> json) => _$OrderItemFromJson(json);
    Map<String, dynamic> toJson() => _$OrderItemToJson(this);
}