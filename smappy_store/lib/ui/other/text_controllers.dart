import 'package:flutter/material.dart';
import 'package:smappy_store/ui/other/colors.dart';
import 'package:smappy_store/ui/other/styles.dart';

class RoubleEditingController extends TextEditingController {

  RoubleEditingController({String? initial}): super(text: initial);

  @override
  TextSpan buildTextSpan({required BuildContext context, TextStyle? style, required bool withComposing}) {
    List<InlineSpan> spans = [];
    if (text.isNotEmpty) {
      spans.add(TextSpan(text: text, style: style));
      spans.add(WidgetSpan(
        child: Icon(Icons.currency_ruble, size: AppStyles.hintTextStyle.fontSize, color: AppColors.black),
      ));
      return TextSpan(style: style, children: spans);
    } else {
      return TextSpan(style: style, text: text);
    }
  }
}

extension Rouble on String {

  TextSpan toRoubles(BuildContext context, TextStyle style) {
    var icon = Icons.currency_ruble;
    final IconThemeData iconTheme = IconTheme.of(context);

    List<InlineSpan> spans = [];
    if (isNotEmpty) {
      spans.add(TextSpan(text: this, style: style));
      spans.add(
        WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: Text(
            String.fromCharCode(icon.codePoint),
            style: TextStyle(
              inherit: false,
              color: style.color,
              fontSize: style.fontSize,
              fontFamily: icon.fontFamily,
              package: icon.fontPackage,
              shadows: iconTheme.shadows,
            )
          ),
        )
      );
      return TextSpan(style: style, children: spans);
    } else {
      return TextSpan(style: style, text: this);
    }
  }

}