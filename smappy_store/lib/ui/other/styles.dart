import 'package:flutter/material.dart';
import 'package:smappy_store/ui/other/colors.dart';

class AppStyles {

  static const _noirProBold = "NoirPro-Bold";
  static const _noirProRegular = "NoirPro-Regular";
  static const _noirProMedium = "NoirPro-Medium";

  static const boldTextStyle = TextStyle(fontFamily: _noirProBold, fontSize: 34, color: AppColors.black);
  static const regularTextStyle = TextStyle(fontFamily: _noirProRegular, fontSize: 17, color: AppColors.black);
  static const grayTitleTextStyle = TextStyle(fontFamily: _noirProRegular, fontSize: 14, color: AppColors.hint);
  static const hintTextStyle = TextStyle(fontFamily: _noirProRegular, fontSize: 17, color: AppColors.hint);
  static const textFieldTextStyle = TextStyle(fontFamily: _noirProRegular, fontSize: 17, color: AppColors.black);
  static const goNextStyle = TextStyle(fontFamily: _noirProMedium, fontSize: 17, color: AppColors.purple);
  static const backStyle = TextStyle(fontFamily: _noirProRegular, fontSize: 17, color: AppColors.purple);
  static const purpleTextStyle = TextStyle(fontFamily: _noirProRegular, fontSize: 17, color: AppColors.purple);
  static const buttonTextStyle = TextStyle(fontFamily: _noirProMedium, fontSize: 17, color: AppColors.white);
  static const errorTextStyle = TextStyle(fontFamily: _noirProRegular, fontSize: 14, color: AppColors.error);
  static const disabledErrorTextStyle = TextStyle(fontFamily: _noirProRegular, fontSize: 0, color: AppColors.white);
  static const myShopTextStyle = TextStyle(fontFamily: _noirProRegular, fontSize: 15, color: AppColors.myShop);

}