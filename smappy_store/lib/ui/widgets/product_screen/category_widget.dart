import 'package:flutter/material.dart';
import 'package:smappy_store/core/api/products/category.dart';
import 'package:smappy_store/ui/other/colors.dart';
import 'package:smappy_store/ui/other/styles.dart';

class CategoryWidget extends StatelessWidget {

  final Category category;
  final bool active;
  final bool showIcon;

  const CategoryWidget({super.key, required this.category, required this.active, required this.showIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        color: AppColors.category,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(category.name!, style: AppStyles.categoryTextStyle.copyWith(color: active ? AppColors.purple : AppColors.black, overflow: TextOverflow.ellipsis)),
            Visibility(
              visible: showIcon,
              child: Icon(active ? Icons.close : Icons.add, size: 18, color: active ? AppColors.purple : AppColors.black),
            ),
          ]
        ),
      ),
    );
  }

}