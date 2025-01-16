import 'package:dic/src/application/bindings/home_binding.dart';
import 'package:dic/src/application/controllers/create_account_controller.dart';
import 'package:dic/src/ui/pages/home/home.dart';
import 'package:dic/src/ui/widgets/scaffold_dictionary.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateAccount extends GetView<CreateAccountController> {
  const CreateAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldDictionary(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              top: Get.height * 0.111,
              left: Get.width * 0.05,
              right: Get.width * 0.05),
          child: SizedBox(
            width: Get.width * 0.9,
            height: Get.height * 0.75,
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: Get.height * 0.06, bottom: Get.height * 0.07),
                      child: Image.asset('assets/images/logo.jpg',
                          width: Get.width * 0.25, height: Get.width * 0.25),
                    ),
                    TextField(
                        key: const Key('email_create_account'),
                        style: TextStyle(fontSize: Get.width * 0.05),
                        controller: controller.emailController,
                        cursorColor: const Color(0xFF465275),
                        decoration: InputDecoration(
                            alignLabelWithHint: true,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: Get.width * 0.02),
                            hintText: 'Email',
                            prefixIcon: const Icon(Icons.email,
                                color: Color(0xFF465275)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: const BorderSide(
                                  color: Color(0xFF465275), width: 0.8),
                            ))),
                    Padding(
                      padding: EdgeInsets.only(top: Get.height * 0.04),
                      child: TextField(
                          key: const Key('password_create_account'),
                          style: TextStyle(fontSize: Get.width * 0.05),
                          obscureText: true,
                          controller: controller.passwordController,
                          cursorColor: const Color(0xFF465275),
                          decoration: InputDecoration(
                              alignLabelWithHint: true,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: Get.width * 0.02),
                              hintText: 'Password',
                              prefixIcon: const Icon(Icons.lock,
                                  color: Color(0xFF465275)),
                              focusColor: const Color(0xFF465275),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: const BorderSide(
                                    color: Color(0xFF465275), width: 0.8),
                              ))),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: Get.height * 0.04),
                      child: TextField(
                          key: const Key('confirm_password_create_account'),
                          style: TextStyle(fontSize: Get.width * 0.05),
                          obscureText: true,
                          controller: controller.confirmPasswordController,
                          cursorColor: const Color(0xFF465275),
                          decoration: InputDecoration(
                              alignLabelWithHint: true,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: Get.width * 0.02),
                              hintText: 'Confirm Password',
                              prefixIcon: const Icon(Icons.lock,
                                  color: Color(0xFF465275)),
                              focusColor: const Color(0xFF465275),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: const BorderSide(
                                    color: Color(0xFF465275), width: 0.8),
                              ))),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: Get.height * 0.05, bottom: Get.height * 0.015),
                      child: Obx(
                        () => controller.isLoading.value
                            ? const CircularProgressIndicator(
                                color: Color(0xFF465275))
                            : InkWell(
                                key: const Key('create_account_button'),
                                onTap: () async {
                                  dynamic result =
                                      await controller.createAccount();
                                  if (result == true) {
                                    Get.offAll(() => const Home(),
                                        binding: HomeBinding());
                                  } else {
                                    Get.snackbar('Erro:', result.toString(),
                                        icon: const Icon(Icons.error),
                                        snackPosition: SnackPosition.BOTTOM);
                                  }
                                },
                                child: Container(
                                  width: Get.width * 0.5,
                                  height: Get.height * 0.06,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    color: const Color(0xFF465275),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'Create Account',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
