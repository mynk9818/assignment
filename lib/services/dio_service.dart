import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../routes.dart';

class DioServices {
  static Dio? _instance;
  static Dio getInstance() {
    _instance ??= createDioInstance();
    return _instance!;
  }

  static Dio createDioInstance() {
    var dio = Dio();
    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (e, handler) {
          OnGenerateRoute.scaffoldKey.currentState?.showSnackBar(SnackBar(content: Text(e.message.toString())));
          if (e.response != null) {
            handler.resolve(e.response!);
          }
        },
      ),
    );
    return dio..interceptors.add(ChuckerDioInterceptor());
  }
}
