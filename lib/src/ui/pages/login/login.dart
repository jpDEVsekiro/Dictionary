import 'package:dictionary/src/application/controllers/login_controller.dart';
import 'package:dictionary/src/ui/widgets/scaffold_dictionary.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends GetView<LoginController> {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldDictionary(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Login'),
            TextField(
                style: TextStyle(fontSize: Get.width * 0.05),
                controller: controller.loginController,
                decoration: InputDecoration(
                    alignLabelWithHint: true,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: Get.width * 0.02),
                    hintText: 'Login',
                    prefixIcon: const Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 0.8),
                    ))),
            TextField(
                style: TextStyle(fontSize: Get.width * 0.05),
                controller: controller.loginController,
                decoration: InputDecoration(
                    alignLabelWithHint: true,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: Get.width * 0.02),
                    hintText: 'Password',
                    prefixIcon: const Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 0.8),
                    ))),
            InkWell(
              onTap: () => controller.login(),
              child: Container(
                width: Get.width * 0.5,
                height: Get.height * 0.06,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.blue,
                ),
                child: const Center(
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
