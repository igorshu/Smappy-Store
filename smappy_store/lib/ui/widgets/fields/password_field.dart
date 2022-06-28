import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:smappy_store/ui/other/styles.dart';
import 'package:smappy_store/ui/other/ui_utils.dart';

class PasswordField extends StatefulWidget {

  final void Function(String? value) onChanged;
  final bool? autofocus;
  final String hintText;
  final bool obscure;
  final void Function() onChangeObscure;
  final String? name;

  const PasswordField({
    Key? key,
    required this.onChanged, this.autofocus,
    required this.hintText,
    required this.obscure,
    required this.onChangeObscure,
    required this.name,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PasswordFieldState();

  static List<FormFieldValidator> get validators => [
    FormBuilderValidators.required(),
  ];
}

class _PasswordFieldState extends State<PasswordField> {

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: FormBuilderTextField(
            obscureText: widget.obscure,
            autofocus: widget.autofocus ?? false,
            name: widget.name ?? 'password',
            decoration: AppInputDecoration(hintText: widget.hintText),
            style: AppStyles.textFieldTextStyle,
            onChanged: widget.onChanged,
            valueTransformer: (value) => value,
            validator: FormBuilderValidators.compose(PasswordField.validators),
            autocorrect: false,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
          ),
        ),
        const SizedBox(width: 5),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: widget.onChangeObscure,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Image.asset(widget.obscure ? 'assets/images/eye_inactive.png' : 'assets/images/eye_active.png', width: 19)),
        ),
        const SizedBox(width: 20),
      ],
    );
  }

}