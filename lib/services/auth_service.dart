import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  UserModel? _userFromFirebaseUser (User? user) {
    return user != null ? UserModel(uid: user.uid, email: user.email!, username: '') : null;
  }

  Future<UserModel?> signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return _userFromFirebaseUser (result.user);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<UserModel?> register(String email, String password, String username) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      await _firestore.collection('users').doc(result.user!.uid).set({
        'username': username,
        'email': email,
      });
      return _userFromFirebaseUser (result.user);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}