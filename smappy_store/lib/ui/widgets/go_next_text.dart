import 'package:flutter/material.dart';
import 'package:smappy_store/ui/other/colors.dart';
import 'package:smappy_store/ui/other/styles.dart';

class GoNextText extends StatelessWidget {

  final String text;
  final void Function() onTap;

  const GoNextText(this.text, {required this.onTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(text, style: AppStyles.goNextStyle),
              const SizedBox(width: 5),
              Image.asset('assets/images/go_next.png', width: 14, height: 6, color: AppColors.purple),
            ],
          ),
        ),
      ),
    );
  }

}