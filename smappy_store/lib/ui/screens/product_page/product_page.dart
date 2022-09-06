import 'package:beamer/beamer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:smappy_store/logic/product_bloc/product_bloc.dart';
import 'package:smappy_store/logic/shop_bloc/shop_bloc.dart';
import 'package:smappy_store/ui/other/styles.dart';
import 'package:smappy_store/ui/other/text_controllers.dart';
import 'package:smappy_store/ui/other/text_formatters.dart';
import 'package:smappy_store/ui/other/ui_utils.dart';
import 'package:smappy_store/ui/other/validators.dart';
import 'package:smappy_store/ui/widgets/bold_title_text.dart';
import 'package:smappy_store/ui/widgets/error_text.dart';
import 'package:smappy_store/ui/widgets/fields/product_text_field.dart';
import 'package:smappy_store/ui/widgets/fields/tags_field.dart';
import 'package:smappy_store/ui/widgets/horizontal_gray_line.dart';
import 'package:smappy_store/ui/widgets/product_screen/app_check_box.dart';
import 'package:smappy_store/ui/widgets/product_screen/rating.dart';
import 'package:smappy_store/ui/widgets/product_screen/title_categories.dart';
import 'package:smappy_store/ui/widgets/product_screen/title_photos.dart';
import 'package:smappy_store/ui/widgets/purple_button.dart';

enum ProductPageEmbed {modal, widget}
class ProductPage extends StatefulWidget {

  static final _formKey = GlobalKey<FormBuilderState>();
  final ScrollController? scrollController;
  final ProductPageEmbed embed;

  const ProductPage({this.scrollController, Key? key, required this.embed}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {

  final RoubleEditingController _roubleController = RoubleEditingController(initial: '');

  @override
  void initState() {
    super.initState();

    context.read<ProductBloc>().add(const GetCategories());
  }

  @override
  Widget build(BuildContext context) {
    var st = context.watch<ProductBloc>().state;

    if (_roubleController.text.isEmpty) {
      _roubleController.text = st.product?.price ?? '';
    }

    if (st.added) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (widget.embed == ProductPageEmbed.modal) {
          context.read<ShopBloc>().add(const LoadProducts());
        }
        Navigator.of(context).pop();
      });
    }

    if (st.saving) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        hideKeyboard(context);
        ProductPage._formKey.currentState!.save();
        if (ProductPage._formKey.currentState!.validate()) {
          _save(context, st);
        } else {
          _handleError(context);
        }
      });
    }

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BoldTitleText(st.isShow || st.isEdit ? 'add_good_info'.tr() : 'add_good'.tr()),
            const Spacer(),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                if (widget.embed == ProductPageEmbed.widget) {
                  Beamer.of(context).beamBack();
                } else {
                  hideModalBottomSheet(context);
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 5, top: 5, bottom: 5, right: 20),
                child: Image.asset('assets/images/gray_close.png', width: 24),
              ),
            ),
          ],
        ),
        AbsorbPointer(
          absorbing: st.isShow,
          child: FormBuilder(
            key: ProductPage._formKey,
            autovalidateMode: AutovalidateMode.disabled,
            child: Column(
              children: [
                ErrorText(st.error),
                AppCheckBox(
                  'add_good_out_of_stock'.tr(),
                  name: 'out_of_stock',
                  initialValue: st.product?.available ?? false,
                ),
                const HorizontalGrayLine(),
                AppCheckBox(
                  'add_good_digital'.tr(),
                  name: 'digital',
                  initialValue: st.product?.isDigital ?? false,
                ),
                const HorizontalGrayLine(),
                ProductTextField(
                  initialValue: st.product?.name ?? '',
                  hintText: 'add_good_enter_name'.tr(),
                  labelText: 'add_good_label_name'.tr(),
                  name: 'good_name',
                  enabled: st.isEdit || st.isAdd,
                ),
                const HorizontalGrayLine(),
                ProductTextField(
                  hintText: 'add_good_enter_price'.tr(),
                  labelText: 'add_good_label_price'.tr(),
                  controller: _roubleController,
                  formatter: RoublesTextFormatter(),
                  valueTransformer: (value) {
                    return value?.replaceAll(' ', '').replaceAll(',', '.');
                  },
                  name: 'price',
                  keyboardType: TextInputType.number,
                  enabled: st.isEdit || st.isAdd,
                ),
                const HorizontalGrayLine(),
                TitlePhotos('add_good_photo'.tr(), name: 'photos', product: st.product, action: st.action),
                const HorizontalGrayLine(),
                ProductTextField(
                  initialValue: st.product?.webSite ?? '',
                  hintText: 'add_good_enter_link'.tr(),
                  labelText: 'add_good_label_link'.tr(),
                  name: 'link',
                  enabled: st.isEdit || st.isAdd,
                  required: false,
                ),
                const HorizontalGrayLine(),
                ProductTextField(
                  initialValue: st.product?.description ?? '',
                  hintText: 'add_good_enter_description'.tr(),
                  labelText: 'add_good_label_description'.tr(),
                  name: 'description',
                  enabled: st.isEdit || st.isAdd,
                ),
                const HorizontalGrayLine(top: 20, bottom: 20),
                TitleCategories(
                  'add_good_enter_categories_and_holidays'.tr(),
                  name: 'categories',
                  product: st.product,
                  action: st.action,
                  categories: st.categories ?? [],
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    text: TextSpan(
                      text: 'tags'.tr(),
                      style: AppStyles.tagsTitleTextStyle,
                      children: [
                        const WidgetSpan(child: SizedBox(width: 6)),
                        TextSpan(text: (st.product?.tags?.length ?? 0).toString(), style: AppStyles.tagsCountTextStyle),
                      ])),
                ),
                TagsField(
                  labelText: '',
                  hintText: 'add_good_enter_hashtags'.tr(),
                  initialValue: st.product?.tags2String ?? '',
                ),
                Visibility(
                  visible: !(st.isEdit),
                  child: const HorizontalGrayLine(top: 20, bottom: 20),
                ),
                Visibility(
                  visible: st.isShow,
                  child: Rating(product: st.product),
                ),
                const SizedBox(height: 20),
                Visibility(
                  visible: st.isAdd,
                  child: PurpleButton(
                    text: 'save'.tr(),
                    loadingText: 'add_good_saving'.tr(),
                    active: true,
                    loading: st.loading,
                    onTap: () {
                      hideKeyboard(context);
                      ProductPage._formKey.currentState!.save();
                      if (ProductPage._formKey.currentState!.validate()) {
                        _add(context, st);
                      } else {
                        _handleError(context);
                      }
                    },
                    padding: const EdgeInsets.only(right: 25, top: 20, bottom: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _handleError(BuildContext context) {
    var nameError = FormBuilderValidators.compose([requiredField('add_good_label_name'.tr())])(ProductPage._formKey.currentState!.value['good_name']);
    var priceError = FormBuilderValidators.compose([requiredField('add_good_label_price'.tr())])(ProductPage._formKey.currentState!.value['price']);
    var descriptionError = FormBuilderValidators.compose([requiredField('add_good_label_description'.tr())])(ProductPage._formKey.currentState!.value['description']);
    context.read<ProductBloc>().add(ProductError(error: nameError ?? priceError ?? descriptionError ?? 'unknown_error'.tr()));
  }

  void _add(BuildContext context, ProductState st) {
    context.read<ProductBloc>().add(
      AddProduct(
        outOfStock: ProductPage._formKey.currentState!.value['out_of_stock'],
        digital: ProductPage._formKey.currentState!.value['digital'],
        name: ProductPage._formKey.currentState!.value['good_name'],
        price: double.tryParse(ProductPage._formKey.currentState!.value['price']),
        link: ProductPage._formKey.currentState!.value['link'],
        description: ProductPage._formKey.currentState!.value['description'],
        categories: ProductPage._formKey.currentState!.value['categories'],
        tags: ProductPage._formKey.currentState!.value['tags'],
        photos: ProductPage._formKey.currentState!.value['photos']
      )
    );
  }

  void _save(BuildContext context, ProductState st) {
    context.read<ProductBloc>().add(
      ProductSave(
        productId: st.product!.id.toString(),
        outOfStock: ProductPage._formKey.currentState!.value['out_of_stock'],
        digital: ProductPage._formKey.currentState!.value['digital'],
        name: ProductPage._formKey.currentState!.value['good_name'],
        price: double.tryParse(ProductPage._formKey.currentState!.value['price']),
        link: ProductPage._formKey.currentState!.value['link'],
        description: ProductPage._formKey.currentState!.value['description'],
        categories: ProductPage._formKey.currentState!.value['categories'],
        tags: ProductPage._formKey.currentState!.value['tags'],
        photos: ProductPage._formKey.currentState!.value['photos']
      )
    );
  }
}