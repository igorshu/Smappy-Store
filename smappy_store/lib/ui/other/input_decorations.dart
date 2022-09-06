import 'package:flutter/material.dart';
import 'package:smappy_store/ui/other/colors.dart';
import 'package:smappy_store/ui/other/styles.dart';

class AppInputDecoration extends InputDecoration {

  const AppInputDecoration({required String hintText, String? labelText, Widget? suffixIcon}):
    super(
      labelText: labelText,
      labelStyle: AppStyles.labelTextStyle,
      hintText: hintText,
      hintStyle: AppStyles.hintTextStyle,
      border: InputBorder.none,
      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      isDense: true,
      errorStyle: AppStyles.disabledErrorTextStyle,
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      suffixIcon: suffixIcon,
    );
}

class ShadowDecoration extends InputDecoration {

  ShadowDecoration({required String hintText}):
    super(
      hintText: hintText,
      hintStyle: AppStyles.hintTextStyle,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide.none,
      ),
      filled: true,
      fillColor: AppColors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      isDense: true,
      errorStyle: AppStyles.disabledErrorTextStyle,
    );
}

class AddGoodDecoration extends InputDecoration {

  const AddGoodDecoration({required String hintText, String? labelText}):
    super(
      labelText: labelText,
      hintText: hintText,
      hintStyle: AppStyles.hintTextStyle,
      border: InputBorder.none,
      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      isDense: true,
      errorStyle: AppStyles.disabledErrorTextStyle,
      floatingLabelBehavior: FloatingLabelBehavior.auto,
    );
}

class NoDecoration extends InputDecoration {

  NoDecoration({required String hintText}):
        super(
        hintText: hintText,
        hintStyle: AppStyles.hintTextStyle,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: AppColors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
        isDense: true,
        errorStyle: AppStyles.disabledErrorTextStyle,
      );
}