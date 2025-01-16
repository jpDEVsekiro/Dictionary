import 'package:dic/src/application/controllers/home_controller.dart';
import 'package:dic/src/domain/repositories/i_data_base_repository.dart';
import 'package:dic/src/ui/pages/home/home.dart';
import 'package:dic/src/ui/pages/login/login.dart';
import 'package:dic/src/ui/pages/word_details/word_details.dart';
import 'package:dic/src/ui/widgets/scaffold_dictionary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:integration_test/integration_test.dart';

import 'login_integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  homeTest();
  homeSearchTest();
  favoriteTest();
  findWordHistory();
}

void homeTest() {
  testWidgets('Home test find word', (tester) async {
    await LoginIntegrationTest.login(tester);
    expect(find.byType(Home), findsOneWidget);
    expect(find.byType(Login), findsNothing);
    expect(find.byType(ScaffoldDictionary), findsOneWidget);
    expect(find.byKey(Key('search_home')), findsOneWidget);
    expect(find.byKey(Key('words_grid')), findsOneWidget);
    DateTime dateTime = DateTime.now();
    while (find.byKey(Key('adventure_words')).tryEvaluate() == false &&
        DateTime.now().difference(dateTime).inMinutes < 1) {
      await tester.drag(find.byKey(Key('words_grid')), const Offset(0, -500));
      await tester.pumpAndSettle();
    }
    await Future.delayed(const Duration(seconds: 2));
    expect(find.byKey(Key('adventure_words')), findsOneWidget);
    await tester.tap(find.byKey(Key('adventure_words')));
    await tester.pumpAndSettle();
    expect(find.byType(Home), findsNothing);
    expect(find.byType(WordDetails), findsOneWidget);
    await Future.delayed(Duration(seconds: 2));
    await tester.pumpAndSettle();
  });
}

void homeSearchTest() {
  group('All home search test', () {
    testWidgets('Home search test', (tester) async {
      await LoginIntegrationTest.login(tester);
      expect(find.byType(Home), findsOneWidget);
      expect(find.byType(Login), findsNothing);
      expect(find.byType(ScaffoldDictionary), findsOneWidget);
      expect(find.byKey(Key('search_home')), findsOneWidget);
      expect(find.byKey(Key('words_grid')), findsOneWidget);
      await tester.enterText(find.byKey(Key('search_home')), 'adventure');
      await tester.pumpAndSettle();
      expect(find.byKey(Key('adventure_words')), findsOneWidget);
      await tester.tap(find.byKey(Key('adventure_words')));
      await tester.pumpAndSettle();
      expect(find.byType(Home), findsNothing);
      expect(find.byType(WordDetails), findsOneWidget);
    });

    testWidgets('home search test not found word', (tester) async {
      await LoginIntegrationTest.login(tester);
      expect(find.byType(Home), findsOneWidget);
      expect(find.byType(Login), findsNothing);
      expect(find.byType(ScaffoldDictionary), findsOneWidget);
      expect(find.byKey(Key('search_home')), findsOneWidget);
      expect(find.byKey(Key('words_grid')), findsOneWidget);
      await tester.enterText(find.byKey(Key('search_home')), 'adventure123');
      await tester.pumpAndSettle();
      expect(find.byKey(Key('adventure_words')), findsNothing);
    });
  });
}

void favoriteTest() {
  group('favorite test', () {
    testWidgets('Add favorite test', (tester) async {
      await LoginIntegrationTest.login(tester);
      expect(find.byType(Home), findsOneWidget);
      expect(find.byType(Login), findsNothing);
      expect(find.byType(ScaffoldDictionary), findsOneWidget);
      expect(find.byKey(Key('search_home')), findsOneWidget);
      expect(find.byKey(Key('words_grid')), findsOneWidget);
      await tester.enterText(find.byKey(Key('search_home')), 'adventure');
      await tester.pumpAndSettle();
      expect(find.byKey(Key('adventure_words')), findsOneWidget);
      HomeController homeController = Get.find<HomeController>();
      if (homeController.favoriteWords.contains('adventure')) {
        await Get.find<IDataBaseRepository>().removeFavoriteWord('adventure');
      }
      await tester.tap(find.byKey(Key('adventure_words')));
      await tester.pumpAndSettle();
      expect(find.byType(Home), findsNothing);
      expect(find.byType(WordDetails), findsOneWidget);
      await tester.tap(find.byKey(Key('favorite_button')));
      await tester.pumpAndSettle();
      expect(homeController.favoriteWords.contains('adventure'), true);
      await tester.tap(find.byKey(Key('close_button')));
      await tester.pumpAndSettle();
      expect(find.byType(Home), findsOneWidget);
      expect(find.byType(WordDetails), findsNothing);
      await tester.tap(find.byIcon(Icons.star_border));
      DateTime dateTime = DateTime.now();
      while (find.byKey(Key('adventure_favorite')).tryEvaluate() == false &&
          DateTime.now().difference(dateTime).inMinutes < 1) {
        await tester.drag(find.byKey(Key('words_grid')), const Offset(0, -500));
        await tester.pumpAndSettle();
      }
      expect(find.byKey(Key('adventure_favorite')), findsOneWidget);
      await Future.delayed(const Duration(seconds: 2));
      await tester.tap(find.byKey(Key('adventure_favorite')));
      await tester.pumpAndSettle();
      expect(find.byType(Home), findsNothing);
      expect(find.byType(WordDetails), findsOneWidget);
      await Future.delayed(Duration(seconds: 1));
      await tester.pumpAndSettle();
    });

    testWidgets('Remove favorite test', (tester) async {
      await LoginIntegrationTest.login(tester);
      expect(find.byType(Home), findsOneWidget);
      expect(find.byType(Login), findsNothing);
      expect(find.byType(ScaffoldDictionary), findsOneWidget);
      expect(find.byKey(Key('search_home')), findsOneWidget);
      expect(find.byKey(Key('words_grid')), findsOneWidget);
      await tester.enterText(find.byKey(Key('search_home')), 'adventure');
      await tester.pumpAndSettle();
      expect(find.byKey(Key('adventure_words')), findsOneWidget);
      HomeController homeController = Get.find<HomeController>();
      if (homeController.favoriteWords.contains('adventure') == false) {
        await Get.find<IDataBaseRepository>().addFavoriteWord('adventure');
      }
      await tester.tap(find.byKey(Key('adventure_words')));
      await tester.pumpAndSettle();
      expect(find.byType(Home), findsNothing);
      expect(find.byType(WordDetails), findsOneWidget);
      await tester.tap(find.byKey(Key('favorite_button')));
      await tester.pumpAndSettle();
      expect(homeController.favoriteWords.contains('adventure'), false);
      await tester.tap(find.byKey(Key('close_button')));
      await tester.pumpAndSettle();
      expect(find.byType(Home), findsOneWidget);
      expect(find.byType(WordDetails), findsNothing);
      await tester.tap(find.byIcon(Icons.star_border));
      expect(find.byKey(Key('adventure_favorite')), findsNothing);
      await tester.pumpAndSettle();
      await Future.delayed(Duration(seconds: 1));
    });
  });
}

void findWordHistory() {
  testWidgets('Find word in history test', (tester) async {
    await LoginIntegrationTest.login(tester);
    expect(find.byType(Home), findsOneWidget);
    expect(find.byType(Login), findsNothing);
    expect(find.byType(ScaffoldDictionary), findsOneWidget);
    expect(find.byKey(Key('search_home')), findsOneWidget);
    expect(find.byKey(Key('words_grid')), findsOneWidget);
    await tester.enterText(find.byKey(Key('search_home')), 'adventure');
    await tester.pumpAndSettle();
    expect(find.byKey(Key('adventure_words')), findsOneWidget);
    HomeController homeController = Get.find<HomeController>();
    await tester.tap(find.byKey(Key('adventure_words')));
    await tester.pumpAndSettle();
    expect(find.byType(Home), findsNothing);
    expect(find.byType(WordDetails), findsOneWidget);
    expect(homeController.historyWords.contains('adventure'), true);
    await tester.tap(find.byKey(Key('close_button')));
    await tester.pumpAndSettle();
    expect(find.byType(Home), findsOneWidget);
    expect(find.byType(WordDetails), findsNothing);
    await tester.tap(find.byIcon(Icons.history_rounded));
    await Future.delayed(Duration(seconds: 1));
    expect(find.byKey(Key('adventure_history')), findsOneWidget);
    await tester.pumpAndSettle();
    await Future.delayed(Duration(seconds: 1));
  });
}
