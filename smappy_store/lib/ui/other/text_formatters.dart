import 'package:flutter/services.dart';

class TagsTextFormatter extends TextInputFormatter {

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text.replaceAll(RegExp('#+'), '#');
    var pattern = r'^(#\w*[а-яА-Я]*\s?)*$';

    if (RegExp(pattern).hasMatch(text)) {
      return newValue.copyWith(text: text);
    } else {
      return oldValue;
    }
  }
}

class RoublesTextFormatter extends TextInputFormatter {

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    newValue = newValue.copyWith(text: newValue.text.replaceFirst('.', ','));

    if (newValue.text.length < oldValue.text.length) { // deleting
      var deletedSymbol = oldValue.text.substring(newValue.selection.baseOffset, oldValue.selection.baseOffset);
      if (deletedSymbol == ',') {
        newValue = newValue.copyWith(text: oldValue.text.substring(0, oldValue.text.indexOf(',')));
      }
    }

    var digitsOnly = RegExp(r'^[0-9]*$');
    var digitsAndCommaTwo = RegExp(r'^\d+\,(\d*)$');

    if (digitsOnly.hasMatch(newValue.text)) {
      return newValue;
    }

    var match = digitsAndCommaTwo.firstMatch(newValue.text);
    if ((match?.groupCount ?? 0) > 0) {
      var mantissaLength = (match?.group(1)?.length ?? 0);
      if (mantissaLength >= 0) {
        if (mantissaLength <= 2) {
          newValue = newValue.copyWith(text: '${newValue.text}${List.filled(2 - mantissaLength, '0').join()}');
        } else {
          var commaPos = newValue.text.indexOf(',') + 1;
          if (newValue.selection.baseOffset > commaPos + 2) {
            newValue = newValue.copyWith(
              selection: TextSelection.collapsed(offset: commaPos + 2),
            );
          }

          newValue = newValue.copyWith(text: newValue.text.substring(0, newValue.text.length - (mantissaLength - 2)));
        }
      }
      return newValue;
    }
    return oldValue;
  }

}