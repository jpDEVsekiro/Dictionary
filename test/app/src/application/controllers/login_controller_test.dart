import 'package:dic/src/application/controllers/login_controller.dart';
import 'package:dic/src/domain/repositories/i_data_base_repository.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../infra/respositories/fire_base_repository_mock.dart';

void main() async {
  FireBaseRepositoryMock fireBaseRepositoryMock = FireBaseRepositoryMock();
  Get.lazyPut<IDataBaseRepository>(() => fireBaseRepositoryMock);
  LoginController loginController = LoginController();

  test('Test LoginController.login success', () async {
    loginController.loginController.text = 'test123@gmail.com';
    loginController.passwordController.text = '123456';
    when(() => fireBaseRepositoryMock.login(
        loginController.loginController.text,
        loginController.passwordController.text)).thenAnswer((_) async => true);
    dynamic result = await loginController.login();

    expect(loginController.isLoading.value, equals(false));
    expect(result, equals(true));
    verify(() => fireBaseRepositoryMock.login(
        loginController.loginController.text,
        loginController.passwordController.text)).called(1);
  });
  test('Test LoginController.login fail', () async {
    loginController.loginController.text = '';
    loginController.passwordController.text = '';
    when(() => fireBaseRepositoryMock.login(
            loginController.loginController.text,
            loginController.passwordController.text))
        .thenAnswer((_) async => 'erro ao logar');
    dynamic result = await loginController.login();

    expect(loginController.isLoading.value, equals(false));
    expect(result, equals('erro ao logar'));
    verify(() => fireBaseRepositoryMock.login(
        loginController.loginController.text,
        loginController.passwordController.text)).called(1);
  });
}
