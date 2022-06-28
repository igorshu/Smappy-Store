import 'package:flutter/material.dart';
import 'package:smappy_store/ui/other/styles.dart';

class GrayTitleText extends StatelessWidget {

  final String text;

  const GrayTitleText(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(text, style: AppStyles.hintTextStyle),
    );
  }

}