import 'package:dic/src/application/controllers/login_controller.dart';
import 'package:dic/src/domain/repositories/i_data_base_repository.dart';
import 'package:dic/src/infra/repositories/fire_base_repository.dart';
import 'package:get/get.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IDataBaseRepository>(() => FireBaseRepository());
    Get.put(LoginController());
  }
}
