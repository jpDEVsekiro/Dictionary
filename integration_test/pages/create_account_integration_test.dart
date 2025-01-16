import 'package:dic/src/application/bindings/login_binding.dart';
import 'package:dic/src/domain/repositories/i_data_base_repository.dart';
import 'package:dic/src/infra/repositories/fire_base_repository.dart';
import 'package:dic/src/ui/pages/create_account/create_account.dart';
import 'package:dic/src/ui/pages/home/home.dart';
import 'package:dic/src/ui/pages/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  createAccountTest();
  createAccountFailTest();
}

Future<void> openAppTest(WidgetTester tester) async {
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color(0xFF465275),
      statusBarBrightness: Brightness.light));
  Get.lazyPut<IDataBaseRepository>(() => FireBaseRepository());
  await Get.find<IDataBaseRepository>().init();
  await tester.pumpWidget(GetMaterialApp(
    defaultTransition: Transition.noTransition,
    debugShowCheckedModeBanner: false,
    home: const Login(),
    initialBinding: LoginBinding(),
  ));
  expect(find.byType(Login), findsOneWidget);
  expect(find.byKey(Key('email')), findsOneWidget);
  expect(find.byKey(Key('password')), findsOneWidget);
  expect(find.byKey(Key('login_button')), findsOneWidget);
  expect(find.byKey(Key('register_button')), findsOneWidget);
}

void createAccountTest() {
  testWidgets('Create Account test', (tester) async {
    await openAppTest(tester);
    await tester.tap(find.byKey(Key('register_button')));
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 1));
    expect(find.byType(CreateAccount), findsOneWidget);
    expect(find.byKey(const Key('email_create_account')), findsOneWidget);
    expect(find.byKey(const Key('password_create_account')), findsOneWidget);
    expect(find.byKey(const Key('confirm_password_create_account')),
        findsOneWidget);
    expect(find.byKey(const Key('create_account_button')), findsOneWidget);
    await tester.enterText(find.byKey(const Key('email_create_account')),
        '${DateTime.now().millisecondsSinceEpoch}@gmail.com');
    await tester.enterText(
        find.byKey(const Key('password_create_account')), '123456');
    await tester.enterText(
        find.byKey(const Key('confirm_password_create_account')), '123456');
    FocusScope.of(Get.context!).requestFocus(FocusNode());
    await Future.delayed(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('create_account_button')));
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 2));
    expect(find.byType(CreateAccount), findsNothing);
    expect(find.byType(Home), findsOneWidget);
  });
}

void createAccountFailTest() {
  testWidgets('Create Account test', (tester) async {
    await openAppTest(tester);
    await tester.tap(find.byKey(Key('register_button')));
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 1));
    expect(find.byType(CreateAccount), findsOneWidget);
    expect(find.byKey(const Key('email_create_account')), findsOneWidget);
    expect(find.byKey(const Key('password_create_account')), findsOneWidget);
    expect(find.byKey(const Key('confirm_password_create_account')),
        findsOneWidget);
    expect(find.byKey(const Key('create_account_button')), findsOneWidget);

    /// Create account with invalid email.
    await tester.enterText(find.byKey(const Key('email_create_account')),
        '${DateTime.now().millisecondsSinceEpoch}@gmail');
    await tester.enterText(
        find.byKey(const Key('password_create_account')), '123456');
    await tester.enterText(
        find.byKey(const Key('confirm_password_create_account')), '123456');
    FocusScope.of(Get.context!).requestFocus(FocusNode());
    await Future.delayed(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('create_account_button')));
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 2));
    expect(find.byType(CreateAccount), findsOneWidget);
    expect(find.byType(Home), findsNothing);

    /// Create account with invalid password.
    await tester.enterText(find.byKey(const Key('email_create_account')),
        '${DateTime.now().millisecondsSinceEpoch}@gmail.com');
    await tester.enterText(
        find.byKey(const Key('password_create_account')), '');
    await tester.enterText(
        find.byKey(const Key('confirm_password_create_account')), '');
    FocusScope.of(Get.context!).requestFocus(FocusNode());
    await Future.delayed(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('create_account_button')));
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 2));
    expect(find.byType(CreateAccount), findsOneWidget);
    expect(find.byType(Home), findsNothing);

    /// Create account with password that don't match.
    await tester.enterText(find.byKey(const Key('email_create_account')),
        '${DateTime.now().millisecondsSinceEpoch}@gmail.com');
    await tester.enterText(
        find.byKey(const Key('password_create_account')), '123456');
    await tester.enterText(
        find.byKey(const Key('confirm_password_create_account')), 'ABCDEF');
    FocusScope.of(Get.context!).requestFocus(FocusNode());
    await Future.delayed(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('create_account_button')));
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 2));
    expect(find.byType(CreateAccount), findsOneWidget);
    expect(find.byType(Home), findsNothing);
  });
}
