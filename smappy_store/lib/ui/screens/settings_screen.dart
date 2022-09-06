import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smappy_store/logic/settings_bloc/settings_bloc.dart';
import 'package:smappy_store/ui/other/colors.dart';
import 'package:smappy_store/ui/screens/settings/settings_contacts_page.dart';
import 'package:smappy_store/ui/screens/settings/settings_main_page.dart';
import 'package:smappy_store/ui/screens/settings/settings_orders_page.dart';
import 'package:smappy_store/ui/screens/settings/settings_profile_page.dart';
import 'package:smappy_store/ui/screens/settings/settings_support_page.dart';
import 'package:smappy_store/ui/widgets/app_loader.dart';
import 'package:smappy_store/ui/widgets/go_back_button.dart';
import 'package:smappy_store/ui/widgets/rounded.dart';
import 'package:smappy_store/ui/widgets/settings_screen/settings_error_text.dart';
import 'package:smappy_store/ui/widgets/settings_screen/settings_page_name.dart';
import 'package:smappy_store/ui/widgets/settings_screen/settings_page_title.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SettingsScreen extends StatefulWidget {

  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  final PageController _controller = PageController(initialPage: 0);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  void initState() {
    _controller.addListener(() {
      context.read<SettingsBloc>().add(SettingsPageChanged(page: _controller.page?.round() ?? 0));
    });

    context.read<SettingsBloc>().add(const GetSettingsData());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var st = context.watch<SettingsBloc>().state;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Padding(
          padding: const EdgeInsets.only(top: 13),
          child: Column(
            children: [
              GoBackButton(text: 'settings_my_shop'.tr()),
              Expanded(
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 0, top: 0),
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 25),
                            child: SettingsPageTitle()
                          ),
                          const SizedBox(height: 12),
                          const Padding(
                            padding: EdgeInsets.only(left: 25),
                            child: SettingsErrorText(),
                          ),
                          const SizedBox(height: 12),
                          Flexible(
                            child: PageView(
                              controller: _controller,
                              children: [
                                SettingsMainPage(),
                                const SettingsContactsPage(),
                                const SettingsOrdersPage(),
                                const SettingsProfilePage(),
                                SettingsSupportPage(),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          SmoothPageIndicator(
                            controller: _controller,
                            count: 5,
                            effect: ColorTransitionEffect(
                              activeDotColor: AppColors.black,
                              dotColor: AppColors.black.withOpacity(0.3),
                              dotWidth: 7,
                              dotHeight: 7,
                              spacing: 9,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const SettingsPageName(),
                          const SizedBox(height: 65),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: st.loading,
                      child: AbsorbPointer(
                        absorbing: st.loading,
                        child: Center(
                          child: Rounded(10,
                              fillColor: Colors.grey.shade50.withOpacity(0.8),
                              color: Colors.grey.shade50.withOpacity(0.8),
                              padding: const EdgeInsets.all(50),
                              child: const AppLoader(color: AppColors.black)
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}