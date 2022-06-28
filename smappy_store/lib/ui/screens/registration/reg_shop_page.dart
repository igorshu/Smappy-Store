import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:smappy_store/logic/registration_bloc/registration_bloc.dart';
import 'package:smappy_store/ui/widgets/bold_title_text.dart';
import 'package:smappy_store/ui/widgets/error_text.dart';
import 'package:smappy_store/ui/widgets/fields/app_text_field.dart';
import 'package:smappy_store/ui/widgets/horizontal_gray_line.dart';
import 'package:smappy_store/ui/widgets/regular_text.dart';


class RegShopPage extends StatelessWidget {

  const RegShopPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var st = context.watch<RegistrationBloc>().state;

    return Padding(
      padding: const EdgeInsets.only(left: 25),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 15),
            BoldTitleText('reg_tell_about_shop'.tr()),
            const SizedBox(height: 15),
            RegularText('reg_that_info'.tr()),
            const SizedBox(height: 50),
            AppTextField(
              hintText: 'reg_shop_name'.tr(),
              onChanged: (value) => context.read<RegistrationBloc>().add(ChangeShopData(shopName: value)),
              name:  'shop_name',
              validator: FormBuilderValidators.required(),
            ),
            const SizedBox(height: 21),
            const HorizontalGrayLine(),
            const SizedBox(height: 21),
            AppTextField(
              hintText: 'reg_address'.tr(),
              onChanged: (value) => context.read<RegistrationBloc>().add(ChangeShopData(shopAddress: value)),
              name:  'shop_address',
              validator: FormBuilderValidators.required(),
              textInputAction: TextInputAction.send,
            ),
            const SizedBox(height: 20),
            ErrorText(st.error),
          ],
        ),
      ),
    );
  }


}