import 'package:extension/extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:smappy_store/ui/other/styles.dart';

class ErrorText extends StatelessWidget {

  final String errorText;
  final EdgeInsets padding;
  final bool visibility;

  const ErrorText(this.errorText, {Key? key, this.padding = const EdgeInsets.all(0), this.visibility = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visibility,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: padding,
          child: Text(errorText.capitalizeFirstLetter(), style: AppStyles.errorTextStyle),
        ),
      ),
    );
  }

}