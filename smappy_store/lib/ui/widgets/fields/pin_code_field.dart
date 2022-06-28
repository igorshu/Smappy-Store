import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:smappy_store/ui/other/colors.dart';
import 'package:smappy_store/ui/other/ui_utils.dart';

class PinCodeField extends PinCodeTextField {

  final String name;
  static String _code = '';
  static get code => _code;


  PinCodeField(BuildContext context, {required this.name, required onCompleted, Key? key}) : super(key: key,
    appContext: context,
    length: 4,
    onChanged: (value) {},
    inputFormatters: [MaskedInputFormatter('0000')],
    validator: validators,
    onSaved: (value) => _code = value!,
    pinTheme: PinTheme(
      shape: PinCodeFieldShape.underline,
      fieldHeight: 60,
      fieldWidth: 55,
      activeColor: AppColors.purple,
      selectedColor: AppColors.purple,
      inactiveColor: AppColors.codeInactive,
      disabledColor: AppColors.white,
      activeFillColor: AppColors.white,
      selectedFillColor: AppColors.white,
      inactiveFillColor: AppColors.white,
      errorBorderColor: AppColors.white,
    ),
    animationDuration: const Duration(milliseconds: 300),
    enableActiveFill: true,
    keyboardType: TextInputType.number,
    onCompleted: onCompleted,
  );

  static FormFieldValidator get validators => LengthValidator.length(4, '');

}