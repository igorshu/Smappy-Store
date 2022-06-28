import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smappy_store/ui/other/styles.dart';

double statusBarHeight(context) => MediaQuery.of(context).padding.top;

Size screenSize(context) => MediaQuery.of(context).size;

void hideKeyboard(BuildContext context) => FocusScope.of(context).unfocus();

void setStatusBar(Color color) {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: color,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
  ));
}

class AppInputDecoration extends InputDecoration {

  const AppInputDecoration({required String hintText}):
    super(
      hintText: hintText,
      hintStyle: AppStyles.hintTextStyle,
      border: InputBorder.none,
      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      isDense: true,
      errorStyle: AppStyles.disabledErrorTextStyle,
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


class LengthValidator {

  static FormFieldValidator<T> length<T>(int len, String errorText) {
    return (T? value) {
      return value is String && value.length == len ? null : errorText;
    };
  }
}
