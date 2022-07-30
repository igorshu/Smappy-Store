import 'package:beamer/beamer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smappy_store/logic/auth_bloc/auth_bloc.dart';
import 'package:smappy_store/logic/keyboard_bloc/keyboard_bloc.dart';
import 'package:smappy_store/ui/navigation/smappy_beamer_delegate.dart';
import 'package:smappy_store/ui/other/colors.dart';
import 'package:smappy_store/ui/other/ui_utils.dart';
import 'package:get_it/get_it.dart';

late BeamerDelegate beamerDelegate;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GetIt.I.registerSingleton<SharedPreferences>(await SharedPreferences.getInstance());
  await EasyLocalization.ensureInitialized();

  beamerDelegate = SmappyBeamerDelegate();

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

    return MaterialApp.router(
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
            BlocProvider(create: (_) => AuthBloc()),
            BlocProvider(create: (_) => KeyboardBloc()),
          ],
          child: Builder(builder: (context) {
            _watchOnKeyboard(context);
            return ResponsiveWrapper.builder(
              child,
              debugLog: true,
              minWidth: 375,
              defaultScale: false,
            );
          }),
        );
      },
    );
  }

  void _watchOnKeyboard(BuildContext context) {
    KeyboardVisibilityController().onChange.listen((bool visible) {
      context.read<KeyboardBloc>().add(KeyboardEvent.changeKeyboardVisibility(visible));
    });
  }
}
