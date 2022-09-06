import 'package:flutter/material.dart';

class Rounded extends StatelessWidget {

  final double? width;
  final double? height;
  final Color? color;
  final Color? fillColor;
  final double borderRadius;
  final double? borderWidth;
  final Widget? child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;

  const Rounded(
    this.borderRadius,
    {Key? key,
    this.width,
    this.height,
    this.color,
    this.fillColor,
    this.borderWidth,
    this.padding,
    this.margin,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: fillColor,
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        border: Border.all(color: color ?? Colors.black, width: borderWidth ?? 1),
      ),
      child: child,
    );
  }

}