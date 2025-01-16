import 'package:dic/src/application/controllers/create_account_controller.dart';
import 'package:get/get.dart';

class CreateAccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CreateAccountController());
  }
}
