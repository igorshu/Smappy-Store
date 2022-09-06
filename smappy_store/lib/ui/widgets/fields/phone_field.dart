import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:smappy_store/ui/other/colors.dart';
import 'package:smappy_store/ui/other/input_decorations.dart';
import 'package:smappy_store/ui/other/styles.dart';

class PhoneField extends StatelessWidget {

  final void Function(String? value)? onChanged;
  final bool? autofocus;
  final String hintText;

  const PhoneField({Key? key, this.autofocus, required this.hintText, this.onChanged}) : super(key: key);

  static List<FormFieldValidator<String?>> get validators => [
    FormBuilderValidators.required(),
    (String? value) => value?.length == 18 ? null : 'login_phone_invalid'.tr(),
  ];

  static List<MaskedInputFormatter> get formatters =>  [MaskedInputFormatter('+0 (000) 000-00-00')];

  static applyFormat(String value) => formatters[0].applyMask(value).text;

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      autofocus: autofocus ?? false,
      name: 'phone',
      cursorColor: AppColors.purple,
      decoration: AppInputDecoration(hintText: hintText),
      style: AppStyles.textFieldTextStyle,
      onChanged: onChanged,
      valueTransformer: (String? value) => value?.replaceAll(RegExp(r'[^\+\d]'), ''),
      inputFormatters: formatters,
      validator: FormBuilderValidators.compose(PhoneField.validators),
      autocorrect: false,
      keyboardType: TextInputType.phone,
      textInputAction: TextInputAction.next,
    );
  }

}