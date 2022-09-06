import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smappy_store/logic/settings_bloc/settings_bloc.dart';
import 'package:smappy_store/ui/widgets/settings_screen/order_widget.dart';

class OrderPreview extends StatelessWidget {

  const OrderPreview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var st = context.watch<SettingsBloc>().state;

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      crossAxisSpacing: 20,
      mainAxisSpacing: 0,
      children: st.first3Orders.map((order) => OrderWidget(order)).toList(),
    );
  }




}