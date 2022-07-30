import 'package:flutter/material.dart';
import 'package:smappy_store/ui/other/styles.dart';

class RedText extends StatelessWidget {

  final String text;

  const RedText(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(text, style: AppStyles.redTextStyle),
    );
  }

}