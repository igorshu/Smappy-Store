import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smappy_store/logic/keyboard_bloc/keyboard_bloc.dart';
import 'package:smappy_store/logic/registration_bloc/registration_bloc.dart';
import 'package:smappy_store/ui/widgets/bold_title_text.dart';
import 'package:smappy_store/ui/widgets/bottom_banner.dart';
import 'package:smappy_store/ui/widgets/error_text.dart';
import 'package:smappy_store/ui/widgets/fields/password_field.dart';
import 'package:smappy_store/ui/widgets/horizontal_gray_line.dart';
import 'package:smappy_store/ui/widgets/regular_text.dart';


class RegPasswordPage extends StatelessWidget {

  const RegPasswordPage({Key? key}) : super(key: key);

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
                  BoldTitleText('reg_think_up_password'.tr()),
                  const SizedBox(height: 15),
                  RegularText('reg_password_twice'.tr()),
                  const SizedBox(height: 50),
                  PasswordField(
                    name: 'password1',
                    hintText: 'reg_password'.tr(),
                    onChanged: (value) {
                      context.read<RegistrationBloc>().add(ChangePassword(password: value!, 1));
                    },
                    obscure: st.password1Obscurity,
                    onChangeObscure: () => context.read<RegistrationBloc>().add(ChangePasswordObscurity(!st.password1Obscurity, 1)),
                  ),
                  const SizedBox(height: 19.5),
                  const HorizontalGrayLine(),
                  const SizedBox(height: 19.5),
                  Visibility(
                    visible: st.showPassword2,
                    child: PasswordField(
                      name: 'password2',
                      hintText: 'reg_password2'.tr(),
                      onChanged: (value) => context.read<RegistrationBloc>().add(ChangePassword(password: value!, 2)),
                      obscure: st.password2Obscurity,
                      onChangeObscure: () => context.read<RegistrationBloc>().add(ChangePasswordObscurity(!st.password2Obscurity, 2)),
                    ),
                  ),
                  const SizedBox(height: 19.5),
                  ErrorText(st.error, visibility: true),
                  // const Spacer(),
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