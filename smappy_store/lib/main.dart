import 'package:beamer/beamer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:get_it/get_it.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:rx_shared_preferences/rx_shared_preferences.dart';
import 'package:smappy_store/core/repository/local_repo.dart';
import 'package:smappy_store/logic/auth_bloc/auth_bloc.dart';
import 'package:smappy_store/logic/keyboard_bloc/keyboard_bloc.dart';
import 'package:smappy_store/logic/shop_bloc/shop_bloc.dart';
import 'package:smappy_store/ui/navigation/smappy_beamer_delegate.dart';
import 'package:smappy_store/ui/other/colors.dart';
import 'package:smappy_store/ui/other/ui_utils.dart';

late BeamerDelegate beamerDelegate;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GetIt.I.registerSingleton<RxSharedPreferences>(RxSharedPreferences.getInstance());
  await EasyLocalization.ensureInitialized();

  beamerDelegate = SmappyBeamerDelegate(await LocalRepo.getToken());

  runApp(
      EasyLocalization(
          useOnlyLangCode: true,
          supportedLocales: const [Locale('ru', 'RU'), Locale('en', 'US')],
          path: 'assets/translations',
          fallbackLocale: const Locale('en', 'US'),
          startLocale: const Locale('ru', 'RU'),
          child: const MyApp()
      )
  );
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    setStatusBar(AppColors.white);

    return BeamerProvider(
      routerDelegate: beamerDelegate,
      child: MaterialApp.router(
        routeInformationParser: BeamerParser(),
        routerDelegate: beamerDelegate,
        backButtonDispatcher: BeamerBackButtonDispatcher(delegate: beamerDelegate),
        localizationsDelegates: context.localizationDelegates
          ..add(FormBuilderLocalizations.delegate),
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.white,
        ),
        builder: (context, child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => AuthBloc(), lazy: false),
              BlocProvider(create: (_) => KeyboardBloc()),
              BlocProvider(create: (_) => ShopBloc()),
            ],
            child: Builder(
              builder: (context) {
                _watchOnKeyboard(context);
                return ResponsiveWrapper.builder(
                  child,
                  debugLog: true,
                  minWidth: 375,
                  defaultScale: false,
                );
              }
            ),
          );
        },
      ),
    );
  }

  void _watchOnKeyboard(BuildContext context) {
    KeyboardVisibilityController().onChange.listen((bool visible) {
      context.read<KeyboardBloc>().add(KeyboardEvent.changeKeyboardVisibility(visible));
    });
  }
}
