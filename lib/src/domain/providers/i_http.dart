import 'package:dic/src/domain/models/method.dart';

abstract class IHttp {
  Future<dynamic> request(
      {required String url, required Method method, dynamic params});
}
