import 'package:dictionary/src/application/bindings/create_account_binding.dart';
import 'package:dictionary/src/application/bindings/home_binding.dart';
import 'package:dictionary/src/domain/repositories/i_data_base_repository.dart';
import 'package:dictionary/src/ui/pages/create_account/create_account.dart';
import 'package:dictionary/src/ui/pages/home/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final IDataBaseRepository _dataBaseRepository =
      Get.find<IDataBaseRepository>();
  final RxBool isLoading = false.obs;

  Future<void> login() async {
    isLoading.value = true;
    dynamic responseLogin = await _dataBaseRepository.login(
        loginController.text, passwordController.text);
    if (responseLogin == true) {
      Get.off(() => const Home(), binding: HomeBinding());
    } else {
      Get.snackbar('Erro:', responseLogin.toString(),
          icon: const Icon(Icons.error), snackPosition: SnackPosition.BOTTOM);
    }
    isLoading.value = false;
  }

  void goToRegister() {
    Get.to(() => const CreateAccount(), binding: CreateAccountBinding());
  }
}
