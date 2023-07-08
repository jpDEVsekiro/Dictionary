abstract class IDataBaseRepository {
  Future<dynamic> login(String login, String password);
  Future<void> init();
}
