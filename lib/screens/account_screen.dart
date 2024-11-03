import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Mendapatkan pengguna saat ini sebagai UserModel
  UserModel? getCurrentUser() {
    User? user = _firebaseAuth.currentUser;
    if (user != null) {
      return UserModel(
        username: user.displayName ?? 'Anonymous',
        email: user.email ?? 'No email',
        uid: '',
      );
    }
    return null;
  }

  // Metode untuk keluar dari akun
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
