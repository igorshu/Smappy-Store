import 'package:flutter/material.dart';
import 'package:smappy_store/ui/other/styles.dart';

class AppInputDecoration extends InputDecoration {

  const AppInputDecoration({required String hintText, String? labelText}):
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
    );
}

class RequestDecoration extends InputDecoration {

  RequestDecoration({required String hintText}):
    super(
      hintText: hintText,
      hintStyle: AppStyles.hintTextStyle,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
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