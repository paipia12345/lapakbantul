// login_google.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'user_data.dart';
import 'package:buyayak/pages/home_page.dart';
import 'package:buyayak/pages/halamandaftar.dart'; // Pastikan import halaman daftar kamu

class LoginGoogleService {
  static Future<void> prosesLoginGoogle(
    BuildContext context,
    Function(String, Color) showMessage,
  ) async {
    showMessage("Menghubungkan ke Google...", Colors.blue);

    // Simulasi email dari Google Account
    String? googleEmail = UserData.registeredEmail;
    String? passwordOtomatis = (googleEmail == "eve.holt@reqres.in")
        ? "pistol"
        : "google_password_123";

    if (googleEmail == null || googleEmail.isEmpty) {
      showMessage(
        "Akun Google belum terdaftar! Silakan daftar dahulu.",
        Colors.orange,
      );

      await Future.delayed(const Duration(milliseconds: 1500));
      if (context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RegisterPage()),
        );
      }
      return;
    }

    // ALUR 2: Cek Login langsung ke Reqres menggunakan akun Google tersebut
    final urlLogin = Uri.parse('https://reqres.in/api/login');
    try {
      final logResponse = await http.post(
        urlLogin,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': googleEmail, 'password': passwordOtomatis}),
      );

      if (logResponse.statusCode == 200) {
        // Jika ternyata di server Reqres akun ini ada dan sukses login
        showMessage("Login Google Berhasil!", Colors.green);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } else {
        // ALUR 3: JIKA GAGAL LOGIN / BELUM TERDAFTAR (Muncul error dari Reqres)
        showMessage("Akun Google belum terdaftar di aplikasi!", Colors.orange);

        // Beri jeda 1.5 detik agar user sempat membaca pesan di atas, lalu lempar ke halaman daftar
        await Future.delayed(const Duration(milliseconds: 1500));

        if (context.mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RegisterPage()),
          );
        }
      }
    } catch (e) {
      // Jika terjadi kesalahan jaringan atau eror lainnya, amankan dengan melempar ke halaman daftar juga
      showMessage("Gagal terhubung, silakan daftar manual", Colors.red);

      if (context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RegisterPage()),
        );
      }
    }
  }
}
