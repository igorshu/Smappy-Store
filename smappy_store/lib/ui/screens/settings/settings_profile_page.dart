import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smappy_store/logic/auth_bloc/auth_bloc.dart';
import 'package:smappy_store/logic/settings_bloc/settings_bloc.dart';
import 'package:smappy_store/ui/navigation/routes.dart';
import 'package:smappy_store/ui/widgets/fields/app_text_field.dart';
import 'package:smappy_store/ui/widgets/fields/phone_field.dart';
import 'package:smappy_store/ui/widgets/horizontal_gray_line.dart';
import 'package:smappy_store/ui/widgets/purple_text.dart';
import 'package:smappy_store/ui/widgets/red_text.dart';

class SettingsProfilePage extends StatelessWidget {

  const SettingsProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var st = context.watch<SettingsBloc>().state;

    var authState = context.watch<AuthBloc>().state;

    if (!authState.isLoggedIn) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Routes.openWelcomeScreenAsFirst(context);
      });
    }

    return Padding(
      padding: const EdgeInsets.only(left: 25),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  AppTextField(
                    initialValue: PhoneField.applyFormat(st.paymentInfo?.phoneNumber ?? ''),
                    hintText: 'settings_phone'.tr(),
                    name: 'phone',
                  ),
                  const HorizontalGrayLine(top: 20, bottom: 20),
                  GestureDetector(
                    onTap: () => context.read<SettingsBloc>().add(const ChangePassword()),
                    child: PurpleText('settings_change_password'.tr())
                  ),
                  const HorizontalGrayLine(top: 20, bottom: 20),
                  GestureDetector(
                    onTap: () => context.read<AuthBloc>().add(const Logout()),
                    child: PurpleText('settings_logout'.tr())
                  ),
                  const HorizontalGrayLine(top: 20, bottom: 20),
                  GestureDetector(
                    onTap: () => context.read<SettingsBloc>().add(DeleteShop(phone: st.paymentInfo?.phoneNumber ?? '')),
                    child: RedText('settings_delete_shop'.tr())
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