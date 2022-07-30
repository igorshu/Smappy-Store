import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:smappy_store/core/api/products/product.dart';
import 'package:smappy_store/logic/product_bloc/product_bloc.dart';
import 'package:smappy_store/logic/shop_bloc/shop_bloc.dart';
import 'package:smappy_store/ui/navigation/routes.dart';
import 'package:smappy_store/ui/other/colors.dart';
import 'package:smappy_store/ui/other/styles.dart';
import 'package:smappy_store/ui/other/ui_utils.dart';
import 'package:smappy_store/ui/screens/product_page/product_page.dart';
import 'package:smappy_store/ui/widgets/app_loader.dart';
import 'package:smappy_store/ui/widgets/bold_title_text.dart';
import 'package:smappy_store/ui/widgets/error_text.dart';
import 'package:smappy_store/ui/widgets/gray_bold_line.dart';
import 'package:smappy_store/ui/widgets/if.dart';
import 'package:smappy_store/ui/widgets/regular_text.dart';
import 'package:smappy_store/ui/widgets/rounded.dart';

class ShopScreen extends StatefulWidget {

  const ShopScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {

  @override
  void initState() {
    super.initState();
    context.read<ShopBloc>().add(const LoadProducts());
  }

  @override
  Widget build(BuildContext context) {
    var st = context.watch<ShopBloc>().state;

    return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: Padding(
            padding: const EdgeInsets.only(top: 13),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => Routes.openSettingsScreen(context),
                        child: RegularText('shop_settings'.tr(), color: AppColors.purple),
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => _openAddProductPage(st),
                        child: Image.asset('assets/images/add.png', width: 24),
                      ),
                    ]
                  ),
                ),
                const SizedBox(height: 13),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BoldTitleText(st.shopName ?? 'shop'.tr()),
                      Visibility(
                        visible: st.loading,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2),
                          child: AppLoader(color: AppColors.shopLoader),
                        ),
                      ),
                    ]
                  ),
                ),
                ErrorText(st.error, visibility: st.isError, padding: const EdgeInsets.symmetric(horizontal: 25)),
                _shopContent(st),
              ],
            ),
          ),
        )
    );
  }

  _shopContent(ShopState st) {
    if (st.products != null) {
      if (st.products!.isEmpty) {
        return Expanded(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Image.asset('assets/images/bg_goods.png', width: screenSize(context).width),
              ),
              SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Opacity(
                        opacity: 0.6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 15),
                            Text('shop_no_goods'.tr(), style: AppStyles.noGoodsTextStyle),
                            const SizedBox(height: 10),
                            RichText(
                              text: TextSpan(
                                text: '${'shop_add_first_good'.tr()} ',
                                style: AppStyles.addFirstGoodTextStyle,
                                children: [
                                  WidgetSpan(
                                    child: Image.asset('assets/images/add.png', width: 14),
                                    alignment: PlaceholderAlignment.top,
                                  ),
                                ]
                              )
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      } else {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: ScrollConfiguration(
              behavior: NoGlowBehavior(),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 7),
                    Text('my_shop'.tr(), style: AppStyles.myShopTextStyle),
                    const SizedBox(height: 15),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 11,
                      mainAxisSpacing: 11,
                      childAspectRatio: 0.628,
                      children: _shopItems(st),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    } else {
      return const Center();
    }
  }

  _openAddProductPage(ShopState st) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return DraggableScrollableSheet(
          initialChildSize: 0.9,
          maxChildSize: 0.9,
          minChildSize: 0.7,
          builder: (context, scrollController) {
            return BlocProvider(
              create: (BuildContext context) => ProductBloc(ProductAction.add, null),
              child: Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: Container(
                  padding: const EdgeInsets.only(left: 25),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(23.5)),
                    color: AppColors.white,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 21),
                      const GrayBoldLine(),
                      const SizedBox(height: 36),
                      Expanded(
                        child: ScrollConfiguration(
                          behavior: NoGlowBehavior(),
                          child: SingleChildScrollView(
                            controller: scrollController,
                            child: const ProductPage()
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            );
          }
        );
      }
    );
  }

  List<Widget> _shopItems(ShopState st) {
    return st.products!.map((Product product) {
      String photoUrl = product.productPhotos?.isNotEmpty ?? false ? product.productPhotos![0].photo : '';
      return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          var imageWidth = constraints.minWidth;
          var imageHeight = constraints.minWidth * 1.14;

          var name = product.name;
          if (!name.contains('\n')) {
            name = '$name\n';
          }

          return GestureDetector(
            onTap: () => Routes.openProductScreen(context, product),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: If(
                    photoUrl.isEmpty,
                    Rounded(10,
                      width: imageWidth,
                      height: imageHeight,
                      borderWidth: 0.5,
                      color: Colors.grey,
                    ),
                    Image.network(photoUrl, fit: BoxFit.cover, width: imageWidth, height: imageHeight),
                  ),
                ),
                const Spacer(flex: 2),
                Text('${product.price} \$', style: AppStyles.priceTextStyle, overflow: TextOverflow.ellipsis),
                const Spacer(flex: 1),
                Text(name, style: AppStyles.productNameTextStyle, overflow: TextOverflow.ellipsis, maxLines: 2),
                const Spacer(flex: 1),
              ]),
          );
        },
      );
    }).toList();
  }

}