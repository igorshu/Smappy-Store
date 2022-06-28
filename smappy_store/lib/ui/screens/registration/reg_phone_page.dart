import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smappy_store/logic/keyboard_bloc/keyboard_bloc.dart';
import 'package:smappy_store/logic/registration_bloc/registration_bloc.dart';
import 'package:smappy_store/ui/widgets/bold_title_text.dart';
import 'package:smappy_store/ui/widgets/bottom_banner.dart';
import 'package:smappy_store/ui/widgets/error_text.dart';
import 'package:smappy_store/ui/widgets/fields/phone_field.dart';
import 'package:smappy_store/ui/widgets/horizontal_gray_line.dart';
import 'package:smappy_store/ui/widgets/regular_text.dart';

class RegPhonePage extends StatelessWidget {

  const RegPhonePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var st = context.watch<RegistrationBloc>().state;
    var keyboardState = context.watch<KeyboardBloc>().state;

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Column(
                children: [
                  const SizedBox(height: 15),
                  BoldTitleText('reg_number'.tr()),
                  const SizedBox(height: 15),
                  RegularText('reg_we_will_send'.tr()),
                  const SizedBox(height: 50),
                  PhoneField(
                    hintText: 'reg_enter_phone'.tr(),
                    onChanged: (value) => context.read<RegistrationBloc>().add(ChangePhone(value!)),
                  ),
                  const SizedBox(height: 19.5),
                  const HorizontalGrayLine(),
                  const SizedBox(height: 19.5),
                  ErrorText(st.error),
                ],
              ),
            ),
          ),
        ),
        BottomBanner(
          visible: !keyboardState.visible,
          text: 'login_all_data'.tr(),
          padding: const EdgeInsets.only(left: 25, right: 25, top: 10),
        ),
      ],
    );
  }


}