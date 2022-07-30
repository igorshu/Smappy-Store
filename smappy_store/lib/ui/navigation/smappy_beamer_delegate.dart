import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smappy_store/core/api/products/product.dart';
import 'package:smappy_store/core/repository/local_repo.dart';
import 'package:smappy_store/logic/login_bloc/login_bloc.dart';
import 'package:smappy_store/logic/product_bloc/product_bloc.dart';
import 'package:smappy_store/logic/registration_bloc/registration_bloc.dart';
import 'package:smappy_store/logic/settings_bloc/settings_bloc.dart';
import 'package:smappy_store/logic/shop_bloc/shop_bloc.dart';
import 'package:smappy_store/logic/smappy_bloc/smappy_bloc.dart';
import 'package:smappy_store/ui/navigation/routes.dart';
import 'package:smappy_store/ui/screens/login_screen.dart';
import 'package:smappy_store/ui/screens/product_screen.dart';
import 'package:smappy_store/ui/screens/registration_screen.dart';
import 'package:smappy_store/ui/screens/settings_screen.dart';
import 'package:smappy_store/ui/screens/shop_screen.dart';
import 'package:smappy_store/ui/screens/smappy_screen.dart';
import 'package:smappy_store/ui/screens/welcome_screen.dart';

class SmappyBeamerDelegate extends BeamerDelegate {

  SmappyBeamerDelegate() : super(
      initialPath: LocalRepo.getToken() == null ? Routes.initial : Routes.loggedIn,
      locationBuilder: RoutesLocationBuilder(
        routes: {
          Routes.welcome: (context, state, data) =>
            const BeamPage(key: ValueKey('welcome'), child: WelcomeScreen()),
          Routes.login: (context, state, data) =>
            BeamPage(
              key: const ValueKey('login'),
              child: BlocProvider(
                create: (context) => LoginBloc(),
                child: const LoginScreen(),
              ),
              type: BeamPageType.slideRightTransition,
            ),
          Routes.smappy: (context, state, data) =>
              BeamPage(
                key: const ValueKey('smappy'),
                child: BlocProvider(
                  create: (context) => SmappyBloc(),
                  child: const SmappyScreen(),
                ),
                type: BeamPageType.slideRightTransition,
              ),
          Routes.registration: (context, state, data) => _registration(state, data),
          Routes.shop: (context, state, data) =>
            BeamPage(
              key: const ValueKey('shop'),
              child: BlocProvider(
                create: (context) => ShopBloc(),
                child: const ShopScreen(),
              ),
              type: BeamPageType.slideRightTransition,
            ),
          Routes.product: (context, state, data) =>
            BeamPage(
              key: const ValueKey('product'),
              child: BlocProvider(
                create: (context) => ProductBloc(ProductAction.show, data as Product),
                child: const ProductScreen(),
              ),
              type: BeamPageType.slideRightTransition,
            ),
          Routes.settings: (context, state, data) =>
            BeamPage(
              key: const ValueKey('settings'),
              child: BlocProvider(
                create: (context) => SettingsBloc(),
                child: const SettingsScreen(),
              ),
              type: BeamPageType.slideRightTransition,
            ),
        },
      )
  );

  static BeamPage _registration(BeamState state, Object? data) {
    final regPath = state.pathParameters['step']!;
    var step = RegStep.phone;
    var smappyCode = '';
    if (regPath == 'phone') {
      step = RegStep.phone;
      smappyCode = data as String;
    } else if (regPath == 'code') {
      step = RegStep.code;
    } else if (regPath == 'password') {
      step = RegStep.password;
    } else if (regPath == 'shop') {
      step = RegStep.shop;
    }

    return BeamPage(
      key: const ValueKey('registration_phone'),
      child: BlocProvider(
          create: (context) => RegistrationBloc(step, smappyCode),
          child: const RegistrationScreen()
      ),
      type: BeamPageType.slideRightTransition,
    );
  }
}
