import 'package:flutter/material.dart';

class Rounded extends StatelessWidget {

  final double? width;
  final double? height;
  final Color? color;
  final double borderRadius;
  final double? borderWidth;

  const Rounded(
    this.borderRadius,
    {Key? key,
    this.width,
    this.height,
    this.color,
    this.borderWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        border: Border.all(color: color ?? Colors.black, width: borderWidth ?? 1),
      ),
    );
  }

}