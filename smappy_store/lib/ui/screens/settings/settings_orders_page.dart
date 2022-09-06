import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:smappy_store/core/api/orders/order.dart';
import 'package:smappy_store/logic/settings_bloc/settings_bloc.dart';
import 'package:smappy_store/ui/other/colors.dart';
import 'package:smappy_store/ui/other/styles.dart';
import 'package:smappy_store/ui/other/ui_utils.dart';
import 'package:smappy_store/ui/other/validators.dart';
import 'package:smappy_store/ui/screens/settings/support_sheet.dart';
import 'package:smappy_store/ui/widgets/bold_title_text.dart';
import 'package:smappy_store/ui/widgets/error_text.dart';
import 'package:smappy_store/ui/widgets/fields/phone_field.dart';
import 'package:smappy_store/ui/widgets/purple_button.dart';
import 'package:smappy_store/ui/widgets/regular_text.dart';
import 'package:smappy_store/ui/widgets/settings_screen/app_toggle_buttons.dart';
import 'package:smappy_store/ui/widgets/settings_screen/order_widget.dart';
import 'package:smappy_store/ui/widgets/settings_screen/orders_preview.dart';
import 'package:smappy_store/ui/widgets/settings_screen/requisites_text_field.dart';
import 'package:smappy_store/ui/widgets/settings_screen/settings_check_box.dart';

class SettingsOrdersPage extends StatefulWidget {

  const SettingsOrdersPage({Key? key}) : super(key: key);

  @override
  State<SettingsOrdersPage> createState() => _SettingsOrdersPageState();
}

class _SettingsOrdersPageState extends State<SettingsOrdersPage> {

  final _formKey = GlobalKey<FormBuilderState>();
  final ScrollController _controller = ScrollController();


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var st = context.watch<SettingsBloc>().state;

    return SingleChildScrollView(
      controller: _controller,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 25, left: 25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RegularText('settings_orders_description'.tr()),
                const SizedBox(height: 20),
                const OrderPreview(),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () => _openAllOrders(),
                    behavior: HitTestBehavior.opaque,
                    child: Text('settings_all_orders'.tr(), style: AppStyles.purpleTextStyle.copyWith(fontSize: 14))),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
          ColoredBox(
            color: const Color(0xFFF7F7F7),
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                padding: const EdgeInsets.only(left: 25),
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 23),
                    Text('settings_requisites'.tr(), style: AppStyles.requisites),
                    const SizedBox(height: 25),
                    GestureDetector(
                      onTap: () => _openRequisites(context, st),
                      child: Container(
                        alignment: AlignmentDirectional.centerStart,
                        margin: const EdgeInsets.only(right: 25),
                        height: 57,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(5)),
                          border: Border.all(color: AppColors.purple),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 22),
                          child: Text('settings_change_requisites'.tr(), style: AppStyles.changeRequisitesLogo),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text('settings_if_requisites'.tr(), style: AppStyles.ifRequisites),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _openRequisites(BuildContext context, SettingsState st) {
    var provider = BlocProvider.of<SettingsBloc>(context);

    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return BlocProvider.value(
            value: provider,
            child: BlocConsumer<SettingsBloc, SettingsState>(
              listener: (context, state) {},
              builder: (context, state) {
                var st = context.watch<SettingsBloc>().state;

                if (st.requisitesSaved) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    context.read<SettingsBloc>().add(const ResetRequisitesSaved());
                    hideModalBottomSheet(context);
                  });
                }

                return DraggableScrollableSheet(
                  initialChildSize: 0.9,
                  maxChildSize: 0.9,
                  minChildSize: 0.7,
                  builder: (context, scrollController) {
                    return Container(
                      decoration: const BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                      ),
                      child: _requisitesForm(context, st, scrollController),
                    );
                  },
                );
              },
            ),
          );
        });
  }

  Widget _requisitesForm(BuildContext context, SettingsState st, ScrollController scrollController) {
    return FormBuilder(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(height: 5),
          Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  hideModalBottomSheet(context);
                  context.read<SettingsBloc>().add(const RequisitesError(error: ''));
                },
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: const EdgeInsets.only(left: 5, bottom: 5, right: 5),
                  child: Image.asset('assets/images/close.png', width: 50, height: 50),
                ),
              )
          ),
          const SizedBox(height: 2),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                BoldTitleText('settings_requisites'.tr()),
                const SizedBox(height: 10),
                ErrorText(st.requisitesError),
                const SizedBox(height: 10),
                AppToggleButtons(onChange: (value) => hideKeyboard(context)),
                const SizedBox(height: 30),
              ],
            ),
          ),
          Expanded(
            child: ScrollConfiguration(
              behavior: NoGlowBehavior(),
              child: SingleChildScrollView(
                controller: scrollController,
                child: AnimatedPadding(
                  padding: MediaQuery.of(context).viewInsets.copyWith(left: 25, right: 25),
                  duration: const Duration(milliseconds: 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      st.isSelfEmployed ? _selfEmployed(st) : _enterprise(st),

                      const SizedBox(height: 20),
                      Text('settings_commission'.tr(), style: AppStyles.requisitesCommission),
                      const SizedBox(height: 20),
                      SettingsCheckBox(
                        'settings_offer'.tr(),
                        name: 'offer',
                        initialValue: false,
                        smallText: true,
                        onChange: (value) => context.read<SettingsBloc>().add(OfferAccepted(checked: value)),
                      ),

                      PurpleButton(text: 'save'.tr(),
                        loadingText: 'saving'.tr(),
                        active: st.buttonActive,
                        loading: st.loading,
                        padding: const EdgeInsets.only(bottom: 20),
                        onTap: () {
                          hideKeyboard(context);
                          _formKey.currentState!.save();
                          if (_formKey.currentState!.validate()) {
                            _save(st);
                          } else {
                            _error(st);
                          }
                        }
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _selfEmployed(SettingsState st) {
    return Column(
      key: const ValueKey('selfEmployed'),
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('settings_withdraw_to_card'.tr(), style: AppStyles.requisitesTitle),
        const SizedBox(height: 5),
        ErrorText(st.error),
        const SizedBox(height: 15),

        RequisitesTextField(
          initialValue: st.paymentInfo?.cardNumber ?? '',
          name: 'card number',
          label: 'settings_card_number'.tr(),
          hint: 'settings_xxxx_xxxx_xxxx_xxxx'.tr(),
          formatters: [MaskedInputFormatter('0000 0000 0000 0000')],
          // validator: FormBuilderValidators.creditCard(),
          validator: RequisitesTextField.cardNumberValidator,
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: 20),

        RequisitesTextField(
          initialValue: PhoneField.applyFormat(st.paymentInfo?.phoneNumber ?? ''),
          name: 'phone number',
          label: 'settings_your_phone_number'.tr(),
          hint: 'settings_hint_phone'.tr(),
          formatters: PhoneField.formatters,
          validator: FormBuilderValidators.compose(PhoneField.validators),
          valueTransformer: (String? value) => value?.replaceAll(RegExp(r'[^\d]'), ''),
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: 20),

        RequisitesTextField(
          initialValue: st.paymentInfo?.email ?? '',
          name: 'email',
          label: 'settings_your_email'.tr(),
          hint: '',
          // formatters: ,
          validator: FormBuilderValidators.required(),
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
        ),
      ],
    );
  }

  Widget _enterprise(SettingsState st) {
    return
      Column(
        key: const ValueKey('enterprise'),
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('settings_data_of_receiver'.tr(), style: AppStyles.requisitesTitle),
          const SizedBox(height: 5),
          ErrorText(st.error),
          const SizedBox(height: 15),

          RequisitesTextField(
            initialValue: st.paymentInfo?.name ?? '',
            name: 'enterprise name',
            label: 'settings_enterprise_name'.tr(),
            hint: 'settings_enterprise_name_hint'.tr(),
            // formatters: ,
            validator: FormBuilderValidators.required(),
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 20),

          RequisitesTextField(
            initialValue: st.paymentInfo?.accountNumber ?? '',
            name: 'enterprise account',
            label: 'settings_enterprise_account'.tr(),
            hint: '',
            // formatters: ,
            validator: FormBuilderValidators.required(),
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 20),

          RequisitesTextField(
            initialValue: st.paymentInfo?.bic ?? '',
            name: 'enterprise bik',
            label: 'settings_enterprise_bik'.tr(),
            hint: '',
            // formatters: ,
            validator: FormBuilderValidators.required(),
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 20),

          RequisitesTextField(
            initialValue: st.paymentInfo?.legalAddress ?? '',
            name: 'enterprise legal address',
            label: 'settings_enterprise_legal_address'.tr(),
            hint: '',
            // formatters: ,
            validator: FormBuilderValidators.required(),
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 20),

          RequisitesTextField(
            initialValue: st.paymentInfo?.address ?? '',
            name: 'enterprise real address',
            label: 'settings_enterprise_real_address'.tr(),
            hint: '',
            // formatters: ,
            validator: FormBuilderValidators.required(),
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 20),

          RequisitesTextField(
            initialValue: st.paymentInfo?.taxNumber ?? '',
            name: 'enterprise inn',
            label: 'settings_enterprise_inn'.tr(),
            hint: '',
            // formatters: ,
            validator: FormBuilderValidators.required(),
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 20),

          RequisitesTextField(
            initialValue: st.paymentInfo?.kpp ?? '',
            name: 'enterprise kpp',
            label: 'settings_enterprise_kpp'.tr(),
            hint: '',
            // formatters: ,
            // validator: FormBuilderValidators.required(),
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 20),

          RequisitesTextField(
            initialValue: st.paymentInfo?.legalPerson ?? '',
            name: 'enterprise signatory',
            label: 'settings_enterprise_signatory'.tr(),
            hint: '',
            // formatters: ,
            validator: FormBuilderValidators.required(),
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 20),

          RequisitesTextField(
            initialValue: PhoneField.applyFormat(st.paymentInfo?.phoneNumber ?? ''),
            name: 'enterprise phone',
            label: 'settings_enterprise_phone'.tr(),
            hint: 'settings_hint_phone'.tr(),
            formatters: PhoneField.formatters,
            validator: FormBuilderValidators.compose(PhoneField.validators),
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 20),

          RequisitesTextField(
            initialValue: st.paymentInfo?.email ?? '',
            name: 'enterprise email',
            label: 'settings_enterprise_email'.tr(),
            hint: '',
            // formatters: ,
            validator: FormBuilderValidators.required(),
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
          ),
        ],
      );
  }

  void _save(SettingsState st) {
    if (st.isSelfEmployed) {
      context.read<SettingsBloc>().add(
          SaveSelfEmployed(
            cardNumber: _formKey.currentState!.value['card number'],
            phoneNumber: _formKey.currentState!.value['phone number'],
            email: _formKey.currentState!.value['email'],
            offer: _formKey.currentState!.value['offer'],
          )
      );
    } else {
      context.read<SettingsBloc>().add(
          SaveEnterprise(
            enterpriseName: _formKey.currentState!.value['enterprise name'],
            enterpriseAccount: _formKey.currentState!.value['enterprise account'],
            enterpriseBik: _formKey.currentState!.value['enterprise bik'],
            enterpriseLegalAddress: _formKey.currentState!.value['enterprise legal address'],
            enterpriseRealAddress: _formKey.currentState!.value['enterprise real address'],
            enterpriseInn: _formKey.currentState!.value['enterprise inn'],
            enterpriseKpp: _formKey.currentState!.value['enterprise kpp'],
            enterpriseSignatory: _formKey.currentState!.value['enterprise signatory'],
            enterprisePhone: _formKey.currentState!.value['enterprise phone'],
            enterpriseEmail: _formKey.currentState!.value['enterprise email'],
            offer: _formKey.currentState!.value['offer'],
          )
      );
    }
  }

  void _error(SettingsState st) {
    if (st.isSelfEmployed) {
      var cardNumberError = FormBuilderValidators.compose([RequisitesTextField.cardNumberValidator])(_formKey.currentState!.value['card number']);
      var phoneNumberError = FormBuilderValidators.compose([requiredField('settings_your_phone_number'.tr())])(_formKey.currentState!.value['phone number']);
      var emailError = FormBuilderValidators.compose([requiredField('settings_your_email'.tr())])(_formKey.currentState!.value['email']);
      context.read<SettingsBloc>().add(RequisitesError(error: cardNumberError ?? phoneNumberError ?? emailError ?? 'unknown_error'.tr()));
    } else {
      var enterpriseNameError = FormBuilderValidators.compose([requiredField('settings_enterprise_name'.tr())])(_formKey.currentState!.value['enterprise name']);
      var enterpriseAccountError = FormBuilderValidators.compose([requiredField('settings_enterprise_account'.tr())])(_formKey.currentState!.value['enterprise account']);
      var enterpriseBikError = FormBuilderValidators.compose([requiredField('settings_enterprise_bik'.tr())])(_formKey.currentState!.value['enterprise bik']);
      var enterpriseLegalAddressError = FormBuilderValidators.compose([requiredField('settings_enterprise_legal_address'.tr())])(_formKey.currentState!.value['enterprise legal address']);
      var enterpriseRealAddressError = FormBuilderValidators.compose([requiredField('settings_enterprise_real_address'.tr())])(_formKey.currentState!.value['enterprise real address']);
      var enterpriseInnError = FormBuilderValidators.compose([requiredField('settings_enterprise_inn'.tr())])(_formKey.currentState!.value['enterprise inn']);
      var enterpriseSignatoryError = FormBuilderValidators.compose([requiredField('settings_enterprise_signatory'.tr())])(_formKey.currentState!.value['enterprise signatory']);
      var enterprisePhoneError = FormBuilderValidators.compose([requiredField('settings_hint_phone'.tr())])(_formKey.currentState!.value['enterprise phone']);
      var enterpriseEmailError = FormBuilderValidators.compose([requiredField('settings_enterprise_email'.tr())])(_formKey.currentState!.value['enterprise email']);
      var offerError = FormBuilderValidators.compose([FormBuilderValidators.required()])(_formKey.currentState!.value['offer']);
      context.read<SettingsBloc>().add(RequisitesError(error: enterpriseNameError ?? enterpriseAccountError ?? enterpriseBikError
          ?? enterpriseLegalAddressError ?? enterpriseRealAddressError ?? enterpriseInnError ?? enterpriseSignatoryError
          ?? enterprisePhoneError ?? enterpriseEmailError ?? offerError ?? 'unknown_error'.tr()));
    }
    _controller.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
  }

  _openAllOrders() {
    var provider = BlocProvider.of<SettingsBloc>(context);

    context.read<SettingsBloc>().add(const GetBalance());

    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
            initialChildSize: 0.9,
            maxChildSize: 0.9,
            minChildSize: 0.7,
            builder: (context, scrollController) {
              return BlocProvider.value(
                value: provider,
                child: BlocConsumer<SettingsBloc, SettingsState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    var st = context.watch<SettingsBloc>().state;

                    return Container(
                      decoration: const BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                      ),
                      child: _orders(context, st, scrollController),
                    );
                  },
                ),
              );
            }
        );
      }
    );
  }

  _orders(BuildContext context, SettingsState st, ScrollController scrollController) {
    return Column(
      children: [
        const SizedBox(height: 5),
        Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                hideModalBottomSheet(context);
                context.read<SettingsBloc>().add(const RequisitesError(error: '')); // the same as requisites error
              },
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: const EdgeInsets.only(left: 5, bottom: 5, right: 5),
                child: Image.asset('assets/images/close.png', width: 50, height: 50),
              ),
            )
        ),
        const SizedBox(height: 2),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: BoldTitleText('settings_all_orders_title'.tr()),
        ),
        const SizedBox(height: 5),
        ErrorText(st.requisitesError, padding: const EdgeInsets.symmetric(horizontal: 25)), // the same as requisites error
        const SizedBox(height: 5),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('settings_all_orders_your_balance'.tr(), style: AppStyles.ordersTitles),
                  const SizedBox(height: 5),
                  Text('settings_all_balance'.tr(namedArgs: {'balance': st.balance.toStringAsFixed(2)}), style: AppStyles.balance),
                  const SizedBox(height: 20),
                  StaggeredGrid.count(
                    crossAxisCount: 3,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 15,
                    children: [
                      ..._ordersPart('settings_all_order_status.new'.tr(), st.ordersNew),
                      ..._ordersPart('settings_all_order_status.deliveredShop'.tr(), st.ordersDeliveredShop),
                      ..._ordersPart('settings_all_order_status.completed'.tr(), st.ordersCompleted),
                      ..._ordersPart('settings_all_order_status.canceled'.tr(), st.ordersCanceled),
                    ]
                  ),
                  const SizedBox(height: 20),
                ],
              )
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _ordersPart(String title, List<Order> ordersList) {
    return [
      StaggeredGridTile.count(
        mainAxisCellCount: 0.36,
        crossAxisCellCount: 3,
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Text(title, style: AppStyles.ordersTitles),
        ),
      ),
      ...ordersList.map((order) {
        return StaggeredGridTile.count(
          mainAxisCellCount: 1,
          crossAxisCellCount: 1,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: OrderWidget(order, onTap: () => _openSingleOrder(order)),
          ),
        );
      }).toList(),
    ];
  }

  _openSingleOrder(Order order) {
    var provider = BlocProvider.of<SettingsBloc>(context);

    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.9,
          maxChildSize: 0.9,
          minChildSize: 0.7,
          builder: (context, scrollController) {
            return BlocProvider.value(
              value: provider,
              child: BlocConsumer<SettingsBloc, SettingsState>(
                listener: (context, state) {},
                builder: (context, state) {
                  var st = context.watch<SettingsBloc>().state;

                  if (st.orderStatusChanged) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      context.read<SettingsBloc>().add(const ResetOrderStatusChanged());
                      hideModalBottomSheet(context);
                    });
                  }

                  return Container(
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    child: _order(context, st, scrollController, order),
                  );
                },
              ),
            );
          },
        );
      });
  }

  _order(BuildContext context, SettingsState st, ScrollController scrollController, Order order) {
    String? dt = order.date == null ? null : DateFormat('dd.MM.yyyy в kk:mm').format(DateTime.parse(order.date!));

    return Column(
      children: [
        const SizedBox(height: 5),
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () {
              hideModalBottomSheet(context);
              context.read<SettingsBloc>().add(const RequisitesError(error: '')); // the same as requisites error
            },
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.only(left: 5, bottom: 5, right: 5),
              child: Image.asset('assets/images/close.png', width: 50, height: 50),
            ),
          )
        ),
        const SizedBox(height: 2),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: BoldTitleText(order.status == Status.new_.status ? 'settings_request'.tr() : 'settings_order'.tr(namedArgs: {'n': order.id.toString()})),
        ),
        const SizedBox(height: 5),
        ErrorText(st.requisitesError, padding: const EdgeInsets.symmetric(horizontal: 25)),
        const SizedBox(height: 5),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: OrderWidget(order),
                        )
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        flex: 2,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ...?_orderPair('settings_request_date'.tr(), dt),
                            ...?_orderPair('settings_request_name'.tr(), order.name),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ...?_orderPair('settings_request_contacts'.tr(), order.phoneNumber ?? ''),
                  ...?_orderPair('settings_request_address'.tr(), order.address),
                  ...?_orderPair('settings_request_order_content'.tr(), order.contentList),
                  const SizedBox(height: 20),
                  Visibility(
                    visible: order.status == 'new',
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        PurpleButton(
                          text: 'settings_request_refuse'.tr(),
                          loadingText: '',
                          active: true,
                          loading: false,
                          hollow: true,
                          padding: const EdgeInsets.only(bottom: 20),
                          onTap: () => context.read<SettingsBloc>().add(ChangeStatus(orderId: order.id.toString(), status: Status.canceled))
                        ),
                        PurpleButton(
                          text: 'settings_request_accept'.tr(),
                          loadingText: '',
                          active: true,
                          loading: false,
                          padding: const EdgeInsets.only(bottom: 20),
                          onTap: () => context.read<SettingsBloc>().add(ChangeStatus(orderId: order.id.toString(), status: Status.deliveredShop))
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: order.status == 'deliveredShop',
                    child: Column(
                      children: [
                        PurpleButton(
                          text: 'settings_request_support'.tr(),
                          loadingText: '',
                          active: true,
                          loading: false,
                          hollow: true,
                          padding: const EdgeInsets.only(bottom: 20),
                          onTap: () {
                            var message = '';
                              // 'id: ' + order.id.toString() + '\n'
                              // + (order.address ?? '');
                            openSupportSheet(context, _formKey, message: message);
                          },
                        ),
                        PurpleButton(
                          text: 'settings_request_delivered'.tr(),
                          loadingText: '',
                          active: true,
                          loading: false,
                          padding: const EdgeInsets.only(bottom: 20),
                          onTap: () => context.read<SettingsBloc>().add(ChangeStatus(orderId: order.id.toString(), status: Status.completed))
                        ),
                      ],
                    ),
                  ),
                ]
              )
            )
          )
        )
      ]
    );
  }

  List<Widget>? _orderPair(String title, String? text) {
    return text != null ? [
      Text(title, style: AppStyles.requestTitle),
      Text(text, style: AppStyles.requestText),
      const SizedBox(height: 10),
    ] : null;
  }
}