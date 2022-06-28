import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

abstract class BaseBloc<E, S> extends Bloc<E, S> {

  E getErrorEvent(String error);

  BaseBloc(super.initialState);

  @override
  void onError(Object error, StackTrace stackTrace) {
    if (error is DioError) {
      var err = 'unknown_error'.tr();
      switch(error.type) {
        case DioErrorType.connectTimeout:
          err = 'connect_timeout'.tr();
          break;
        case DioErrorType.sendTimeout:
          err = 'send_timeout'.tr();
          break;
        case DioErrorType.receiveTimeout:
          err = 'receive_timeout'.tr();
          break;
        case DioErrorType.response:
          err = error.response.toString();
          break;
        case DioErrorType.cancel:
          err = 'error_cancel'.tr();
          break;
        case DioErrorType.other:
          err = error.message;
          break;
      }
      Logger().e(err);
      add(getErrorEvent(err));
    } else {
      Logger().e(error);
      add(getErrorEvent(error.toString()));
    }
  }
}