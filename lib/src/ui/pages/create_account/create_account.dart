import 'package:dictionary/src/application/controllers/create_account_controller.dart';
import 'package:dictionary/src/ui/widgets/scaffold_dictionary.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateAccount extends GetView<CreateAccountController> {
  const CreateAccount({Key? key}) : super(key: key);

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
                      padding: EdgeInsets.only(top: Get.height * 0.2),
                      child: TextField(
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
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: Get.height * 0.04),
                      child: TextField(
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
                                onTap: () => controller.createAccount(),
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
