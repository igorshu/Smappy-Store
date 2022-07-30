import 'package:beamer/beamer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smappy_store/logic/product_bloc/product_bloc.dart';
import 'package:smappy_store/ui/other/colors.dart';
import 'package:smappy_store/ui/other/styles.dart';
import 'package:smappy_store/ui/other/ui_utils.dart';
import 'package:smappy_store/ui/screens/product_page/product_page.dart';
import 'package:smappy_store/ui/widgets/app_loader.dart';
import 'package:smappy_store/ui/widgets/purple_text.dart';

class ProductScreen extends StatefulWidget {

  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    var st = context.watch<ProductBloc>().state;

    if (st.deleted) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Beamer.of(context).beamBack();
      });
    }

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Padding(
          padding: const EdgeInsets.only(left: 25),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 13, bottom: 13, right: 25),
                child: Row(
                  children: [
                    Visibility(
                      visible: st.isShow,
                      child: GestureDetector(
                        onTap: () => context.read<ProductBloc>().add(const ProductEdit()),
                        child: PurpleText('add_good_edit'.tr())
                      )
                    ),
                    // TODO remove?
                    // Visibility(
                    //   visible: false && st.isEdit && !st.loading,
                    //   child: GestureDetector(
                    //     onTap: () => Beamer.of(context).beamBack(),
                    //     child: PurpleText('add_good_close'.tr()))
                    // ),
                    // Visibility(visible: false && st.isEdit && !st.loading, child: const Spacer()),
                    Visibility(
                      visible: st.isEdit,
                      child: Opacity(
                        opacity: st.loading ? 0.5 : 1,
                        child: GestureDetector(
                          onTap: () => context.read<ProductBloc>().add(const ProductSaving()),
                          child: PurpleText('add_good_save'.tr())
                        )
                      )
                    ),
                    Visibility(
                      visible: st.isEdit && st.loading,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: AppLoader(color: AppColors.shopLoader),
                      )
                    ),
                    Visibility(
                      visible: st.isEdit,
                      child: const Spacer()
                    ),
                    Visibility(
                      visible: st.isEdit,
                      child: GestureDetector(
                        onTap: () => _showOtherButtons(st),
                        child: SizedBox(
                          width: 26,
                          height: 26,
                          child: Image.asset('assets/images/dots.png', width: 26),
                        ),
                      ),
                    ),
                  ]
                ),
              ),
              Expanded(
                child: ScrollConfiguration(
                  behavior: NoGlowBehavior(),
                  child: SingleChildScrollView(
                    child: Column(
                      children: const [
                        ProductPage(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }

  _showOtherButtons(ProductState st) {
    var c = context;
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return CupertinoActionSheet(
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 37),
            child: Text(st.product!.description, style: AppStyles.cupertinoTitleTextStyle, overflow: TextOverflow.ellipsis)),
          actions: [
            CupertinoActionSheetAction(
              onPressed: () {  }, // TODO share
              child: Text('add_good_share'.tr(), style: AppStyles.cupertinoActionTextStyle),
            ),
            CupertinoActionSheetAction(
              onPressed: () => c.read<ProductBloc>().add(ProductDelete(product: st.product!)),
              child: Text('add_good_delete'.tr(), style: AppStyles.cupertinoActionTextStyle.copyWith(color: AppColors.delete)),
            )
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('add_good_cancel'.tr(), style: AppStyles.cupertinoActionTextStyle),
          ),
        );
      },
    );
  }
}