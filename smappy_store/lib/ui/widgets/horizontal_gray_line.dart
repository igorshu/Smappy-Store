import 'package:flutter/material.dart';
import 'package:smappy_store/ui/other/colors.dart';

class HorizontalGrayLine extends StatelessWidget {

  const HorizontalGrayLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 1,
      color: AppColors.hr,
    );
  }

}