import 'package:dio/dio.dart';
import 'package:flutter_tech_posts_trending/shared/spref.dart';

class Service {
  static BaseOptions _options = new BaseOptions(
    baseUrl: "http://192.168.1.15:3000",
    connectTimeout: 5000,
    receiveTimeout: 3000,
  );
  static Dio _dio = Dio(_options);

  Service._internal() {
    //_dio.interceptors.add(LogInterceptor(responseBody: true));
    _dio.interceptors
        .add(InterceptorsWrapper(onRequest: (Options myOption) async {
      var token = await SPref.instance.get("token");
      if (token != null) {
        print("=================");
        print(token);
        print("=================");
        myOption.headers["Authorization"] = "Bearer " + token;
        
      }

      return myOption;
    }));
  }
  static final Service instance = Service._internal();

  Dio get dio => _dio;
}