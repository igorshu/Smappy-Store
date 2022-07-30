import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:smappy_store/ui/other/input_decorations.dart';
import 'package:smappy_store/ui/other/styles.dart';

class AppTextField extends StatelessWidget {

  final void Function(String? value)? onChanged;
  final String hintText;
  final String? labelText;
  final String name;
  final FormFieldValidator<String?>? validator;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextInputFormatter? inputFormatter;
  final TextEditingController? controller;
  final InputDecoration? decoration;
  final bool? multiline;
  final String? initialValue;
  final bool? enabled;

  const AppTextField({
    Key? key,
    this.initialValue,
    required this.hintText,
    this.labelText,
    this.enabled,
    required this.name,
    this.onChanged,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.inputFormatter,
    this.controller,
    this.decoration,
    this.multiline,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      initialValue: initialValue,
      controller: controller,
      name: name,
      decoration: decoration ?? AppInputDecoration(hintText: hintText, labelText: labelText),
      style: AppStyles.textFieldTextStyle,
      validator: validator,
      onChanged: onChanged,
      autocorrect: false,
      maxLines: multiline ?? false ? null : 1,
      inputFormatters: inputFormatter == null ? null : [inputFormatter!],
      keyboardType: keyboardType,
      textInputAction: textInputAction,
    );
  }

}