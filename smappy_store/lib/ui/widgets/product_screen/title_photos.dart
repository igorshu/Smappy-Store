import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smappy_store/core/api/products/product.dart';
import 'package:smappy_store/logic/product_bloc/product_bloc.dart';
import 'package:smappy_store/ui/widgets/product_screen/photos.dart';
import 'package:smappy_store/ui/widgets/purple_text.dart';
import 'package:smappy_store/ui/widgets/semi_bold_title_text.dart';

class TitlePhotos extends StatefulWidget {

  final String title;
  final String name;
  final ProductAction action;
  final Product? product;

  const TitlePhotos(this.title, {Key? key, required this.action, required this.product, required this.name}): super(key: key);

  @override
  State<StatefulWidget> createState() => _TitlePhotosState();

}

class _TitlePhotosState extends State<TitlePhotos> {

  bool editing = false;
  List<String> localPhotos = [];

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
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: SemiBoldTitleText(widget.title),
            ),
            Visibility(
              visible: widget.action != ProductAction.show,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () async {
                  final ImagePicker picker = ImagePicker();
                  final List<XFile>? images = await picker.pickMultiImage();
                  setState(() {
                    localPhotos = images?.map((xfile) => xfile.path).toList() ?? [];
                  });
                },
                child: Padding(
                    padding: const EdgeInsets.only(left: 5, top: 20, bottom: 20, right: 20),
                    child: PurpleText(actionText),
                )
              ),
            ),
          ]
        ),
        Photos(name: widget.name, product: widget.product, localPhotos: localPhotos),
      ],
    );
  }

}