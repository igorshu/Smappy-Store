// import 'package:dio/dio.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:logger/logger.dart';

// mixin ErrorHandler on Bloc<E, S> {
//
//   // void onError(Object error, StackTrace stackTrace) {
//   //   if (error is DioError) {
//   //     Logger().e(error.response);
//   //     add(LoginError(error: error.response.toString()));
//   //   } else {
//   //     Logger().e(error);
//   //     add(LoginError(error: error.toString()));
//   //   }
//   // }
//
// }

abstract class BlocError<T> {
  T getErrorEvent(String error);
}