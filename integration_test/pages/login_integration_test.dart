import 'package:dic/src/application/bindings/login_binding.dart';
import 'package:dic/src/domain/repositories/i_data_base_repository.dart';
import 'package:dic/src/infra/repositories/fire_base_repository.dart';
import 'package:dic/src/ui/pages/home/home.dart';
import 'package:dic/src/ui/pages/login/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:integration_test/integration_test.dart';

class LoginIntegrationTest {
  static Future<void> login(WidgetTester tester) async {
    // Load app widget.
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
    await tester.enterText(find.byKey(Key('email')), 'test123123@gmail.com');
    await tester.enterText(find.byKey(Key('password')), '123456');
    FocusScope.of(Get.context!).requestFocus(FocusNode());
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(Key('login_button')));
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 2));
    expect(find.byType(Login), findsNothing);
    expect(find.byType(Home), findsOneWidget);
  }
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  loginTest();
  failLoginTest();
}

void loginTest() {
  testWidgets('Login test', (tester) async {
    await LoginIntegrationTest.login(tester);
  });
}

void failLoginTest() {
  testWidgets('Fail login test', (tester) async {
    // Load app widget.
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
    await tester.enterText(find.byKey(Key('email')), 'test123123@gmail.com');
    await tester.enterText(find.byKey(Key('password')), 'ABCDEF');
    FocusScope.of(Get.context!).requestFocus(FocusNode());
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(Key('login_button')));
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 2));
    expect(find.byType(Login), findsOneWidget);
    expect(find.byKey(Key('email')), findsOneWidget);
    expect(find.byKey(Key('password')), findsOneWidget);
    expect(find.byKey(Key('login_button')), findsOneWidget);
    expect(find.byKey(Key('register_button')), findsOneWidget);
    expect(find.byType(Login), findsOneWidget);
  });
}
