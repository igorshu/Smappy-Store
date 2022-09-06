import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smappy_store/core/api/products/product.dart';
import 'package:smappy_store/logic/login_bloc/login_bloc.dart';
import 'package:smappy_store/logic/product_bloc/product_bloc.dart';
import 'package:smappy_store/logic/registration_bloc/registration_bloc.dart';
import 'package:smappy_store/logic/settings_bloc/settings_bloc.dart';
import 'package:smappy_store/logic/smappy_bloc/smappy_bloc.dart';
import 'package:smappy_store/ui/screens/login_screen.dart';
import 'package:smappy_store/ui/screens/product_screen.dart';
import 'package:smappy_store/ui/screens/registration_screen.dart';
import 'package:smappy_store/ui/screens/settings_screen.dart';
import 'package:smappy_store/ui/screens/shop_screen.dart';
import 'package:smappy_store/ui/screens/smappy_screen.dart';
import 'package:smappy_store/ui/screens/welcome_screen.dart';

class BeamPages {

  static BeamPage welcome = const BeamPage(key: ValueKey('welcome'), child: WelcomeScreen());

  static BeamPage login = BeamPage(
    key: const ValueKey('login'),
    child: BlocProvider( create: (context) => LoginBloc(), child: const LoginScreen()),
    type: BeamPageType.slideRightTransition,
  );

  static BeamPage smappy = BeamPage(
    key: const ValueKey('smappy'),
    child: BlocProvider(create: (context) => SmappyBloc(), child: const SmappyScreen()),
    type: BeamPageType.slideRightTransition,
  );

  static BeamPage shop = const BeamPage(
    key: ValueKey('shop'),
    child: ShopScreen(),
    type: BeamPageType.slideRightTransition,
  );

  static BeamPage product(Product data) {
    return BeamPage(
      key: const ValueKey('product'),
      child: BlocProvider(create: (context) => ProductBloc(ProductAction.show, data), child: const ProductScreen()),
      routeBuilder: slideBottomTransitionRoute,
    );
  }

  static BeamPage settings = BeamPage(
    key: const ValueKey('settings'),
    child: BlocProvider(create: (context) => SettingsBloc(), child: const SettingsScreen()),
    type: BeamPageType.slideRightTransition,
  );

  static BeamPage registration(BeamState state, Object? data) {
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
      child: BlocProvider(create: (context) => RegistrationBloc(step, smappyCode), child: const RegistrationScreen()),
      type: BeamPageType.slideRightTransition,
    );
  }

  static var slideBottomTransitionRoute = (context, settings, child) {
    return PageRouteBuilder(
      fullscreenDialog: true,
      opaque: true,
      settings: settings,
      pageBuilder: (_, __, ___) => child,
      transitionsBuilder: (_, animation, __, child) {
        return SlideTransition(
          position: animation.drive(Tween(begin: const Offset(0, 1), end: const Offset(0, 0)).chain(CurveTween(curve: Curves.ease))),
          child: child,
        );
      },
    );
  };
}




