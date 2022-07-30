import 'package:flutter/material.dart';

class If extends StatelessWidget {

  final bool condition;
  final Widget trueWidget;
  final Widget falseWidget;

  const If(this.condition, this.trueWidget, this.falseWidget, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return condition ? trueWidget : falseWidget;
  }

}