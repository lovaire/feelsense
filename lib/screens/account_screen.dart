import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';

class AccountScreen extends StatelessWidget {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    UserModel? currentUser = _authService.getCurrentUser (); // Mendapatkan pengguna saat ini

    return Scaffold(
      appBar: AppBar(title: Text('Account')),
      body: Center(
        child: currentUser != null ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Username: ${currentUser .username}'),
            Text('Email: ${currentUser .email}'),
            ElevatedButton(
              onPressed: () async {
                await _authService.signOut();
                // Anda mungkin ingin mengarahkan pengguna kembali ke layar login setelah keluar
                Navigator.of(context).pop(); // Kembali ke layar sebelumnya
              },
              child: Text('Sign Out'),
            ),
          ],
        ) : Text('No user is currently signed in.'),
      ),
    );
  }
}