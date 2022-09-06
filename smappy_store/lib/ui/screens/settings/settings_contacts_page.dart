import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smappy_store/logic/settings_bloc/settings_bloc.dart';
import 'package:smappy_store/ui/widgets/fields/app_text_field.dart';
import 'package:smappy_store/ui/widgets/horizontal_gray_line.dart';
import 'package:smappy_store/ui/widgets/regular_text.dart';

class SettingsContactsPage extends StatelessWidget {

  const SettingsContactsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var st = context.watch<SettingsBloc>().state;

    return Padding(
      padding: const EdgeInsets.only(left: 25),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  RegularText('settings_that_contacts'.tr()),
                  const SizedBox(height: 50),
                  AppTextField(
                    key: st.shopData == null ? null : const ValueKey('shop_whatsup'),
                    initialValue: st.shopData?.whatsapp,
                    hintText: 'settings_whats_up'.tr(),
                    name: 'whatsup',
                    onChanged: (value) => context.read<SettingsBloc>().add(ChangedShopWhatsapp(whatsapp: value ?? ''))
                  ),
                  const HorizontalGrayLine(top: 20, bottom: 20),
                  AppTextField(
                    key: st.shopData == null ? null : const ValueKey('shop_instagram'),
                    initialValue: st.shopData?.instagram,
                    hintText: 'settings_telegram'.tr(),
                    name: 'telegram',
                    onChanged: (value) => context.read<SettingsBloc>().add(ChangedShopTelegram(telegram: value ?? ''))
                  ),
                  const HorizontalGrayLine(top: 20, bottom: 20),
                  AppTextField(
                    key: st.shopData == null ? null : const ValueKey('shop_email'),
                    initialValue: st.shopData?.email,
                    hintText: 'settings_email'.tr(),
                    name: 'email',
                    onChanged: (value) => context.read<SettingsBloc>().add(ChangedShopEmail(email: value ?? ''))
                  ),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }

}