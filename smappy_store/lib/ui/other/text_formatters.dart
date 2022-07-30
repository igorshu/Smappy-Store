import 'package:flutter/services.dart';

class TagsTextFormatter extends TextInputFormatter {

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text.replaceAll(RegExp('#+'), '#');
    var pattern = r'^(#\w*\s?)*$';

    if (RegExp(pattern).hasMatch(text)) {
      return newValue.copyWith(text: text);
    } else {
      return oldValue;
    }
  }

}