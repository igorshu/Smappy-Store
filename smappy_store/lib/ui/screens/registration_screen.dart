import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:smappy_store/logic/registration_bloc/registration_bloc.dart';
import 'package:smappy_store/ui/navigation/routes.dart';
import 'package:smappy_store/ui/other/colors.dart';
import 'package:smappy_store/ui/other/ui_utils.dart';
import 'package:smappy_store/ui/other/validators.dart';
import 'package:smappy_store/ui/screens/registration/reg_code_page.dart';
import 'package:smappy_store/ui/screens/registration/reg_password_page.dart';
import 'package:smappy_store/ui/screens/registration/reg_phone_page.dart';
import 'package:smappy_store/ui/screens/registration/reg_shop_page.dart';
import 'package:smappy_store/ui/widgets/fields/password_field.dart';
import 'package:smappy_store/ui/widgets/fields/phone_field.dart';
import 'package:smappy_store/ui/widgets/fields/pin_code_field.dart';
import 'package:smappy_store/ui/widgets/go_back_button.dart';
import 'package:smappy_store/ui/widgets/purple_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class RegistrationScreen extends StatefulWidget {

  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  final PageController _controller = PageController(initialPage: 0);

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var st = context.watch<RegistrationBloc>().state;

    if (st.isCompleted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Routes.openShopScreen(context);
      });
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.animateToPage(st.step.index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });

    return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: Padding(
            padding: const EdgeInsets.only(top: 13),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const GoBackButton(),
                    const Spacer(),
                    SmoothPageIndicator(
                      count: 4,
                      controller: _controller,
                      effect: ColorTransitionEffect(
                        activeDotColor: AppColors.black,
                        dotColor: AppColors.black.withOpacity(0.3),
                        dotWidth: 7,
                        dotHeight: 7,
                        spacing: 9,
                      ),
                    ),
                    const SizedBox(width: 25.5),
                  ],
                ),
                Flexible(
                  child: FormBuilder(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.disabled,
                    child: PageView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: _controller,
                      children: const [
                        RegPhonePage(),
                        RegCodePage(),
                        RegPasswordPage(),
                        RegShopPage(),
                      ],
                    ),
                  ),
                ),
                PurpleButton(
                  text: st.step.index < 3 ? 'reg_next'.tr() : 'reg_to_my_shop'.tr(),
                  loadingText: 'reg_check_phone'.tr(),
                  active: st.buttonActive,
                  loading: st.loading,
                  onTap: () {
                    hideKeyboard(context);
                    _formKey.currentState!.save();
                    if (_formKey.currentState!.validate()) {
                      _next(st);
                    } else {
                      _error(st);
                    }
                  },
                ),
              ],
            )
          )
      )
    );
  }

  void _next(RegistrationState st) {
    switch(st.step) {
      case RegStep.phone:
        context.read<RegistrationBloc>().add(Next(step: st.step, phone: _formKey.currentState!.value['phone']));
        break;
      case RegStep.code:
        context.read<RegistrationBloc>().add(Next(step: st.step, code: PinCodeField.code));
        break;
      case RegStep.password:
        context.read<RegistrationBloc>().add(Next(
            step: st.step,
            password1: _formKey.currentState!.value['password1'],
            password2: _formKey.currentState!.value['password2'],
        ));
        break;
      case RegStep.shop:
        context.read<RegistrationBloc>().add(Next(step: st.step,
          shopName: _formKey.currentState!.value['shop_name'],
          shopAddress: _formKey.currentState!.value['shop_address'],
        ));
        break;
      default:
    }
  }

  _error(RegistrationState st) {
    switch(st.step) {
      case RegStep.phone:
        var phoneError = FormBuilderValidators.compose(PhoneField.validators)(_formKey.currentState!.value['phone']);
        context.read<RegistrationBloc>().add(RegistrationError(error: phoneError ?? "Unknown error"));
        break;
      case RegStep.code:
        var codeError = FormBuilderValidators.compose([PinCodeField.validators])(_formKey.currentState!.value['code']);
        context.read<RegistrationBloc>().add(RegistrationError(error: codeError ?? "Unknown error"));
        break;
      case RegStep.password:
        var codeError = FormBuilderValidators.compose(PasswordField.validators)(_formKey.currentState!.value['password']);
        context.read<RegistrationBloc>().add(RegistrationError(error: codeError ?? "Unknown error"));
        break;
      case RegStep.shop:
        var codeNameError = FormBuilderValidators.compose([requiredField('reg_shop_name'.tr())])(_formKey.currentState!.value['shop_name']);
        var codeAddressError = FormBuilderValidators.compose([requiredField('reg_address'.tr())])(_formKey.currentState!.value['shop_address']);
        context.read<RegistrationBloc>().add(RegistrationError(error: codeNameError ?? codeAddressError ?? "Unknown error"));
        break;
      default:
    }
  }
}