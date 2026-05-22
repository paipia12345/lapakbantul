// login_google.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../pages/home_page.dart';

class LoginGoogleService {
  // Inisialisasi GoogleSignIn dan FirebaseAuth
  static final GoogleSignIn _googleSignIn = GoogleSignIn();
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<void> prosesLoginGoogle(
    BuildContext context,
    Function(String, Color) showMessage,
  ) async {
    try {
      showMessage("Menghubungkan ke Google...", Colors.blue);

      // 1. Munculkan pop-up pilihan akun Google di HP user
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        // Jika user membatalkan pilihan akun Google
        showMessage("Login dibatalkan oleh pengguna", Colors.orange);
        return;
      }

      // 2. Ambil detail autentikasi dari akun Google yang dipilih
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // 3. Buat kredensial baru untuk dikirim ke Firebase
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      showMessage("Menyelaraskan dengan Firebase...", Colors.blue);

      // 4. Masuk ke Firebase menggunakan kredensial Google
      // Alur Firebase otomatis: Jika email BELUM TERDAFTAR, Firebase akan otomatis membuatkan akun (Daftar).
      // Jika email SUDAH TERDAFTAR, Firebase akan langsung meloginkannya (Login).
      UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );
      User? user = userCredential.user;

      if (user != null) {
        // Mengecek apakah ini adalah user yang baru pertama kali mendaftar (New User)
        if (userCredential.additionalUserInfo?.isNewUser ?? false) {
          showMessage(
            "Akun Google berhasil didaftarkan secara otomatis!",
            Colors.green,
          );
        } else {
          showMessage("Login Google Berhasil!", Colors.green);
        }

        // Beri jeda sedikit agar snackbar terbaca, lalu pindah ke HomePage
        await Future.delayed(const Duration(milliseconds: 1000));

        if (context.mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        }
      }
    } on FirebaseAuthException catch (e) {
      // Menangkap eror spesifik dari Firebase
      showMessage("Firebase Error: ${e.message}", Colors.red);
    } catch (e) {
      // Menangkap eror jaringan atau eror lainnya
      showMessage("Gagal terhubung ke Google Sign-In", Colors.red);
      print("Detail Error Google SSO: $e");
    }
  }
}
