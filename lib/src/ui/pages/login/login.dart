import 'package:dic/src/application/bindings/home_binding.dart';
import 'package:dic/src/application/controllers/login_controller.dart';
import 'package:dic/src/ui/pages/home/home.dart';
import 'package:dic/src/ui/widgets/scaffold_dictionary.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends GetView<LoginController> {
  const Login({Key? key}) : super(key: key);

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
                    Image.asset(
                      'assets/images/dictionary.jpg',
                      width: Get.width * 0.75,
                      height: Get.height * 0.3,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: Get.height * 0.0),
                      child: TextField(
                          key: const Key('email'),
                          style: TextStyle(fontSize: Get.width * 0.05),
                          controller: controller.loginController,
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
                          key: const Key('password'),
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
                      padding: EdgeInsets.only(
                          top: Get.height * 0.09, bottom: Get.height * 0.015),
                      child: Obx(
                        () => controller.isLoading.value
                            ? const CircularProgressIndicator(
                                color: Color(0xFF465275))
                            : InkWell(
                                key: const Key('login_button'),
                                onTap: () async {
                                  dynamic result = await controller.login();
                                  if (result == true) {
                                    Get.off(() => const Home(),
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
                                      'Login',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                      ),
                    ),
                    InkWell(
                      key: const Key('register_button'),
                      onTap: () => controller.goToRegister(),
                      child: Text('Don\'t have an account? Sign up',
                          style: TextStyle(
                              color: const Color(0xFF465275),
                              fontSize: Get.height * 0.02,
                              decoration: TextDecoration.underline)),
                    )
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
