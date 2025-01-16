import 'package:dic/src/application/bindings/create_account_binding.dart';
import 'package:dic/src/domain/repositories/i_data_base_repository.dart';
import 'package:dic/src/ui/pages/create_account/create_account.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  IDataBaseRepository dataBaseRepository = Get.find<IDataBaseRepository>();
  final RxBool isLoading = false.obs;

  Future<dynamic> login() async {
    isLoading.value = true;
    dynamic responseLogin = await dataBaseRepository.login(
        loginController.text, passwordController.text);
    isLoading.value = false;
    return responseLogin;
  }

  void goToRegister() {
    Get.to(() => const CreateAccount(), binding: CreateAccountBinding());
  }
}
