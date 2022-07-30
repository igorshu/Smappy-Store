import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:smappy_store/ui/widgets/fields/app_text_field.dart';

class ProductTextField extends StatefulWidget {

  final String hintText;
  final String labelText;
  final String name;
  final TextInputType? keyboardType;
  final String initialValue;
  final bool enabled;
  final bool required;

  const ProductTextField({
    Key? key,
    required this.initialValue,
    required this.hintText,
    required this.labelText,
    required this.name,
    this.keyboardType,
    required this.enabled,
    this.required = true,
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
        initialValue: widget.initialValue,
        keyboardType: widget.keyboardType ?? TextInputType.text,
        multiline: true,
        hintText: widget.hintText,
        labelText: _labelText,
        name: widget.name,
        validator: widget.required ? FormBuilderValidators.required() : null,
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