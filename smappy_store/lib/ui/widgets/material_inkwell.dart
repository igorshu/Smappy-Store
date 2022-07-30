import 'package:flutter/material.dart';

class MaterialInkWell extends StatelessWidget {

  final Color? color;
  final Widget child;
  final GestureTapCallback onTap;

  const MaterialInkWell({required this.color, required this.child, required this.onTap, Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      child: InkWell(
        onTap: onTap,
        child: child,
      )
    );
  }

}