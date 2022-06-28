import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

class Routes {

  static const String initial = welcome;
  // static const String initial = smappy;
  // static const String initial = regPhone;
  // static const String initial = regCode;
  // static const String initial = regPassword;
  // static const String initial = regShop;
  // static const String initial = myShop;

  static const String login = '/login';
  static const String smappy = '/smappy';
  static const String welcome = '/welcome';
  static const String shop = '/shop';
  static const String registration = '/registration/:step';
  static const String regPhone = '/registration/phone';
  static const String regCode = '/registration/code';
  static const String regPassword = '/registration/password';
  static const String regShop = '/registration/shop';
  static const String myShop = '/myshop';

  static void openScreen(BuildContext context, String path, {Object? data}) => context.beamToNamed(path, data: data);

  static void openLoginScreen(context) => openScreen(context, login);
  static void openSmappyScreen(context) => openScreen(context, smappy);
  static void openWelcomeScreen(context) => openScreen(context, welcome);
  static void openShopScreen(context) => openScreen(context, shop);
  static void openForgotPasswordScreen(context) {} // TODO forgot password
  static void openRegPhoneScreen(BuildContext context, String smappyCode) => openScreen(context, regPhone, data: smappyCode);
  static void openRegCodeScreen(context) => openScreen(context, regCode);
  static void openRegPasswordScreen(context) => openScreen(context, regPassword);
  static void openRegShopScreen(context) => openScreen(context, regShop);
  static void openMyShopScreen(context) => openScreen(context, myShop);

}