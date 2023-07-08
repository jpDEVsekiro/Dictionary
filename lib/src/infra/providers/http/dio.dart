import 'package:dictionary/src/domain/models/method.dart';
import 'package:dictionary/src/domain/providers/i_http.dart';
import 'package:dio/dio.dart';

class DioHttp implements IHttp {
  Dio? _dio;

  Future<bool> _init() async {
    var baseUrl = 'https://wordsapiv1.p.rapidapi.com/words/';

    Map<String, dynamic> header = {
      'X-RapidAPI-Key': 'fadea05c97mshb75e2c78e2a8e73p1eb860jsnfbe968ef4e4a',
      'X-RapidAPI-Host': 'wordsapiv1.p.rapidapi.com'
    };

    _dio = Dio(BaseOptions(
        baseUrl: baseUrl,
        headers: header,
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 120)));
    _initInterceptors();
    return true;
  }

  void _initInterceptors() {
    _dio!.interceptors.add(
      InterceptorsWrapper(
        onRequest: (requestOptions, handler) {
          return handler.next(requestOptions);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (err, handler) {
          return handler.next(err);
        },
      ),
    );
  }

  @override
  Future<dynamic> request(
      {required String url, required Method method, dynamic params}) async {
    Response response;

    if (await _init() == false) {
      return false;
    }

    try {
      if (method == Method.post) {
        response = await _dio!.post(
          url,
          data: params,
        );
      } else if (method == Method.delete) {
        response = await _dio!.delete(url);
      } else if (method == Method.patch) {
        response = await _dio!.patch(url);
      } else {
        response = await _dio!.get(url, queryParameters: params);
      }

      if (response.statusCode == 200 || response.statusCode == 204) {
        return response.data;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
