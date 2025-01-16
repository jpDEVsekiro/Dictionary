import 'package:dic/src/application/controllers/word_details_controller.dart';
import 'package:dic/src/domain/providers/i_http.dart';
import 'package:dic/src/infra/providers/http/dio.dart';
import 'package:get/get.dart';

class WordDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IHttp>(() => DioHttp());
    Get.put(WordDetailsController());
  }
}
