import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:url_launcher/url_launcher.dart';

double statusBarHeight(context) => MediaQuery.of(context).padding.top;

Size screenSize(context) => MediaQuery.of(context).size;

void hideKeyboard(BuildContext context) => FocusScope.of(context).unfocus();

void setStatusBar(Color color) {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: color,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
  ));
}


class LengthValidator {
  static FormFieldValidator<T> length<T>(int len, String errorText) {
    return (T? value) {
      return value is String && value.length == len ? null : errorText;
    };
  }
}

class NoGlowBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

Future<void> sendEmail({required String recipient, required String subject, required String text}) async {
  final Email email = Email(
    body: text,
    subject: 'Smappy',
    recipients: [recipient],
    isHTML: false,
  );

  await FlutterEmailSender.send(email);
}

Future<bool> openUrl(String url) async {
  return await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
}

void hideModalBottomSheet(BuildContext context) => Navigator.pop(context);