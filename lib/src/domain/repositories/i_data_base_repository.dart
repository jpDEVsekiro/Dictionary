abstract class IDataBaseRepository {
  Future<void> init();
  Future<dynamic> login(String login, String password);
  Future<dynamic> addFavoriteWord(String word);
  Future<dynamic> removeFavoriteWord(String word);
  Future<dynamic> addHistoryWord(String word);
  Future<dynamic> listenHistoryFavoriteWords(
      Function(List<String> favoritesWord, List<String> historyWord) onChanged);
}
