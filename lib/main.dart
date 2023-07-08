import 'package:dictionary/src/application/bindings/login_binding.dart';
import 'package:dictionary/src/domain/repositories/i_data_base_repository.dart';
import 'package:dictionary/src/infra/repositories/fire_base_repository.dart';
import 'package:dictionary/src/ui/pages/login/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.lazyPut<IDataBaseRepository>(() => FireBaseRepository());
  await Get.find<IDataBaseRepository>().init();
  runApp(GetMaterialApp(
    defaultTransition: Transition.noTransition,
    debugShowCheckedModeBanner: false,
    home: const Login(),
    initialBinding: LoginBinding(),
  ));
}
