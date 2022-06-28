import 'package:flutter/material.dart';
import 'package:smappy_store/ui/other/colors.dart';
import 'package:smappy_store/ui/other/styles.dart';

class RegularText extends StatelessWidget {

  final String text;
  final Color color;

  const RegularText(this.text, {this.color = AppColors.black, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(text, style: AppStyles.regularTextStyle.copyWith(color: color)),
    );
  }

}