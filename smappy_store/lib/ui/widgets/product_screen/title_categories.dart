import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:smappy_store/core/api/products/category.dart';
import 'package:smappy_store/core/api/products/product.dart';
import 'package:smappy_store/logic/product_bloc/product_bloc.dart';
import 'package:smappy_store/ui/widgets/product_screen/editable_categories.dart';
import 'package:smappy_store/ui/widgets/purple_text.dart';
import 'package:smappy_store/ui/widgets/semi_bold_title_text.dart';

class TitleCategories extends StatefulWidget {

  final String title;
  final String name;
  final ProductAction action;
  final Product? product;
  final List<Category> categories;

  const TitleCategories(this.title, {Key? key, required this.name, required this.action, required this.product, required this.categories}): super(key: key);

  @override
  State<StatefulWidget> createState() => _TitleCategoriesState();
}

class _TitleCategoriesState extends State<TitleCategories> {

  bool editing = false;

  @override
  Widget build(BuildContext context) {
    String actionText = '';
    if (editing) {
      actionText = 'add_good_ready'.tr();
    } else {
      if (widget.action == ProductAction.add) {
        actionText = 'add'.tr();
      } else if (widget.action == ProductAction.edit) {
        actionText = 'add_good_edit'.tr();
      } else if (widget.action == ProductAction.show) {
        actionText = '';
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 0, bottom: 0),
              child: SemiBoldTitleText(widget.title),
            ),
            Visibility(
              visible: widget.action != ProductAction.show,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => setState(() => editing = !editing),
                child: Padding(
                  padding: const EdgeInsets.only(left: 5, top: 0, bottom: 0, right: 20),
                  child: PurpleText(actionText),
                )
              ),
            ),
          ]
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: EditableCategories(name: widget.name, productCategories: widget.product?.categories ?? [], allCategories: widget.categories, editing: editing),
        ),
      ],
    );
  }

}