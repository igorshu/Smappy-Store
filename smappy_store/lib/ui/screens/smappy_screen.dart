import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:smappy_store/logic/smappy_bloc/smappy_bloc.dart';
import 'package:smappy_store/ui/navigation/routes.dart';
import 'package:smappy_store/ui/other/ui_utils.dart';
import 'package:smappy_store/ui/widgets/bold_title_text.dart';
import 'package:smappy_store/ui/widgets/error_text.dart';
import 'package:smappy_store/ui/widgets/fields/app_text_field.dart';
import 'package:smappy_store/ui/widgets/fields/phone_field.dart';
import 'package:smappy_store/ui/widgets/fields/pin_code_field.dart';
import 'package:smappy_store/ui/widgets/go_back_button.dart';
import 'package:smappy_store/ui/widgets/go_next_text.dart';
import 'package:smappy_store/ui/widgets/purple_button.dart';
import 'package:smappy_store/ui/widgets/regular_text.dart';

class SmappyScreen extends StatefulWidget {

  const SmappyScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SmappyScreenState();
}

class _SmappyScreenState extends State<SmappyScreen> {

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    var st = context.watch<SmappyBloc>().state;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (st.codeIsOk) {
        Routes.openRegPhoneScreen(context, st.code);
      }
    });

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
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        BoldTitleText('smappy_code'.tr()),
                        const SizedBox(height: 15),
                        RegularText('smappy_code_desc'.tr()),
                        const SizedBox(height: 50),
                        FormBuilder(
                          key: _formKey,
                          child: PinCodeField(
                            context,
                            name: 'smappy_code',
                            onCompleted: (code) => context.read<SmappyBloc>().add(ChangeSmappyCode(code: code)),
                          ),
                        ),
                        const SizedBox(height: 15),
                        ErrorText(st.error),
                        const SizedBox(height: 18),
                        GoNextText('smappy_demand_invite'.tr(), onTap: () => _showBottomSheet(context))
                      ],
                    ),
                  )
                ),
              ),
              PurpleButton(
                text: 'reg_next'.tr(),
                active: st.code.isNotEmpty,
                loading: st.loading,
                loadingText: 'smappy_checking_code'.tr(),
                onTap: () {
                  hideKeyboard(context);
                  context.read<SmappyBloc>().add(const CheckSmappyCode());
                },
              ),
            ],
          ),
        )
      )
    );
  }

  _showBottomSheet(BuildContext context) {
    var provider = BlocProvider.of<SmappyBloc>(context, listen: false);

    showModalBottomSheet(
      context: context,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      isScrollControlled: true,
      builder: (context) {
        return BlocProvider.value(
          value: provider,
          child: BlocConsumer<SmappyBloc, SmappyState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              return FractionallySizedBox(
                heightFactor: 0.9,
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Column(
                            children: [
                              const SizedBox(height: 16),
                              Align(
                                alignment: Alignment.centerRight,
                                child: GestureDetector(
                                  onTap: () => Navigator.pop(context),
                                  behavior: HitTestBehavior.opaque,
                                  child: Padding(
                                      padding: const EdgeInsets.only(left: 5, bottom: 5),
                                      child: Image.asset('assets/images/close.png', width: 30, height: 30)),
                                )),
                              const SizedBox(height: 2),
                              BoldTitleText('smappy_invite'.tr()),
                              const SizedBox(height: 15),
                              RegularText('smappy_provide_contacts'.tr()),
                              const SizedBox(height: 50),

                              RegularText('smappy_email'.tr()),
                              const SizedBox(height: 10),
                              AppTextField(
                                hintText: 'smappy_email_hint'.tr(),
                                name: 'email',
                                onChanged: (email) => context.read<SmappyBloc>().add(ChangeEmail(email: email!)),
                                keyboardType: TextInputType.emailAddress,
                                decoration: RequestDecoration(hintText: 'smappy_email_hint'.tr()),
                              ),
                              const SizedBox(height: 30),

                              RegularText('smappy_phone'.tr()),
                              const SizedBox(height: 10),
                              PhoneField(
                                hintText: 'smappy_phone_hint'.tr(),
                                onChanged: (phone) => context.read<SmappyBloc>().add(ChangePhone(phone: phone!)),
                              ),
                              const SizedBox(height: 30),

                              RegularText('smappy_catalog'.tr()),
                              const SizedBox(height: 10),
                              AppTextField(
                                hintText: 'smappy_catalog_hint'.tr(),
                                name: 'catalog',
                                onChanged: (catalog) => context.read<SmappyBloc>().add(ChangeCatalog(catalog: catalog!)),
                              ),
                              const SizedBox(height: 30),
                            ],
                          ),
                        ),
                      ),
                    ),
                    PurpleButton(
                      text: 'smappy_send_request'.tr(),
                      loadingText: 'smappy_send_request'.tr(),
                      active: state.email.isNotEmpty,
                      onTap: () {
                        context.read<SmappyBloc>().add(const SendEmail());
                        Navigator.pop(context);
                      },
                      loading: false,
                    )
                  ],
                ),
              );
            },
          ),
        );
      }
    );
  }
}