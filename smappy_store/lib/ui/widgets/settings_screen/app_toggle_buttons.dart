import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smappy_store/logic/settings_bloc/settings_bloc.dart';
import 'package:smappy_store/ui/other/colors.dart';
import 'package:smappy_store/ui/other/styles.dart';
import 'package:smappy_store/ui/widgets/rounded.dart';

class AppToggleButtons extends StatefulWidget {

  final Function(bool value)? onChange;

  const AppToggleButtons({Key? key, this.onChange}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AppToggleButtonsState();

}

class AppToggleButtonsState extends State<AppToggleButtons> {

  final Duration duration = const Duration(milliseconds: 300);
  final Curve curve = Curves.fastOutSlowIn;

  @override
  Widget build(BuildContext context) {
    var st = context.watch<SettingsBloc>().state;

    return
      Stack(
        alignment: Alignment.center,
        children: [
          const Rounded(
            8,
            height: 40,
            color: AppColors.toggleBg,
            fillColor: AppColors.toggleBg,
          ),
          AnimatedAlign(
            curve: curve,
            alignment: st.isSelfEmployed ? AlignmentDirectional.centerStart : AlignmentDirectional.centerEnd,
            duration: duration,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 4),
              child: FractionallySizedBox(
                widthFactor: 0.5,
                child: Rounded(
                  8,
                  height: 32,
                  color: AppColors.purple,
                  fillColor: AppColors.purple,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    var value = !st.isSelfEmployed;
                    widget.onChange?.call(value);
                    context.read<SettingsBloc>().add(TypeChanged(selfEmployed: value));
                  },
                  child: SizedBox(
                    height: 32,
                    child: AnimatedSwitcher(
                      duration: duration,
                      switchInCurve: curve,
                      switchOutCurve: curve,
                      child: st.isSelfEmployed
                        ? Text(key: const Key('1'), 'settings_self_employed'.tr(), style: AppStyles.requisitesToggleActive, textAlign: TextAlign.center,)
                        : Text(key: const Key('2'), 'settings_self_employed'.tr(), style: AppStyles.requisitesToggleInactive, textAlign: TextAlign.center),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => context.read<SettingsBloc>().add(TypeChanged(selfEmployed: !st.isSelfEmployed)),
                  child: SizedBox(
                    height: 32,
                    child: AnimatedSwitcher(
                      duration: duration,
                      switchInCurve: curve,
                      switchOutCurve: curve,
                      child: !st.isSelfEmployed
                        ? Text(key: const Key('3'), 'settings_lcc_or'.tr(), style: AppStyles.requisitesToggleActive, textAlign: TextAlign.center)
                        : Text(key: const Key('4'), 'settings_lcc_or'.tr(), style: AppStyles.requisitesToggleInactive, textAlign: TextAlign.center),
                    ),
                  )
                ),
              ),
            ],
          ),
        ],
      );
  }

}