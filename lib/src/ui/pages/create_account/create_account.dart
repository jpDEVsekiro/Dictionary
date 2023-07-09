import 'package:dictionary/src/application/controllers/create_account_controller.dart';
import 'package:dictionary/src/ui/widgets/scaffold_dictionary.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateAccount extends GetView<CreateAccountController> {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldDictionary(
      body: Column(
        children: [
          TextField(
              style: TextStyle(fontSize: Get.width * 0.05),
              controller: controller.emailController,
              decoration: InputDecoration(
                  alignLabelWithHint: true,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: Get.width * 0.02),
                  hintText: 'Email',
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide:
                        const BorderSide(color: Color(0xFF465275), width: 0.8),
                  ))),
          TextField(
              style: TextStyle(fontSize: Get.width * 0.05),
              controller: controller.passwordController,
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
                        const BorderSide(color: Color(0xFF465275), width: 0.8),
                  ))),
          InkWell(
            onTap: () => controller.createAccount(),
            child: Container(
              width: Get.width * 0.5,
              height: Get.height * 0.06,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Color(0xFF465275),
              ),
              child: const Center(
                child: Text(
                  'Create Account',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
