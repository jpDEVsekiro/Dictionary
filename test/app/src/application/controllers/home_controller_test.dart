import 'package:dic/src/application/controllers/home_controller.dart';
import 'package:dic/src/domain/repositories/i_data_base_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import '../../infra/respositories/fire_base_repository_mock.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  FireBaseRepositoryMock fireBaseRepositoryMock = FireBaseRepositoryMock();
  Get.lazyPut<IDataBaseRepository>(() => fireBaseRepositoryMock);
  HomeController homeController = HomeController();
  test('Test homeController.init', () async {
    expect(homeController.words.length, equals(0));
    expect(homeController.historyWords.length, equals(0));
    expect(homeController.favoriteWords.length, equals(0));
    expect(homeController.wordsFilter.length, equals(0));
    expect(homeController.cachedWords.length, equals(0));
    expect(homeController.tabNum, equals(0));
    expect(homeController.skip, equals(0));
    expect(homeController.searchController.text, equals(''));
  });

  test('Test homeController.getWords', () async {
    await homeController.getWords();
    expect(homeController.words.length, equals(370101));
    expect(homeController.wordsFilter.length, equals(370101));
  });

  test('Test homeController.search', () async {
    homeController.words.clear();
    homeController.words.addAll(['test', 'test1', 'test2']);
    homeController.search('test');
    expect(homeController.wordsFilter.length, equals(3));
    homeController.search('test1');
    expect(homeController.wordsFilter.length, equals(1));
    homeController.search('test2');
    expect(homeController.wordsFilter.length, equals(1));
  });
}
