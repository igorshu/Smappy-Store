import 'package:flutter/cupertino.dart';
import 'package:smappy_store/ui/other/colors.dart';

class AppLoader extends StatelessWidget {

  final Color color;

  const AppLoader({Key? key, this.color = AppColors.white}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoActivityIndicator(
      radius: 10,
      color: color,
    );
  }

}