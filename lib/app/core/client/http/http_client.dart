import 'package:dio/dio.dart';
import 'package:metal_forte/app/core/models/service_model.dart';

late Dio dio;

class HttpClient extends Service {
  @override
  Future<void> initialize() async {
    dio = Dio()..interceptors.add(LogInterceptor());
    dio.options.baseUrl = 'http://metalforte.ntiamerica.inf.br:9999';
    dio.options.headers = {'Content-Type': 'application/json'};
  }
}
