import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smappy_store/logic/settings_bloc/settings_bloc.dart';
import 'package:smappy_store/ui/widgets/bold_title_text.dart';

class SettingsPageTitle extends StatelessWidget {

  const SettingsPageTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var st = context.watch<SettingsBloc>().state;

    String title = st.page == 2 ? 'settings_orders'.tr() : 'settings_settings'.tr();
    return BoldTitleText(title);
  }



}