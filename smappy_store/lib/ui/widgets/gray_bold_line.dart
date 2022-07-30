import 'package:flutter/widgets.dart';
import 'package:smappy_store/ui/other/colors.dart';

class GrayBoldLine extends StatelessWidget {

  const GrayBoldLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 5,
      width: 100,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(2)),
        color: AppColors.hint,
      ),
    );
  }


}