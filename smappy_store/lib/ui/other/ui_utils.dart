import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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


class LengthValidator {
  static FormFieldValidator<T> length<T>(int len, String errorText) {
    return (T? value) {
      return value is String && value.length == len ? null : errorText;
    };
  }
}

class NoGlowBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
