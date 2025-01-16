import 'pages/create_account_integration_test.dart' as create_account_test;
import 'pages/home_integration_test.dart' as home_test;
import 'pages/login_integration_test.dart' as login_test;
import 'pages/word_details_integration_test.dart' as word_details_test;

void main() {
  login_test.main();
  create_account_test.main();
  home_test.main();
  word_details_test.main();
}
