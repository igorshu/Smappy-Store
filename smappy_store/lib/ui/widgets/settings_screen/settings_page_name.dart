import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smappy_store/logic/settings_bloc/settings_bloc.dart';
import 'package:smappy_store/ui/other/styles.dart';

class SettingsPageName extends StatelessWidget {

  const SettingsPageName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var st = context.watch<SettingsBloc>().state;

    var descriptions = ['settings_main'.tr(), 'settings_contacts'.tr(), 'settings_order_types'.tr(), 'settings_account'.tr(), 'settings_more'.tr()];
    String description = descriptions[st.page];
    return Text(description, style: AppStyles.settingsDescription);
  }

}