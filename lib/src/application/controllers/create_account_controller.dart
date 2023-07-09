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

  createAccount() async {
    await _dataBaseRepository.createAccount(
        emailController.text, passwordController.text);
    Get.offAll(() => const Home(), binding: HomeBinding());
  }
}
