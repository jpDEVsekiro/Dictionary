import 'package:dic/src/ui/pages/home/home.dart';
import 'package:dic/src/ui/pages/login/login.dart';
import 'package:dic/src/ui/pages/word_details/word_details.dart';
import 'package:dic/src/ui/widgets/scaffold_dictionary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'login_integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testPlayAudio();
  testNextBackWord();
}

void testPlayAudio() {
  testWidgets('Play audio test', (tester) async {
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
    expect(find.byKey(Key('play_audio')), findsOneWidget);
    expect(find.byKey(Key('word_card')), findsOneWidget);
    expect(find.byKey(Key('back_word_button')), findsOneWidget);
    expect(find.byKey(Key('next_word_button')), findsOneWidget);

    await tester.tap(find.byKey(Key('play_audio')));
    await Future.delayed(Duration(seconds: 2));
  });
}

void testNextBackWord() {
  group('Test back and next button', () {
    testWidgets('Next word test', (tester) async {
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
      expect(find.byKey(Key('play_audio')), findsOneWidget);
      expect(find.byKey(Key('word_card')), findsOneWidget);
      expect(find.byKey(Key('back_word_button')), findsOneWidget);
      expect(find.byKey(Key('next_word_button')), findsOneWidget);
      await Future.delayed(Duration(seconds: 1));
      for (int i = 0; i < 5; i++) {
        await tester.tap(find.byKey(Key('next_word_button')));
        await tester.pumpAndSettle();
        await Future.delayed(Duration(seconds: 1));
        await tester.pumpAndSettle();
        expect(find.byKey(Key('play_audio')), findsOneWidget);
        expect(find.byKey(Key('word_card')), findsOneWidget);
        expect(find.byKey(Key('back_word_button')), findsOneWidget);
        expect(find.byKey(Key('next_word_button')), findsOneWidget);
      }
    });
    testWidgets('Back word test', (tester) async {
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
      expect(find.byKey(Key('play_audio')), findsOneWidget);
      expect(find.byKey(Key('word_card')), findsOneWidget);
      expect(find.byKey(Key('back_word_button')), findsOneWidget);
      expect(find.byKey(Key('next_word_button')), findsOneWidget);
      await Future.delayed(Duration(seconds: 1));
      for (int i = 0; i < 5; i++) {
        await tester.tap(find.byKey(Key('back_word_button')));
        await tester.pumpAndSettle();
        await Future.delayed(Duration(seconds: 1));
        await tester.pumpAndSettle();
        expect(find.byKey(Key('play_audio')), findsOneWidget);
        expect(find.byKey(Key('word_card')), findsOneWidget);
        expect(find.byKey(Key('back_word_button')), findsOneWidget);
        expect(find.byKey(Key('next_word_button')), findsOneWidget);
      }
    });
  });
}
