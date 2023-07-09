import 'dart:convert';

import 'package:dictionary/src/application/bindings/word_details_binding.dart';
import 'package:dictionary/src/domain/models/word.dart';
import 'package:dictionary/src/domain/repositories/i_data_base_repository.dart';
import 'package:dictionary/src/ui/pages/word/word_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class HomeController extends GetxController {
  final List<String> words = <String>[];
  final List<String> historyWords = <String>[];
  final RxList<String> favoriteWords = <String>[].obs;
  final RxList<String> wordsFilter = <String>[].obs;
  final PagingController pagingController = PagingController(firstPageKey: 0);
  final List<Map<String, Word?>> cachedWords = <Map<String, Word?>>[];
  final int take = 200;
  int tabNum = 0;
  int skip = 0;
  final TextEditingController searchController = TextEditingController();
  final IDataBaseRepository _dataBaseRepository =
      Get.find<IDataBaseRepository>();

  @override
  void onInit() async {
    await getWords();
    _dataBaseRepository
        .listenHistoryFavoriteWords((favoritesWord, historyWord) {
      historyWords.clear();
      historyWords.addAll(historyWord);
      favoriteWords.clear();
      favoriteWords.addAll(favoritesWord);
    });
    skip = 0;
    addPaging();
    pagingController.addPageRequestListener((pageKey) {
      addPaging();
    });
    super.onInit();
  }

  getWords() async {
    final String response =
        await rootBundle.loadString('assets/json/words.json');
    final Map<String, dynamic> json = jsonDecode(response);
    words.addAll(json.keys.toList());
    wordsFilter.addAll(words);
  }

  addPaging() async {
    if (skip + take >= wordsFilter.length) {
      pagingController.appendLastPage(wordsFilter.sublist(skip));
    } else {
      pagingController.appendPage(wordsFilter.sublist(skip, skip + take), take);
      skip += take;
    }
  }

  void navigateWord(String word) {
    FocusScope.of(Get.context!).requestFocus(FocusNode());
    Get.to(() => const WordDetails(),
        arguments: {'word': word}, binding: WordDetailsBinding());
  }

  void search(String value) {
    wordsFilter.clear();
    if (tabNum == 0) {
      wordsFilter.addAll(words.where((element) => element.startsWith(value)));
    } else if (tabNum == 1) {
      wordsFilter
          .addAll(favoriteWords.where((element) => element.startsWith(value)));
    } else if (tabNum == 2) {
      wordsFilter
          .addAll(historyWords.where((element) => element.startsWith(value)));
    }
    skip = 0;
    pagingController.refresh();
  }

  void clearSearch() {
    FocusScope.of(Get.context!).requestFocus(FocusNode());
    searchController.clear();
    search('');
  }

  changeWords(int selectTabNum) {
    tabNum = selectTabNum;
    clearSearch();
  }
}
