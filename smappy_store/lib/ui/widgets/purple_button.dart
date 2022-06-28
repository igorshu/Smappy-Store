import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smappy_store/ui/other/colors.dart';
import 'package:smappy_store/ui/other/styles.dart';
import 'package:smappy_store/ui/widgets/app_loader.dart';

class PurpleButton extends StatefulWidget {

  final String text;
  final String loadingText;
  final bool active;
  final bool loading;
  final void Function() onTap;

  const PurpleButton({super.key, required this.text, required this.loadingText, required this.active, required this.loading, required this.onTap});

  @override
  State<StatefulWidget> createState() => _PurpleButtonState();
}

class _PurpleButtonState extends State<PurpleButton> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 20, bottom: 20),
      child: GestureDetector(
        onTap: widget.active && !widget.loading ? widget.onTap : null,
        child: Container(
          height: 60,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            color: widget.active ? AppColors.purple : AppColors.inactive,
          ),
          child: Stack(
            children: [
              Center(
                child: Text(widget.loading ? widget.loadingText : widget.text, style: AppStyles.buttonTextStyle),
              ),
              Visibility(
                visible: widget.loading,
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: AppLoader(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}