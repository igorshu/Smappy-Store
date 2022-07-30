import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:smappy_store/ui/other/input_decorations.dart';
import 'package:smappy_store/ui/other/styles.dart';
import 'package:smappy_store/ui/other/text_formatters.dart';

class TagsField extends StatelessWidget {

  final void Function(String? value)? onChanged;
  final bool? autofocus;
  final String hintText;
  final String labelText;
  final String initialValue;

  const TagsField({Key? key, this.autofocus, required this.hintText, this.onChanged, required this.labelText, required this.initialValue}) : super(key: key);

  static List<FormFieldValidator<String?>> get validators => [
    FormBuilderValidators.required(),
        (String? value) => value?.length == 18 ? null : 'login_phone_invalid'.tr(),
  ];

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      initialValue: initialValue,
      autofocus: autofocus ?? false,
      maxLines: null,
      name: 'tags',
      decoration: AppInputDecoration(hintText: hintText, labelText: labelText),
      style: AppStyles.textFieldTextStyle,
      onChanged: onChanged,
      valueTransformer: (String? value) => value?.replaceAll('#', '').replaceAll(RegExp(r'\s+'), ','),
      inputFormatters: [TagsTextFormatter()],
      autocorrect: false,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
    );
  }

}