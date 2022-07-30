import 'package:beamer/beamer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:smappy_store/ui/other/colors.dart';
import 'package:smappy_store/ui/other/styles.dart';

class GoBackButton extends StatelessWidget {

  final void Function()? onTap;
  final String? text;

  const GoBackButton({this.onTap, Key? key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap ?? () => Beamer.of(context).beamBack(),
        child: Padding(
          padding: const EdgeInsets.only(left: 25, top: 5, bottom: 5),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/images/back.png', height: 17, color: AppColors.purple),
              const SizedBox(width: 8),
              Text(text ?? 'back'.tr(), style: AppStyles.backStyle),
            ],
          ),
        ),
      ),
    );
  }

}