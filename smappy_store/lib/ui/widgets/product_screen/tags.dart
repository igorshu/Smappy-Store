import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:smappy_store/core/api/products/product.dart';
import 'package:smappy_store/ui/other/styles.dart';

class Tags extends StatelessWidget {

  final Product? product;

  const Tags({required this.product, Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('tags'.tr(), style: AppStyles.labelTextStyle),
              const SizedBox(width: 5),
              Text('${product!.tags?.length ?? 0}', style: AppStyles.tagsCountTextStyle),
            ]
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(right: 25),
            child: Wrap(
              spacing: 5,
              runSpacing: 1,
              children: product!.tags?.map((tag) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                  child: Text('#${tag.name}', style: AppStyles.tagShowTextStyle),
                );
              }).toList() ?? [],
            ),
          ),
        ],
      ),
    );
  }

}