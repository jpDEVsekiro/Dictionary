import 'package:dictionary/src/application/controllers/home_controller.dart';
import 'package:dictionary/src/domain/models/method.dart';
import 'package:dictionary/src/domain/models/word.dart';
import 'package:dictionary/src/domain/providers/i_http.dart';
import 'package:dictionary/src/domain/repositories/i_data_base_repository.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';

class WordDetailsController extends GetxController {
  final RxBool loading = false.obs;
  String word = Get.arguments['word'];
  Word? wordDetails;
  FlutterTts flutterTts = FlutterTts();
  RxBool isPlaying = false.obs;
  final IDataBaseRepository _dataBaseRepository =
      Get.find<IDataBaseRepository>();

  @override
  void onInit() async {
    getWordDetails();
    super.onInit();
  }

  Future<void> getWordDetails() async {
    loading.value = true;
    await _dataBaseRepository.addHistoryWord(word);
    if (Get.find<HomeController>()
        .cachedWords
        .any((element) => element.word == word)) {
      wordDetails = Get.find<HomeController>()
          .cachedWords
          .firstWhere((element) => element.word == word);
    } else {
      dynamic result =
          await Get.find<IHttp>().request(url: word, method: Method.get);
      if (result != false) {
        wordDetails = Word.fromJson(result);
        Get.find<HomeController>().cachedWords.add(wordDetails!);
      }
    }
    loading.value = false;
  }

  void nextWord() {
    int index = Get.find<HomeController>().words.indexOf(word);
    if (index < Get.find<HomeController>().words.length - 1) {
      word = Get.find<HomeController>().words[index + 1];
    } else {
      word = Get.find<HomeController>().words.first;
    }
    wordDetails = null;
    getWordDetails();
  }

  void backWord() {
    int index = Get.find<HomeController>().words.indexOf(word);
    if (index > 0) {
      word = Get.find<HomeController>().words[index - 1];
    } else {
      word = Get.find<HomeController>().words.last;
    }
    wordDetails = null;
    getWordDetails();
  }

  playAudio() async {
    if (isPlaying.value) {
      await flutterTts.stop();
      isPlaying.value = false;
    } else {
      isPlaying.value = true;
      await flutterTts.speak(word);
      flutterTts.completionHandler = () {
        isPlaying.value = false;
      };
    }
  }

  Future<void> saveFavoriteWord() async {
    if (Get.find<HomeController>()
        .favoriteWords
        .any((element) => element == word)) {
      _dataBaseRepository.removeFavoriteWord(word);
    } else {
      _dataBaseRepository.addFavoriteWord(word);
    }
  }
}
