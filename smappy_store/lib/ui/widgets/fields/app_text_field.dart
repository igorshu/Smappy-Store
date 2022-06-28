import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:smappy_store/ui/other/styles.dart';
import 'package:smappy_store/ui/other/ui_utils.dart';

class AppTextField extends StatelessWidget {

  final void Function(String? value)? onChanged;
  final String hintText;
  final String name;
  final FormFieldValidator<String?>? validator;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextInputFormatter? inputFormatter;
  final TextEditingController? controller;
  final InputDecoration? decoration;

  const AppTextField({
    Key? key,
    required this.hintText,
    required this.name,
    this.onChanged,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.inputFormatter,
    this.controller,
    this.decoration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      controller: controller,
      name: name,
      decoration: decoration ?? AppInputDecoration(hintText: hintText),
      style: AppStyles.textFieldTextStyle,
      validator: validator,
      onChanged: onChanged,
      autocorrect: false,
      inputFormatters: inputFormatter == null ? null : [inputFormatter!],
      keyboardType: keyboardType,
      textInputAction: textInputAction,
    );
  }

}