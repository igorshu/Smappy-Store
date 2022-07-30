import 'package:flutter/material.dart';
import 'package:smappy_store/ui/other/colors.dart';

class HorizontalGrayLine extends StatelessWidget {

  final double top;
  final double bottom;

  const HorizontalGrayLine({Key? key, this.top = 0, this.bottom = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: top, bottom: bottom),
      width: double.infinity,
      height: 1,
      color: AppColors.hr,
    );
  }

}