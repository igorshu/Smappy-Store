import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:smappy_store/core/api/products/category.dart';
import 'package:smappy_store/ui/other/styles.dart';
import 'package:smappy_store/ui/widgets/product_screen/category_widget.dart';

class EditableCategories extends FormBuilderField<List<String>> {

  final List<Category> productCategories;
  final List<Category> categories;
  final bool editing;

  EditableCategories({super.key, required String name, required this.productCategories, required this.categories, required this.editing})
    : super(
      name: name,
      initialValue: productCategories.map((category) => category.id.toString()).toList(),
      builder: (FormFieldState<List<String>> field) {
        bool selected(Category category) {
          return (field.value ?? []).map((id) => id).contains(category.id.toString());
        }

        List<Widget> _categories(String title, Iterable<Category> categories) {
          return [
            Text(
              title,
              style: AppStyles.editCategoriesTextStyle,
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 0,
              runSpacing: 0,
              children: categories.map((category) {
                var sel = selected(category);

                return AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOutCubic,
                  child: SizedBox(
                    width: editing ? null : sel ? null : 0,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 0, top: 0, right: 10, bottom: 10),
                      child: GestureDetector(
                        onTap: () {
                          var resCategories = field.value ?? productCategories.map((category) => category.id.toString()).toList();
                          if (resCategories.indexWhere((id) => category.id.toString() == id) != -1) {
                            resCategories.removeWhere((id) => category.id.toString() == id);
                          } else {
                            resCategories.add(category.id.toString());
                          }

                          field.didChange(resCategories);
                        },
                        child: CategoryWidget(category: category, active: sel && editing, showIcon: editing),
                      ),
                    ),
                  ),
                );
              }).toList(),
            )
          ];
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ..._categories('add_good_title_holiday'.tr(), categories.where((category) => category.accessory)),
            const SizedBox(height: 20),
            ..._categories('add_good_title_category'.tr(), categories.where((category) => !category.accessory)),
          ],
        );
      }
    );
}
