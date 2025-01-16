import 'package:dic/src/application/controllers/home_controller.dart';
import 'package:dic/src/application/controllers/word_details_controller.dart';
import 'package:dic/src/domain/providers/i_http.dart';
import 'package:dic/src/domain/repositories/i_data_base_repository.dart';
import 'package:dic/src/infra/providers/http/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';

import '../../infra/respositories/fire_base_repository_mock.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  FireBaseRepositoryMock fireBaseRepositoryMock = FireBaseRepositoryMock();
  Get.lazyPut<IDataBaseRepository>(() => fireBaseRepositoryMock);
  Get.lazyPut<IHttp>(() => DioHttp());
  Get.put(HomeController());
  WordDetailsController wordDetailsController = WordDetailsController();
  when(() => fireBaseRepositoryMock.addHistoryWord(any()))
      .thenAnswer((_) async => null);
  when(() => fireBaseRepositoryMock.addFavoriteWord(any()))
      .thenAnswer((_) async {
    wordDetailsController.homeController.favoriteWords
        .add(wordDetailsController.word);
    return null;
  });
  when(() => fireBaseRepositoryMock.removeFavoriteWord(any()))
      .thenAnswer((_) async {
    wordDetailsController.homeController.favoriteWords
        .remove(wordDetailsController.word);
    return null;
  });
  test('Test wordDetailsController.init', () async {
    expect(wordDetailsController.loading.value, equals(false));
    expect(wordDetailsController.word, equals(''));
    expect(wordDetailsController.wordDetails, equals(null));
    expect(wordDetailsController.isPlaying.value, equals(false));
  });

  test('Test wordDetailsController.getWordDetails', () async {
    wordDetailsController.word = 'car';
    await wordDetailsController.getWordDetails();
    expect(wordDetailsController.loading.value, equals(false));
    expect(wordDetailsController.wordDetails, equals(null));
    verify(() => fireBaseRepositoryMock.addHistoryWord('car')).called(1);
  });

  test('Test wordDetailsController.nextWord', () async {
    wordDetailsController.homeController.words.clear();
    wordDetailsController.homeController.words.addAll(['car', 'dog', 'cat']);
    wordDetailsController.word = 'car';
    wordDetailsController.nextWord();
    expect(wordDetailsController.word, equals('dog'));
    verify(() => fireBaseRepositoryMock.addHistoryWord('dog')).called(1);
    wordDetailsController.nextWord();
    expect(wordDetailsController.word, equals('cat'));
    verify(() => fireBaseRepositoryMock.addHistoryWord('cat')).called(1);
  });

  test('Test wordDetailsController.backWord', () async {
    wordDetailsController.homeController.words.clear();
    wordDetailsController.homeController.words.addAll(['car', 'dog', 'cat']);
    wordDetailsController.word = 'cat';
    wordDetailsController.backWord();
    expect(wordDetailsController.word, equals('dog'));
    verify(() => fireBaseRepositoryMock.addHistoryWord('dog')).called(1);
    wordDetailsController.backWord();
    expect(wordDetailsController.word, equals('car'));
    verify(() => fireBaseRepositoryMock.addHistoryWord('car')).called(1);
  });

  test('Test wordDetailsController.saveFavoriteWord', () async {
    wordDetailsController.word = 'car';
    wordDetailsController.homeController.favoriteWords.clear();
    await wordDetailsController.saveFavoriteWord();
    verify(() => fireBaseRepositoryMock.addFavoriteWord('car')).called(1);
    expect(wordDetailsController.homeController.favoriteWords.contains('car'),
        equals(true));
    wordDetailsController.word = 'dog';
    await wordDetailsController.saveFavoriteWord();
    verify(() => fireBaseRepositoryMock.addFavoriteWord('dog')).called(1);
    expect(wordDetailsController.homeController.favoriteWords.contains('dog'),
        equals(true));
    wordDetailsController.word = 'cat';
    await wordDetailsController.saveFavoriteWord();
    verify(() => fireBaseRepositoryMock.addFavoriteWord('cat')).called(1);
    expect(wordDetailsController.homeController.favoriteWords.contains('cat'),
        equals(true));
    wordDetailsController.word = 'car';
    await wordDetailsController.saveFavoriteWord();
    verify(() => fireBaseRepositoryMock.removeFavoriteWord('car')).called(1);
    expect(wordDetailsController.homeController.favoriteWords.contains('car'),
        equals(false));
    wordDetailsController.word = 'dog';
    await wordDetailsController.saveFavoriteWord();
    verify(() => fireBaseRepositoryMock.removeFavoriteWord('dog')).called(1);
    expect(wordDetailsController.homeController.favoriteWords.contains('dog'),
        equals(false));
    wordDetailsController.word = 'cat';
    await wordDetailsController.saveFavoriteWord();
    verify(() => fireBaseRepositoryMock.removeFavoriteWord('cat')).called(1);
    expect(wordDetailsController.homeController.favoriteWords.contains('cat'),
        equals(false));
  });
}
