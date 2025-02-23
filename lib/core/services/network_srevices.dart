import 'dart:math';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@injectable
class NetworkServices {
  late Dio dio;
  NetworkServices() {
    init();
  }
  void init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://exam.elevateegy.com/',
        validateStatus: (status) {
          if (status != null) {
            if (status < 300) {
              return true;
            } else if (status == 401) {
              return true;
            } else if(status == 400) {
              return true;
            }
            return false;
          } else {
            return false;
          }
        },
      ),
    );
  }
}
