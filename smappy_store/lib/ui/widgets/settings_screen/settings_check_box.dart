import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:smappy_store/ui/other/colors.dart';
import 'package:smappy_store/ui/other/styles.dart';

class SettingsCheckBox extends FormBuilderField<bool> {

  final String text;
  final bool? smallText;
  final Function(bool value)? onChange;

  SettingsCheckBox(
      this.text,
      {super.key,
        this.smallText,
        this.onChange,
        required String name,
        FormFieldSetter<bool>? onSaved,
        FormFieldValidator<bool>? validator,
        required bool initialValue,
        bool autoValidate = false,
      }) : super(
      onSaved: onSaved,
      validator: validator,
      initialValue: initialValue,
      name: name,
      builder: (FormFieldState<bool> state) {
        return GestureDetector(
          onTap: () {
            var value = !(state.value ?? false);
            state.didChange(value);
            onChange?.call(value);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              children: [
                _buildCheckBox(state.value ?? initialValue),
                const SizedBox(width: 10),
                Text(text, style: smallText ?? false ? AppStyles.settingsCheckBoxTextStyle2 : AppStyles.settingsCheckBoxTextStyle),
              ],
            ),
          ),
        );
      }
  );

  static Widget _buildCheckBox(bool value) {
    return !value ? _border() : _border(child: _checked());
  }

  static Widget _border({Widget? child}) {
    return Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        border: Border.all(color: AppColors.purple, width: 1),
      ),
      child: child,
    );
  }

  static _checked() {
    return Padding(
      padding: const EdgeInsets.all(3),
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.purple,
          borderRadius: BorderRadius.all(Radius.circular(3)),
        ),
      ),
    );
  }
}
