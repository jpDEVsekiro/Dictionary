import 'package:dic/src/application/controllers/home_controller.dart';
import 'package:dic/src/domain/models/method.dart';
import 'package:dic/src/domain/models/word.dart';
import 'package:dic/src/domain/providers/i_http.dart';
import 'package:dic/src/domain/repositories/i_data_base_repository.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';

class WordDetailsController extends GetxController {
  final RxBool loading = false.obs;
  String word = Get.arguments?['word'] ?? '';
  Word? wordDetails;
  FlutterTts flutterTts = FlutterTts();
  RxBool isPlaying = false.obs;
  final IDataBaseRepository _dataBaseRepository =
      Get.find<IDataBaseRepository>();
  final HomeController homeController = Get.find<HomeController>();
  final IHttp _http = Get.find<IHttp>();

  @override
  void onInit() {
    getWordDetails();
    super.onInit();
  }

  Future<void> getWordDetails() async {
    loading.value = true;
    await _dataBaseRepository.addHistoryWord(word);
    if (homeController.cachedWords
        .any((element) => element.keys.first == word)) {
      wordDetails = homeController.cachedWords
          .firstWhere((element) => element.keys.first == word)[word];
    } else {
      dynamic result = await _http.request(url: word, method: Method.get);
      if (result != false) {
        wordDetails = Word.fromJson(result);
        homeController.cachedWords.add({word: wordDetails});
      } else {
        homeController.cachedWords.add({word: null});
      }
    }
    loading.value = false;
  }

  void nextWord() {
    int index = homeController.words.indexOf(word);
    if (index < homeController.words.length - 1) {
      word = homeController.words[index + 1];
    } else {
      word = homeController.words.first;
    }
    wordDetails = null;
    getWordDetails();
  }

  void backWord() {
    int index = homeController.words.indexOf(word);
    if (index > 0) {
      word = homeController.words[index - 1];
    } else {
      word = homeController.words.last;
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
    if (homeController.favoriteWords.any((element) => element == word)) {
      _dataBaseRepository.removeFavoriteWord(word);
    } else {
      _dataBaseRepository.addFavoriteWord(word);
    }
  }
}
