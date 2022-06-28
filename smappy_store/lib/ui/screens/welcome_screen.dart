import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:smappy_store/ui/navigation/routes.dart';
import 'package:smappy_store/ui/widgets/bold_title_text.dart';
import 'package:smappy_store/ui/widgets/go_next_text.dart';
import 'package:smappy_store/ui/widgets/gray_title_text.dart';
import 'package:smappy_store/ui/widgets/horizontal_gray_line.dart';
import 'package:smappy_store/ui/widgets/regular_text.dart';

class WelcomeScreen extends StatefulWidget {

  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Align(
              alignment: Alignment.bottomLeft,
              child: Image.asset('assets/images/s_in_corner.png', width: 300),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25, top: 52),
              child: Column(
                children: [
                  BoldTitleText('welcome_your_store_in_smappy'.tr()),
                  const SizedBox(height: 15),
                  RegularText('welcome_add_your_store_to'.tr()),
                  const SizedBox(height: 30),
                  GrayTitleText('welcome_if_you_first_time'.tr()),
                  const SizedBox(height: 5),
                  GoNextText('welcome_reg_store'.tr(), onTap: ()  => Routes.openSmappyScreen(context)),
                  const SizedBox(height: 19.5),
                  const HorizontalGrayLine(),
                  const SizedBox(height: 19.5),
                  GrayTitleText('welcome_already_registered'.tr()),
                  const SizedBox(height: 5),
                  GoNextText('welcome_login_to_your_store'.tr(), onTap: () => Routes.openLoginScreen(context)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}