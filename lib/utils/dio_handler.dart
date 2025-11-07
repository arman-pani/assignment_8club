import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioHandler {
  static final GetIt _sl = GetIt.instance;

  static void setup() {
    final dio = Dio(
      BaseOptions(
        baseUrl: "https://staging.chamberofsecrets.8club.co/v1/",
        connectTimeout: Duration(milliseconds: 5000),
        receiveTimeout: Duration(milliseconds: 3000),
      ),
    );

    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: false,
        responseBody: true,
        error: true,
        compact: true,
      ),
    );

    _sl.registerSingleton<Dio>(dio);
  }

  static Dio get dio => _sl<Dio>();
}
