import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

FormFieldValidator requiredField(String fieldName) {
  return FormBuilderValidators.required(errorText: 'field_cannot_be_empty'.tr(namedArgs: {'field': fieldName}));
}