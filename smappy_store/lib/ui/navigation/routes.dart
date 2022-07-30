import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

class Routes {

  static const String initial = welcome;
  static const String loggedIn = settings;

  static const String login = '/login';
  static const String smappy = '/smappy';
  static const String welcome = '/welcome';
  static const String registration = '/registration/:step';
  static const String regPhone = '/registration/phone';
  static const String regCode = '/registration/code';
  static const String regPassword = '/registration/password';
  static const String regShop = '/registration/shop';
  static const String shop = '/shop';
  static const String product = '/product';
  static const String settings = '/settings';

  static void openScreen(BuildContext context, String path, {Object? data}) => context.beamToNamed(path, data: data);

  static void openLoginScreen(context) => openScreen(context, login);
  static void openSmappyScreen(context) => openScreen(context, smappy);
  static void openWelcomeScreen(context) => openScreen(context, welcome);
  static void openForgotPasswordScreen(context) {} // TODO forgot password
  static void openRegPhoneScreen(BuildContext context, String smappyCode) => openScreen(context, regPhone, data: smappyCode);
  static void openRegCodeScreen(context) => openScreen(context, regCode);
  static void openRegPasswordScreen(context) => openScreen(context, regPassword);
  static void openRegShopScreen(context) => openScreen(context, regShop);
  static void openShopScreen(context) => openScreen(context, shop);
  static void openProductScreen(context, product) => openScreen(context, Routes.product, data: product);
  static void openSettingsScreen(context) => openScreen(context, Routes.settings);

}