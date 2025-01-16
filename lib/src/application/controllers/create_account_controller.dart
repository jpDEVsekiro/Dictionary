import 'package:dic/src/domain/repositories/i_data_base_repository.dart';
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

  Future<dynamic> createAccount() async {
    String? validAccount = valid();
    if (validAccount != null) {
      return validAccount;
    }
    isLoading.value = true;
    dynamic result = await _dataBaseRepository.createAccount(
        emailController.text, passwordController.text);
    isLoading.value = false;
    return result;
  }

  String? valid() {
    if (emailController.text.isEmpty) {
      return 'Email is empty';
    } else if (GetUtils.isEmail(emailController.text) == false) {
      return 'Email is invalid';
    } else if (passwordController.text.isEmpty) {
      return 'Password is empty';
    } else if (passwordController.text != confirmPasswordController.text) {
      return 'Passwords do\'t match';
    }
    return null;
  }
}
