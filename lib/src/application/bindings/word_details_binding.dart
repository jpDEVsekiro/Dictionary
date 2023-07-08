import 'package:dictionary/src/application/controllers/word_details_controller.dart';
import 'package:dictionary/src/domain/providers/http.dart';
import 'package:dictionary/src/infra/providers/http/dio.dart';
import 'package:get/get.dart';

class WordDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IHttp>(() => DioHttp());
    Get.put(WordDetailsController());
  }
}
