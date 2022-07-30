import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:smappy_store/core/api/products/product.dart';
import 'package:smappy_store/ui/widgets/product_screen/photo.dart';

class Photos extends FormBuilderField<List<String>> {

  final Product? product;
  final List<String> localPhotos;

  Photos({super.key, required String name, required this.product, required this.localPhotos})
    : super(
    name: name,
    initialValue: localPhotos,
    builder: (FormFieldState<List<String>> field) {
      field.setValue(localPhotos);

      return Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Align(
          alignment: Alignment.centerLeft,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...(product?.productPhotos ?? []).map((photo) => PhotoWidget(PhotoData(url: photo.photo, local: false))).toList(),
                ...localPhotos.map((path) => PhotoWidget(PhotoData(url: path, local: true))).toList(),
              ],
            ),
          ),
        ),
      );
    }
  );

}