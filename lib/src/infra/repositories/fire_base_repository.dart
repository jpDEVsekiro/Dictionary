import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dictionary/src/domain/repositories/i_data_base_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class FireBaseRepository implements IDataBaseRepository {
  UserCredential? user;
  CollectionReference? dictionaryCollection;
  Stream? collectionStream;
  @override
  Future<dynamic> login(String login, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: login, password: password);
      user = credential;
      if (user == null || user!.user == null || dictionaryCollection == null) {
        return 'Internal Error';
      }
      collectionStream = dictionaryCollection!.doc(user!.user!.uid).snapshots();
      collectionStream?.listen((event) {
        print(event.data());
      });
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
    dictionaryCollection = FirebaseFirestore.instance.collection('UserWords');
  }

  @override
  Future<dynamic> addFavoriteWord(String word) async {
    if (user == null || user!.user == null || dictionaryCollection == null) {
      return 'User not logged in';
    } else {
      dictionaryCollection!.doc(user!.user!.uid).set({
        'favoriteWords': FieldValue.arrayUnion([word])
      }, SetOptions(merge: true));
    }
  }

  @override
  Future<dynamic> addHistoryWord(String word) async {
    if (user == null || user!.user == null || dictionaryCollection == null) {
      return 'User not logged in';
    } else {
      await _removeHistoryWord(word);
      dictionaryCollection!.doc(user!.user!.uid).set({
        'historyWord': FieldValue.arrayUnion([word])
      }, SetOptions(merge: true));
    }
  }

  @override
  Future<dynamic> getFavoriteWords() {
    // TODO: implement getFavoriteWords
    throw UnimplementedError();
  }

  @override
  Future<dynamic> getHistoryWords() {
    // TODO: implement getHistoryWords
    throw UnimplementedError();
  }

  @override
  Future removeFavoriteWord(String word) async {
    if (user == null || user!.user == null || dictionaryCollection == null) {
      return 'User not logged in';
    } else {
      dictionaryCollection!.doc(user!.user!.uid).set({
        'favoriteWords': FieldValue.arrayRemove([word])
      }, SetOptions(merge: true));
    }
  }

  Future _removeHistoryWord(String word) async {
    if (user == null || user!.user == null || dictionaryCollection == null) {
      return 'User not logged in';
    } else {
      dictionaryCollection!.doc(user!.user!.uid).set({
        'historyWord': FieldValue.arrayRemove([word])
      }, SetOptions(merge: true));
    }
  }
}
