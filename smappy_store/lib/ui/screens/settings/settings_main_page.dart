import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smappy_store/logic/settings_bloc/settings_bloc.dart';
import 'package:smappy_store/ui/other/colors.dart';
import 'package:smappy_store/ui/other/input_decorations.dart';
import 'package:smappy_store/ui/other/styles.dart';
import 'package:smappy_store/ui/other/ui_utils.dart';
import 'package:smappy_store/ui/widgets/bold_title_text.dart';
import 'package:smappy_store/ui/widgets/error_text.dart';
import 'package:smappy_store/ui/widgets/fields/app_text_field.dart';
import 'package:smappy_store/ui/widgets/go_next_text.dart';
import 'package:smappy_store/ui/widgets/horizontal_gray_line.dart';
import 'package:smappy_store/ui/widgets/purple_text.dart';
import 'package:smappy_store/ui/widgets/rounded.dart';
import 'package:smappy_store/ui/widgets/settings_screen/settings_check_box.dart';

class SettingsMainPage extends StatelessWidget {

  final _formKey = GlobalKey<FormBuilderState>();
  final _searchFormKey = GlobalKey<FormBuilderState>();

  SettingsMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var st = context.watch<SettingsBloc>().state;

    return FormBuilder(
      key: _formKey,
      child: BlocConsumer<SettingsBloc, SettingsState>(
        listener: (context, state) {
          if (state.shopData != null) {
            if (_formKey.currentState?.fields['name']?.value != state.shopData!.name) {
              _formKey.currentState?.fields['name']?.didChange(state.shopData!.name);
            }
            if (_formKey.currentState?.fields['description']?.value != state.shopData!.description) {
              _formKey.currentState?.fields['description']?.didChange(state.shopData!.description);
            }
            if (_formKey.currentState?.fields['address']?.value != state.shopData!.address) {
              _formKey.currentState?.fields['address']?.didChange(state.shopData!.address);
            }
          }
          if (_formKey.currentState?.fields['everywhere']?.value != state.allowCountryDelivery) {
            _formKey.currentState?.fields['everywhere']?.didChange(state.allowCountryDelivery);
          }
        },
        builder: (context, state) {
          return Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              (st.photo == null
                                ? Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Image.asset('assets/images/bg_logo.png', height: 61, width: 61),
                                    Text(st.getFirstLetter, style: AppStyles.logoStyle, textAlign: TextAlign.center),
                                  ]
                                )
                                : ClipOval(
                                  child: CachedNetworkImage(
                                    imageUrl: st.photo!,
                                    fit: BoxFit.cover,
                                    height: 61,
                                    width: 61,
                                  ),
                                )
                              ),
                              const SizedBox(width: 16),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('settings_your_logo'.tr(), style: AppStyles.yourLogo),
                                  GoNextText('settings_change_logo'.tr(), onTap: () => _showChangeLogo(context, st)),
                                ],
                              ),
                            ],
                          ),
                          const HorizontalGrayLine(top: 20, bottom: 20),
                          AppTextField(
                            key: const ValueKey('shop_name'),
                            initialValue: st.shopData?.name,
                            hintText: 'settings_shop_name'.tr(),
                            name: 'name',
                            onChanged: (value) {
                              context.read<SettingsBloc>().add(ChangedShopName(name: value ?? ''));
                            }
                          ),
                          const HorizontalGrayLine(top: 20, bottom: 20),
                          AppTextField(
                            key: const ValueKey('shop_description'),
                            initialValue: st.shopData?.description,
                            hintText: 'settings_shop_description'.tr(),
                            name: 'description',
                            onChanged: (value) => context.read<SettingsBloc>().add(ChangedShopDescription(description: value ?? ''))
                          ),
                          const HorizontalGrayLine(top: 20, bottom: 20),
                          AppTextField(
                            key: const ValueKey('shop_address'),
                            // key: st.shopData == null ? null : const ValueKey('shop_address'),
                            initialValue: st.shopData?.address,
                            hintText: 'settings_shop_address'.tr(),
                            name: 'address',
                            onChanged: (value) => context.read<SettingsBloc>().add(ChangedShopAddress(address: value ?? ''))
                          ),
                          const HorizontalGrayLine(top: 20, bottom: 20),
                          Text('settings_shop_delivery'.tr(), style: AppStyles.hintTextStyle),
                          SettingsCheckBox(
                            key: const ValueKey('shop_delivery'),
                            // key: UniqueKey(),
                            'settings_deliver_everywhere'.tr(),
                            name: 'everywhere',
                            initialValue: st.allowCountryDelivery,
                            onChange: (value) => context.read<SettingsBloc>().add(DeliveryEverywhere(everywhere: value)),
                          ),
                          const HorizontalGrayLine(top: 0, bottom: 20),
                          GestureDetector(
                            onTap: () => _openCities(context),
                            behavior: HitTestBehavior.opaque,
                            child: PurpleText('settings_choose_cities'.tr()),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),

                ],
              ),
            );
        },
      ),
    );
  }

  _openCities(BuildContext context) {
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
                    child: _cities(context, st, scrollController),
                  );
                },
              );
            },
          ),
        );
      });
  }

  _cities(BuildContext context, SettingsState st, ScrollController scrollController) {
    return Column(
      children: [
        const SizedBox(height: 5),
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () {
              hideModalBottomSheet(context);
              context.read<SettingsBloc>().add(const DeliveryError(error: ''));
            },
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.only(left: 5, bottom: 5, right: 5),
              child: Image.asset('assets/images/close.png', width: 50, height: 50),
            ),
          )
        ),
        const SizedBox(height: 2),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BoldTitleText('settings_shop_delivery'.tr()),
                const SizedBox(height: 10),
                ErrorText(st.deliveryError),
                const SizedBox(height: 10),
                Text('settings_delivery_select_cities'.tr(), style: AppStyles.selectCities),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.only(right: 25),
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 25,
                      )
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(6)),
                    child: ColoredBox(
                      color: AppColors.white,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Text('settings_delivery_enter_city'.tr(), style: AppStyles.enterCity),
                          ),
                          const SizedBox(height: 2),
                          BlocConsumer<SettingsBloc, SettingsState>(
                            listener: (context, state) {
                              if (_searchFormKey.currentState?.fields['search']?.value != state.searchText) {
                                _searchFormKey.currentState?.patchValue({'search': state.searchText});
                              }
                            },
                            builder: (context, state) {
                              return FormBuilder(
                                key: _searchFormKey,
                                child: FormBuilderTextField(
                                  name: 'search',
                                  decoration: NoDecoration(hintText: 'Москва'),
                                  cursorColor: AppColors.black,
                                  onChanged: (value) async => context.read<SettingsBloc>().add(SearchChanged(searchText: value ?? '')),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 4),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: [
                      !st.isCitiesResultEmpty
                        ? ListView.builder(
                          itemCount: st.citySearchResults.length,
                          itemBuilder: (context, index) {
                            var city = st.citySearchResults[index];
                            return GestureDetector(
                              onTap: () => context.read<SettingsBloc>().add(CitySelected(city: city)),
                              behavior: HitTestBehavior.opaque,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 25, top: 10, bottom: 10),
                                child: Text(city.name, style: AppStyles.selectCities),
                              ),
                            );
                          },
                        )
                        : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:  [
                            const SizedBox(height: 25),
                            const HorizontalGrayLine(),
                            const SizedBox(height: 15),
                            Row(
                              children: [
                                const Text('Города:', style: AppStyles.selectCities),
                                const Spacer(),
                                Visibility(
                                  visible: st.editCities,
                                  child: GestureDetector(
                                    onTap: () => context.read<SettingsBloc>().add(const RemoveCities()),
                                    behavior: HitTestBehavior.opaque,
                                    child: Text('settings_delivery_delete_cities'.tr(), style: AppStyles.deleteCities),
                                  ),
                                ),
                                Visibility(
                                  visible: st.deliveryCities.isNotEmpty && !st.editCities,
                                  child: GestureDetector(
                                    onTap: () => context.read<SettingsBloc>().add(const EditCities(edit: true)),
                                    behavior: HitTestBehavior.opaque,
                                    child: Text('settings_delivery_change'.tr(), style: AppStyles.deleteCities),
                                  ),
                                ),
                                const SizedBox(width: 25),
                              ]
                            ),
                            const SizedBox(height: 10),
                            st.deliveryCities.isNotEmpty
                              ? Wrap(
                                children: st.deliveryCities.map((city) {
                                  return GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () {
                                      if (st.editCities) {
                                        context.read<SettingsBloc>().add(
                                          CityForDeleting(
                                            delete: st.isForDeleting(city),
                                            city: city,
                                          )
                                        );
                                      }
                                    },
                                    child: Rounded(4,
                                      padding: const EdgeInsets.only(left: 12, top: 4, right: 12, bottom: 3),
                                      margin: const EdgeInsets.only(right: 10, bottom: 10),
                                      fillColor: st.isForDeleting(city) ? AppColors.purple : AppColors.white,
                                      color: AppColors.purple,
                                      child: Text(
                                        city.name,
                                        style: st.isForDeleting(city) ? AppStyles.cityNameSelected : AppStyles.cityName,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              )
                              : Expanded(
                                  child: Column(
                                    children: [
                                      const Spacer(),
                                      Center(child: Text('settings_delivery_city_not_selected'.tr(), style: AppStyles.enterCity)),
                                      const Spacer(),
                                    ],
                                  )
                              ),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ]
    );
  }

  _showChangeLogo(BuildContext context, SettingsState st) {
    var provider = BlocProvider.of<SettingsBloc>(context);

    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return BlocProvider.value(
          value: provider,
          child: BlocConsumer<SettingsBloc, SettingsState>(
            listener: (BuildContext context, state) {},
            builder: (BuildContext context, SettingsState state) {
              return CupertinoActionSheet(
                title: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 37),
                  child: Text('settings_set_photo'.tr(), style: AppStyles.cupertinoTitleTextStyle),
                ),
                actions: [
                  CupertinoActionSheetAction(
                    onPressed: () => _pickImage(ImageSource.camera, (image) {
                      if (image != null) {
                        context.read<SettingsBloc>().add(UploadLogo(path: image.path));
                      }
                    }),
                    child: Text('settings_set_camera'.tr(), style: AppStyles.cupertinoActionTextStyle),
                  ),
                  CupertinoActionSheetAction(
                    onPressed: () => _pickImage(ImageSource.gallery, (image) {
                      if (image != null) {
                        context.read<SettingsBloc>().add(UploadLogo(path: image.path));
                      }
                    }),
                    child: Text('settings_set_library'.tr(), style: AppStyles.cupertinoActionTextStyle),
                  )
                ],
                cancelButton: CupertinoActionSheetAction(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('add_good_cancel'.tr(), style: AppStyles.cupertinoActionTextStyle),
                ),
              );
            },
          ),
        );
      },
    );
  }

  _pickImage(ImageSource source, Function(XFile? image) addEvent) async {
    final ImagePicker picker = ImagePicker();
    var image = await picker.pickImage(source: source);
    addEvent.call(image);
  }

}