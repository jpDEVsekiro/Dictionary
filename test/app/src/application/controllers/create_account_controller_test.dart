import 'package:dic/src/application/controllers/create_account_controller.dart';
import 'package:dic/src/domain/repositories/i_data_base_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';

import '../../infra/respositories/fire_base_repository_mock.dart';

void main() async {
  FireBaseRepositoryMock fireBaseRepositoryMock = FireBaseRepositoryMock();
  Get.lazyPut<IDataBaseRepository>(() => fireBaseRepositoryMock);
  CreateAccountController createAccountController = CreateAccountController();
  test('Test createAccountController.login success', () async {
    createAccountController.emailController.text = 'unit_test@gmail.com';
    createAccountController.passwordController.text = '123456';
    createAccountController.confirmPasswordController.text = '123456';
    when(() => fireBaseRepositoryMock.createAccount(
            createAccountController.emailController.text,
            createAccountController.passwordController.text))
        .thenAnswer((_) async => true);
    dynamic result = await createAccountController.createAccount();
    expect(createAccountController.isLoading.value, equals(false));
    expect(result, equals(true));
    verify(() => fireBaseRepositoryMock.createAccount(
        createAccountController.emailController.text,
        createAccountController.passwordController.text)).called(1);
  });
  test('Test createAccountController.login fail', () async {
    createAccountController.emailController.text = 'unit_test@gmail.com';
    createAccountController.passwordController.text = '123456';
    createAccountController.confirmPasswordController.text = '123456';
    when(() => fireBaseRepositoryMock.createAccount(
            createAccountController.emailController.text,
            createAccountController.passwordController.text))
        .thenAnswer((_) async => 'email ja cadastrado');
    dynamic result = await createAccountController.createAccount();
    expect(createAccountController.isLoading.value, equals(false));
    expect(result, equals('email ja cadastrado'));
    verify(() => fireBaseRepositoryMock.createAccount(
        createAccountController.emailController.text,
        createAccountController.passwordController.text)).called(1);
  });

  test('Test createAccountController.login invalid text', () async {
    createAccountController.emailController.text = '';
    createAccountController.passwordController.text = '';
    createAccountController.confirmPasswordController.text = '';
    dynamic result = await createAccountController.createAccount();
    expect(createAccountController.isLoading.value, equals(false));
    expect(result is String, true);
    verifyNever(() => fireBaseRepositoryMock.createAccount(
        createAccountController.emailController.text,
        createAccountController.passwordController.text));
  });

  test('Test createAccountController.valid empty email', () async {
    createAccountController.emailController.text = '';
    createAccountController.passwordController.text = '123456';
    createAccountController.confirmPasswordController.text = '123456';
    dynamic result = createAccountController.valid();
    expect(result is String, true);
    expect(result, 'Email is empty');
    verifyNever(() => fireBaseRepositoryMock.createAccount(
        createAccountController.emailController.text,
        createAccountController.passwordController.text));
  });

  test('Test createAccountController.valid invalid email', () async {
    createAccountController.emailController.text = 'unit_test';
    createAccountController.passwordController.text = '123456';
    createAccountController.confirmPasswordController.text = '123456';
    dynamic result = createAccountController.valid();
    expect(result is String, true);
    expect(result, 'Email is invalid');
    verifyNever(() => fireBaseRepositoryMock.createAccount(
        createAccountController.emailController.text,
        createAccountController.passwordController.text));
  });

  test('Test createAccountController.valid empty password', () async {
    createAccountController.emailController.text = 'unit_test@gmail.com';
    createAccountController.passwordController.text = '';
    createAccountController.confirmPasswordController.text = '123456';
    dynamic result = createAccountController.valid();
    expect(result is String, true);
    expect(result, 'Password is empty');
    verifyNever(() => fireBaseRepositoryMock.createAccount(
        createAccountController.emailController.text,
        createAccountController.passwordController.text));
  });

  test('Test createAccountController.valid Passwords do not match', () async {
    createAccountController.emailController.text = 'unit_test@gmail.com';
    createAccountController.passwordController.text = '123456';
    createAccountController.confirmPasswordController.text = 'ABCDEF';
    dynamic result = createAccountController.valid();
    expect(result is String, true);
    expect(result, 'Passwords do not match');
    verifyNever(() => fireBaseRepositoryMock.createAccount(
        createAccountController.emailController.text,
        createAccountController.passwordController.text));
  });
}
