import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:smappy_store/core/api/products/product.dart';
import 'package:smappy_store/ui/other/styles.dart';

class Rating extends StatelessWidget {

  final Product? product;

  const Rating({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('add_good_rating'.tr(), style: AppStyles.ratingTextStyle),
            RichText(
              text: TextSpan(
                text: 'add_good_based_on_1'.tr(),
                style: AppStyles.basedOnTextStyle,
                children: [
                  TextSpan(
                    text: product!.reviewsCount,
                    style: AppStyles.reviewsCountTextStyle,
                  ),
                  TextSpan(
                    text: 'add_good_based_on_2'.tr(),
                    style: AppStyles.basedOnTextStyle,
                  ),
                ],
              ),
            ),
          ]
        ),
        const Spacer(),
        ..._stars(product!.avgRating ?? '0'),
        const SizedBox(width: 20),
      ],
    );
  }

  List<Widget> _stars(String rating) {
    int count = (double.tryParse(rating) ?? 0).round();
    List<Widget> stars = List.generate(count, (_) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3.5),
        child: Image.asset('assets/images/star.png', width: 20),
      );
    });
    List<Widget> starsEmpty = List.generate(5 - count, (_) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3.5),
        child: Image.asset('assets/images/star_empty.png', width: 20),
      );
    });
    return [...stars, ...starsEmpty];
  }

}