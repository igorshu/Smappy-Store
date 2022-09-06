import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:smappy_store/core/api/orders/order.dart';

class OrderWidget extends StatelessWidget {

  final Order? order;
  final Function()? onTap;

  const OrderWidget(this.order, {Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          child: Stack(
            children: [
              _placeHolder(),
              CachedNetworkImage(
                imageUrl: order?.items[0].imageURL ?? '',
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              )
            ],
          )
      ),
    );
  }

  Container _placeHolder() {
    return Container(
      color: const Color.fromRGBO(235, 235, 235, 1),
      width: double.infinity,
      height: double.infinity,
    );
  }

}