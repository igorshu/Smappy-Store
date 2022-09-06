import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:smappy_store/logic/settings_bloc/settings_bloc.dart';
import 'package:smappy_store/ui/screens/settings/support_sheet.dart';
import 'package:smappy_store/ui/widgets/horizontal_gray_line.dart';
import 'package:smappy_store/ui/widgets/purple_text.dart';

class SettingsSupportPage extends StatelessWidget {

  final _formKey = GlobalKey<FormBuilderState>();

  SettingsSupportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => openSupportSheet(context, _formKey),
                    child: PurpleText('settings_support'.tr())
                  ),
                  const HorizontalGrayLine(top: 20, bottom: 20),
                  GestureDetector(
                    onTap: () => context.read<SettingsBloc>().add(const SupportAbout()),
                    child: PurpleText('settings_about'.tr())
                  ),
                  const HorizontalGrayLine(top: 20, bottom: 20),
                  GestureDetector(
                    onTap: () => context.read<SettingsBloc>().add(const SupportPolicy()),
                    child: PurpleText('settings_policy'.tr())
                  ),
                  const HorizontalGrayLine(top: 20, bottom: 20),
                  GestureDetector(
                    onTap: () => context.read<SettingsBloc>().add(const SupportTerms()),
                    child: PurpleText('settings_terms'.tr())),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }




}