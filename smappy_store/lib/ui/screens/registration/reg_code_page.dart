import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:smappy_store/logic/registration_bloc/registration_bloc.dart';
import 'package:smappy_store/ui/other/colors.dart';
import 'package:smappy_store/ui/widgets/bold_title_text.dart';
import 'package:smappy_store/ui/widgets/bottom_banner.dart';
import 'package:smappy_store/ui/widgets/error_text.dart';
import 'package:smappy_store/ui/widgets/fields/pin_code_field.dart';
import 'package:smappy_store/ui/widgets/regular_text.dart';

class RegCodePage extends StatefulWidget {

  const RegCodePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RegCodePageState();
}

class _RegCodePageState extends State<RegCodePage> {

  late int _endTime;

  @override
  void initState() {
    super.initState();

    _endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 30;
  }

  @override
  Widget build(BuildContext context) {
    var st = context.watch<RegistrationBloc>().state;

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: Column(
                children: [
                  const SizedBox(height: 15),
                  BoldTitleText('reg_small_check'.tr()),
                  const SizedBox(height: 15),
                  RegularText('reg_enter_4_digits_code'.tr()),
                  const SizedBox(height: 50),
                  PinCodeField(
                    context,
                    name: 'code',
                    onCompleted: (code) => context.read<RegistrationBloc>().add(ChangeCode(code: code)),
                  ),
                  const SizedBox(height: 19.5),
                  ErrorText(st.error),
                ],
              ),
            ),
          ),
        ),
        CountdownTimer(
          endTime: _endTime,
          widgetBuilder: (context, time) {
            var left = (time?.sec ?? 0);
            return BottomBanner(
              visible: true,
              color: left == 0 ? AppColors.purple : AppColors.black,
              image: left == 0 ? "resend_active.png" : "resend.png",
              text: left == 0 ? 'reg_request_code_again'.tr() : 'reg_request_code_after'.tr(namedArgs: {'seconds': '$left'}),
              padding: const EdgeInsets.only(left: 25, right: 25, top: 10),
              onTap: () {
                if (left == 0) {
                  context.read<RegistrationBloc>().add(const ResendCode());
                }
              },
            );
          },
        ),
      ],
    );
  }

}