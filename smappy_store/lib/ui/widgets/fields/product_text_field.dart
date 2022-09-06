import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:smappy_store/ui/widgets/fields/app_text_field.dart';

class ProductTextField extends StatefulWidget {

  final String hintText;
  final String labelText;
  final String name;
  final TextInputType? keyboardType;
  final String? initialValue;
  final bool enabled;
  final bool required;
  final TextInputFormatter? formatter;
  final TextStyle? style;
  final InputDecoration? decoration;
  final TextEditingController? controller;
  final ValueTransformer<String?>? valueTransformer;

  const ProductTextField({
    Key? key,
    this.initialValue,
    required this.hintText,
    required this.labelText,
    required this.name,
    this.keyboardType,
    required this.enabled,
    this.required = true,
    this.formatter,
    this.style,
    this.decoration,
    this.controller,
    this.valueTransformer,
  }): super(key: key);

  @override
  State<StatefulWidget> createState() => _ProductTextFieldState();
}

class _ProductTextFieldState extends State<ProductTextField> {

  String? _labelText;

  @override
  void initState() {
    _labelText = widget.labelText; // to init label
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: AppTextField(
        controller: widget.controller,
        initialValue: widget.initialValue,
        keyboardType: widget.keyboardType ?? TextInputType.text,
        multiline: true,
        hintText: widget.hintText,
        labelText: _labelText,
        name: widget.name,
        validator: widget.required ? FormBuilderValidators.required() : null,
        inputFormatter: widget.formatter,
        style: widget.style,
        decoration: widget.decoration,
        valueTransformer: widget.valueTransformer,
        onChanged: (value) {
          setState(() {
            if (value?.isNotEmpty ?? false) {
              _labelText = widget.labelText;
            } else {
              _labelText = null;
            }
          });
        },
      ),
    );
  }

}