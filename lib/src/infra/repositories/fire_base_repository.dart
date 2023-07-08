import 'package:dictionary/src/domain/repositories/i_data_base_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class FireBaseRepository implements IDataBaseRepository {
  UserCredential? user;

  @override
  Future login(String login, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: login, password: password);
      user = credential;
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      } else {
        return e.message;
      }
    }
  }

  @override
  Future<void> init() async {
    await Firebase.initializeApp();
  }
}
