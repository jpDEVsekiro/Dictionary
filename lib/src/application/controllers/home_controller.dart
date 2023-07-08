import 'dart:convert';

import 'package:dictionary/src/application/bindings/word_details_binding.dart';
import 'package:dictionary/src/domain/models/word.dart';
import 'package:dictionary/src/ui/pages/word/word_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class HomeController extends GetxController {
  final List<String> words = <String>[];
  final RxList<String> wordsSearch = <String>[].obs;
  final PagingController pagingController = PagingController(firstPageKey: 0);
  final List<Word> cachedWords = <Word>[];
  final int take = 200;
  int skip = 0;
  final TextEditingController searchController = TextEditingController();

  @override
  void onInit() async {
    await getWords();
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
    wordsSearch.addAll(words);
  }

  addPaging() async {
    if (skip + take >= wordsSearch.length) {
      pagingController.appendLastPage(wordsSearch.sublist(skip));
    } else {
      pagingController.appendPage(wordsSearch.sublist(skip, skip + take), take);
      skip += take;
    }
  }

  void navigateWord(String word) {
    FocusScope.of(Get.context!).requestFocus(FocusNode());
    Get.to(() => const WordDetails(),
        arguments: {'word': word}, binding: WordDetailsBinding());
  }

  void search(String value) {
    wordsSearch.clear();
    wordsSearch.addAll(words.where((element) => element.startsWith(value)));
    skip = 0;
    pagingController.refresh();
  }

  void clearSearch() {
    FocusScope.of(Get.context!).requestFocus(FocusNode());
    searchController.clear();
    search('');
  }
}
