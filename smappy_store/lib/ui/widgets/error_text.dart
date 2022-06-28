import 'package:extension/extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:smappy_store/ui/other/styles.dart';

class ErrorText extends StatelessWidget {

  final String errorText;

  const ErrorText(this.errorText, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(errorText.capitalizeFirstLetter(), style: AppStyles.errorTextStyle),
    );
  }

}