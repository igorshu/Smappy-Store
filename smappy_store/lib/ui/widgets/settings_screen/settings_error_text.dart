import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smappy_store/logic/settings_bloc/settings_bloc.dart';
import 'package:smappy_store/ui/widgets/error_text.dart';

class SettingsErrorText extends StatelessWidget {
  
  const SettingsErrorText({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    var st = context.watch<SettingsBloc>().state;
    
    return ErrorText(st.error);
  }
  
  
  
}