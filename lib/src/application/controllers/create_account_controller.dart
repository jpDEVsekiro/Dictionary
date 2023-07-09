import 'package:dictionary/src/application/bindings/home_binding.dart';
import 'package:dictionary/src/domain/repositories/i_data_base_repository.dart';
import 'package:dictionary/src/ui/pages/home/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateAccountController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final IDataBaseRepository _dataBaseRepository =
      Get.find<IDataBaseRepository>();
  final RxBool isLoading = false.obs;

  createAccount() async {
    if (valid() == false) {
      return;
    }
    isLoading.value = true;
    dynamic result = await _dataBaseRepository.createAccount(
        emailController.text, passwordController.text);
    if (result == true) {
      Get.offAll(() => const Home(), binding: HomeBinding());
    } else {
      Get.snackbar('Erro:', result.toString(),
          icon: const Icon(Icons.error), snackPosition: SnackPosition.BOTTOM);
    }
    isLoading.value = false;
  }

  valid() {
    if (emailController.text.isEmpty) {
      Get.snackbar('Erro', 'Email is empty',
          icon: const Icon(Icons.error), snackPosition: SnackPosition.BOTTOM);
      return false;
    } else if (GetUtils.isEmail(emailController.text) == false) {
      Get.snackbar('Erro', 'Email is invalid',
          icon: const Icon(Icons.error), snackPosition: SnackPosition.BOTTOM);
      return false;
    } else if (passwordController.text.isEmpty) {
      Get.snackbar('Erro', 'Password is empty',
          icon: const Icon(Icons.error), snackPosition: SnackPosition.BOTTOM);
      return false;
    } else if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar('Erro', 'Passwords do not match',
          icon: const Icon(Icons.error), snackPosition: SnackPosition.BOTTOM);
      return false;
    }
    return true;
  }
}
