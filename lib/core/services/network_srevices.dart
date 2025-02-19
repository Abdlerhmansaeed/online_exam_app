import 'dart:math';

import 'package:dio/dio.dart';

class NetworkSrevices {
  late Dio dio;
  NetworkSrevices() {
    init();
  }
  void init() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://exam.elevateegy.com/',
      validateStatus: (status) {
        if (status != null) {
          if (status < 300) {
            return true;
          } else if (status == 401) {
            return false;
          } else {
            return false;
          }
        } else {
          return false;
        }
      },
    ));
  }
}
