import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:smappy_store/logic/settings_bloc/settings_bloc.dart';
import 'package:smappy_store/ui/other/colors.dart';
import 'package:smappy_store/ui/other/styles.dart';
import 'package:smappy_store/ui/other/ui_utils.dart';
import 'package:smappy_store/ui/other/validators.dart';
import 'package:smappy_store/ui/widgets/bold_title_text.dart';
import 'package:smappy_store/ui/widgets/error_text.dart';
import 'package:smappy_store/ui/widgets/fields/phone_field.dart';
import 'package:smappy_store/ui/widgets/purple_button.dart';
import 'package:smappy_store/ui/widgets/settings_screen/requisites_text_field.dart';

openSupportSheet(BuildContext context, formKey, {String? message}) {
  var provider = BlocProvider.of<SettingsBloc>(context);

  showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return DraggableScrollableSheet(
            initialChildSize: 0.9,
            maxChildSize: 0.9,
            minChildSize: 0.7,
            builder: (context, scrollController) {
              return BlocProvider.value(
                value: provider,
                child: BlocConsumer<SettingsBloc, SettingsState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    var st = context.watch<SettingsBloc>().state;

                    return Container(
                      decoration: const BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                      ),
                      child: _supportForm(context, st, scrollController, formKey, message),
                    );
                  },
                ),
              );
            }
        );
      }
  );
}

_supportForm(BuildContext context, SettingsState st, ScrollController scrollController, formKey, String? message) {
  return FormBuilder(
      key: formKey,
      child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 5),
            Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () => hideModalBottomSheet(context),
                  behavior: HitTestBehavior.opaque,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5, bottom: 5, right: 5),
                    child: Image.asset('assets/images/close.png', width: 50, height: 50),
                  ),
                )
            ),
            const SizedBox(height: 2),
            Flexible(
              child: SingleChildScrollView(
                controller: scrollController,
                child: AnimatedPadding(
                  padding: MediaQuery.of(context).viewInsets.copyWith(left: 25, right: 25),
                  duration: const Duration(milliseconds: 100),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BoldTitleText('settings_support_title'.tr()),
                      const SizedBox(height: 5),
                      Text('settings_support_text'.tr(), style: AppStyles.requisitesLabel),
                      const SizedBox(height: 10),
                      ErrorText(st.error),
                      const SizedBox(height: 10),

                      RequisitesTextField(
                        initialValue: st.paymentInfo?.email ?? '',
                        name: 'email',
                        label: 'settings_support_email'.tr(),
                        hint: 'settings_support_email_hint'.tr(),
                        // formatters: ,
                        validator: FormBuilderValidators.required(),
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 20),

                      RequisitesTextField(
                        initialValue: PhoneField.applyFormat(st.paymentInfo?.phoneNumber ?? ''),
                        name: 'phone number',
                        label: 'settings_support_phone'.tr(),
                        hint: 'settings_support_phone_hint'.tr(),
                        formatters: PhoneField.formatters,
                        validator: FormBuilderValidators.compose(PhoneField.validators),
                        valueTransformer: (String? value) => value?.replaceAll(RegExp(r'[^\d]'), ''),
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 20),

                      RequisitesTextField(
                        initialValue: message,
                        multiline: true,
                        name: 'message text',
                        label: 'settings_support_message_text'.tr(),
                        hint: 'settings_support_message_hint'.tr(),
                        validator: FormBuilderValidators.required(),
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.go,
                      ),
                      const SizedBox(height: 20),
                      PurpleButton(
                        onTap: () {
                          hideKeyboard(context);
                          formKey.currentState!.save();
                          if (formKey.currentState!.validate()) {
                            _send(context, st, formKey);
                          } else {
                            _error(context, st, formKey);
                          }
                        },
                        padding: const EdgeInsets.only(bottom: 20),
                        loading: false,
                        loadingText: '',
                        text: 'settings_support_send_message'.tr(),
                        active: true,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ]
      )
  );
}

void _send(BuildContext context, SettingsState st, formKey) {
  context.read<SettingsBloc>().add(SupportEmail(
    email: formKey.currentState!.value['email'],
    phone: formKey.currentState!.value['phone number'],
    message: formKey.currentState!.value['message text'],
  ));
}

void _error(BuildContext context, SettingsState st, formKey) {
  var emailError = FormBuilderValidators.compose([requiredField('Email')])(formKey.currentState!.value['email']);
  var phoneNumberError = FormBuilderValidators.compose([FormBuilderValidators.compose(PhoneField.validators)])(formKey.currentState!.value['phone number']);
  var messageTextError = FormBuilderValidators.compose([requiredField('Текст сообщения')])(formKey.currentState!.value['message text']);
  context.read<SettingsBloc>().add(RequisitesError(error: emailError ?? phoneNumberError ?? messageTextError ?? 'unknown_error'.tr()));
}