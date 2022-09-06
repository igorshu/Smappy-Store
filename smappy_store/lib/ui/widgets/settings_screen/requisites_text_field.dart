import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:smappy_store/ui/other/colors.dart';
import 'package:smappy_store/ui/other/input_decorations.dart';
import 'package:smappy_store/ui/other/styles.dart';

class RequisitesTextField extends StatelessWidget {

  static FormFieldValidator<String?> get cardNumberValidator =>
        (String? value) {
          var pattern = r'^\d+ \d+ \d+ \d+$';
          if (RegExp(pattern).hasMatch(value!)) return null;
          return 'settings_card_number_error'.tr();
      };

  final String? initialValue;
  final bool? multiline;
  final String label;
  final String name;
  final String hint;
  final List<TextInputFormatter>? formatters;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueTransformer<String?>? valueTransformer;

  const RequisitesTextField({
    Key? key,
    this.initialValue,
    this.multiline = false,
    required this.name,
    required this.label,
    required this.hint,
    this.formatters,
    this.validator,
    this.keyboardType,
    this.textInputAction,
    this.valueTransformer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppStyles.requisitesLabel),
        const SizedBox(height: 10),
        Container(
          height: multiline! ? 224 : null,
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 25,
              )
            ]
          ),
          child: FormBuilderTextField(
            // minLines: 1,
            maxLines: multiline! ? null : 1,
            expands:  multiline! ,
            keyboardType: multiline! ? TextInputType.multiline : keyboardType,
            initialValue: initialValue,
            cursorColor: AppColors.purple,
            textAlignVertical: multiline! ? TextAlignVertical.top : TextAlignVertical.center,
            name: name,
            decoration: ShadowDecoration(hintText: hint),
            inputFormatters: formatters,
            validator: validator,
            textInputAction: textInputAction,
            valueTransformer: valueTransformer,
          ),
        ),
      ],
    );
  }

}