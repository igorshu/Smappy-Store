import 'package:flutter/material.dart';
import 'package:smappy_store/ui/other/colors.dart';
import 'package:smappy_store/ui/widgets/regular_text.dart';

class BottomBanner extends StatelessWidget {

  final bool visible;
  final String text;
  final EdgeInsetsGeometry padding;
  final Function()? onTap;
  final Color color;
  final String image;

  const BottomBanner({
    Key? key,
    required this.visible,
    required this.text,
    this.padding = const EdgeInsets.only(),
    this.onTap,
    this.color = AppColors.black,
    this.image = 'lock.png'
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Padding(
          padding: padding,
          child: Row(
            children: [
              Image.asset('assets/images/$image', width: 30),
              const SizedBox(width: 15),
              RegularText(text, color: color),
            ],
          ),
        ),
      ),
    );
  }

}