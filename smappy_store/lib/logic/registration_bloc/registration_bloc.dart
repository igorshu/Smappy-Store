import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logger/logger.dart';
import 'package:smappy_store/core/repository/api_repo.dart';
import 'package:smappy_store/core/repository/local_repo.dart';
import 'package:smappy_store/logic/other/base_bloc.dart';

part 'registration_bloc.freezed.dart';
part 'registration_event.dart';
part 'registration_state.dart';

enum RegStep {phone, code, password, shop}

class RegistrationBloc  extends BaseBloc<RegistrationEvent, RegistrationState>  {

  @override
  RegistrationEvent getErrorEvent(String error) => RegistrationError(error: error);

  RegistrationBloc(RegStep step, String smappyCode) : super(RegistrationState(step: step, smappyCode: smappyCode)) {
    on<RegistrationError>(_registrationError);
    on<ChangePhone>(_changePhone);
    on<ChangeCode>(_changeCode);
    on<ChangePassword>(_changePassword);
    on<ChangeShopData>(_changeShopData);
    on<ChangePasswordObscurity>(_changePasswordObscurity);
    on<ResendCode>(_resendCode);
    on<Next>(_next);
  }

  _changePhone(ChangePhone event, Emitter<RegistrationState> emit) {
    emit(state.copyWith(buttonActive: event.phone.isNotEmpty));
  }

  _changePassword(ChangePassword event, Emitter<RegistrationState> emit) {
    if (event.n == 1) {
      emit(state.copyWith(buttonActive: event.password.isNotEmpty));
    } else {
      emit(state.copyWith(buttonActive: event.password.isNotEmpty));
    }
  }

  _changeCode(ChangeCode event, Emitter<RegistrationState> emit) {
    emit(state.copyWith(buttonActive: event.code.isNotEmpty));
  }

  _changeShopData(ChangeShopData event, Emitter<RegistrationState> emit) {
    var shopName = event.shopName ?? state.shopName;
    var shopAddress = event.shopAddress ?? state.shopAddress;
    var buttonActive = (shopName?.isNotEmpty ?? false) && (shopAddress?.isNotEmpty ?? false);
    emit(state.copyWith(shopName: shopName, shopAddress: shopAddress, buttonActive: buttonActive));
  }

  _registrationError(RegistrationError event, Emitter<RegistrationState> emit) {
    emit(state.copyWith(error: event.error, loading: false));
    Logger().e(event.error);
  }

  _changePasswordObscurity(ChangePasswordObscurity event, Emitter<RegistrationState> emit) {
    if (event.n == 1) {
      emit(state.copyWith(password1Obscurity: event.obscure));
    } else {
      emit(state.copyWith(password2Obscurity: event.obscure));
    }
  }

  _resendCode(ResendCode event, Emitter<RegistrationState> emit) async {
    emit(state.copyWith(loading: true, phone: state.phone));
    var response = await ApiRepo.shopRegistration(state.phone, state.smappyCode); // code 200 is success
    emit(state.copyWith(
      step: RegStep.code,
      verificationCode: response.verificationCode!,
      userId: response.id,
      loading: false,
      buttonActive: false,
      error: '',
    ));
  }

  _next(Next event, Emitter<RegistrationState> emit) async {
    switch(event.step) {
      case RegStep.phone:
        emit(state.copyWith(loading: true, phone: event.phone!));
        var response = await ApiRepo.shopRegistration(event.phone!, state.smappyCode); // code 200 is success
        LocalRepo.saveUserId(response.id);
        emit(state.copyWith(
          step: RegStep.code,
          verificationCode: response.verificationCode!,
          userId: response.id,
          loading: false,
          buttonActive: false,
          error: '',
        ));
        Logger().i(response.verificationCode);
        break;
      case RegStep.code:
        emit(state.copyWith(loading: true));
        var response = await ApiRepo.shopVerifyPhoneNumber(state.userId!, event.code!);
        await LocalRepo.saveToken(response.token);
        ApiRepo.setToken(response.token);
        emit(state.copyWith(
          step: RegStep.password,
          loading: false,
          buttonActive: false,
          error: '',
        ));
        break;
      case RegStep.password:
        if (state.showPassword2) {
          if (event.password1 != event.password2) {
            emit(state.copyWith(error: 'reg_passwords_are_not_equal'.tr(), loading: false));
            return;
          }  
          emit(state.copyWith(loading: true));
          var shopResponse = await ApiRepo.finishRegistration(
            password: event.password1,
          );
          Logger().i(shopResponse);
          emit(state.copyWith(
            password2: event.password2!,
            step: RegStep.shop,
            buttonActive: false,
            loading: false,
            error: '',
          ));
        } else {
          emit(state.copyWith(
            password1: event.password1!,
            showPassword2: true,
          ));
        }
        break;
      case RegStep.shop:
        emit(state.copyWith(loading: true));
        var shopResponse = await ApiRepo.finishRegistration(
          shopName: event.shopName!,
          shopAddress: event.shopAddress!,
        );
        Logger().i(shopResponse);
        emit(state.copyWith(
          loading: false,
          completed: true,
          error: '',
        ));
      break;
      default:
    }
  }
}
