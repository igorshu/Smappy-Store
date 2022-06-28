import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:smappy_store/logic/auth_bloc/auth_bloc.dart';
import 'package:smappy_store/logic/keyboard_bloc/keyboard_bloc.dart';
import 'package:smappy_store/logic/login_bloc/login_bloc.dart';
import 'package:smappy_store/ui/navigation/routes.dart';
import 'package:smappy_store/ui/other/styles.dart';
import 'package:smappy_store/ui/other/ui_utils.dart';
import 'package:smappy_store/ui/widgets/bold_title_text.dart';
import 'package:smappy_store/ui/widgets/bottom_banner.dart';
import 'package:smappy_store/ui/widgets/error_text.dart';
import 'package:smappy_store/ui/widgets/fields/password_field.dart';
import 'package:smappy_store/ui/widgets/fields/phone_field.dart';
import 'package:smappy_store/ui/widgets/go_back_button.dart';
import 'package:smappy_store/ui/widgets/horizontal_gray_line.dart';
import 'package:smappy_store/ui/widgets/purple_button.dart';
import 'package:smappy_store/ui/widgets/regular_text.dart';

class LoginScreen extends StatefulWidget {

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    var st = context.watch<LoginBloc>().state;
    var keyboardState = context.watch<KeyboardBloc>().state;
    var authState = context.watch<AuthBloc>().state;

    if (authState.isLoggedIn) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Routes.openShopScreen(context);
      });
    }

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Padding(
          padding: const EdgeInsets.only(top: 13),
          child: Column(
            children: [
              const GoBackButton(),
              const SizedBox(height: 15),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          BoldTitleText('login_enter'.tr()),
                          const SizedBox(height: 15),
                          RegularText('login_if_you_already_registered'.tr()),
                          const SizedBox(height: 50),

                          _loginForm(st),

                          const SizedBox(height: 15),
                          ErrorText(authState.error),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: GestureDetector(
                              onTap: () => Routes.openForgotPasswordScreen(context),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5),
                                child: Text('login_forgot_password'.tr(), style: AppStyles.purpleTextStyle),
                              ),
                            ),
                          ),
                        ]
                    ),
                  ),
                ),
              ),

              BottomBanner(
                visible: !keyboardState.visible,
                text: 'login_all_data'.tr(),
                padding: const EdgeInsets.only(left: 25, right: 25, top: 10),
              ),

              PurpleButton(
                text: 'login_login'.tr(),
                loadingText: 'login_logging'.tr(),
                active: !st.phoneEmpty && !st.passwordEmpty,
                loading: authState.logging,
                onTap: () {
                  hideKeyboard(context);
                  _formKey.currentState!.save();
                  if (_formKey.currentState!.validate()) {
                    context.read<AuthBloc>().add(
                        Login(
                          phone: _formKey.currentState!.value['phone'],
                          password: _formKey.currentState!.value['password'],
                        )
                    );
                  } else {
                    var errorPhone = FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      LengthValidator.length(18, 'login_phone_invalid'.tr()),
                    ])(_formKey.currentState!.value['phone']);
                    context.read<AuthBloc>().add(LoginError(error: errorPhone ?? "Unknown error"));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _loginForm(LoginState st) {
    return FormBuilder(
      key: _formKey,
      autovalidateMode: AutovalidateMode.disabled,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          PhoneField(
            hintText: 'login_enter_phone'.tr(),
            onChanged: (value) => context.read<LoginBloc>().add(ChangePhone(value!)),
          ),
          const SizedBox(height: 19.5),
          const HorizontalGrayLine(),
          const SizedBox(height: 19.5),
          PasswordField(
            name: 'password',
            obscure: !st.passwordVisible,
            hintText: 'login_enter_password'.tr(),
            onChanged: (value) => context.read<LoginBloc>().add(ChangePassword(value!)),
            onChangeObscure: () => context.read<LoginBloc>().add(ChangePasswordVisibility(!st.passwordVisible)),
          ),
        ],
      ),
    );
  }
}