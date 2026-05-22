import 'package:flutter/material.dart';
import 'home_page.dart';
import 'halamandaftar.dart';
import 'models/user_data.dart';
import 'package:buyayak/models/login_google.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>(); // Tambah form key
  final TextEditingController emailController = TextEditingController(); // Diubah dari phone agar sesuai input email
  final TextEditingController passwordController = TextEditingController();

  bool isPasswordHidden = true;

  void showMessage(String msg, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: color,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView( // Tambahan agar tidak overflow saat keyboard muncul
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey, // Bungkus dengan Form widget
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),

                  Center(
                    child: Icon(Icons.lock, size: 100, color: Colors.blue),
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    "Login",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 5),

                  const Text(
                    "Please Login to continue.",
                    style: TextStyle(color: Colors.grey),
                  ),

                  const SizedBox(height: 25),

                  // Input nomor / email dengan validasi
                  TextFormField(
                     controller: emailController,
                     keyboardType: TextInputType.emailAddress,
                     validator: (value) {
                       if (value == null || value.isEmpty) return 'Email tidak boleh kosong';
                       if (!value.contains('@')) return 'Email harus ada @';
                       return null;
                     },
                     decoration: InputDecoration(
                       hintText: "Masukkan Email",
                       prefixIcon: const Icon(Icons.email),
                       filled: true,
                       fillColor: Colors.grey[200],
                       border: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(12),
                         borderSide: BorderSide.none,
                       ),
                     ),
                   ),

                  const SizedBox(height: 15),

                  // Input password dengan validasi
                  TextFormField(
                    controller: passwordController,
                    obscureText: isPasswordHidden,
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Password tidak boleh kosong';
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Password",
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(isPasswordHidden
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: () {
                          setState(() {
                            isPasswordHidden = !isPasswordHidden;
                          });
                        },
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text("Forgot Password?"),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // LOGIN BUTTON (Dengan validasi kecocokan data)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        // Validasi format form terlebih dahulu
                        if (_formKey.currentState!.validate()) {
                          String inputEmail = emailController.text.trim();
                          String inputPassword = passwordController.text;

                          // Cek apakah data input COCOK dengan data di UserData (pendaftaran)
                          if (inputEmail == UserData.registeredEmail && 
                              inputPassword == UserData.registeredPassword) {
                            
                            showMessage("Login Berhasil!", Colors.green);
                            
                            // Jika cocok, pindah ke home_page.dart
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const HomePage()),
                            );
                          } else {
                            // Jika tidak cocok atau belum daftar
                            showMessage("Akun tidak valid atau belum terdaftar!", Colors.red);
                          }
                        }
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  const Center(
                    child: Text("Don't have an account?"),
                  ),

                  const SizedBox(height: 10),

                  // DAFTAR BUTTON (Pindah ke Register Page)
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        side: const BorderSide(color: Colors.black),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        // Berpindah ke halaman pendaftaran
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const RegisterPage()),
                        );
                      },
                      child: const Text("Daftar"),
                    ),
                  ),

                  const SizedBox(height: 15),

                  SizedBox(
  width: double.infinity,
  child: OutlinedButton.icon(
    style: OutlinedButton.styleFrom(
      padding: const EdgeInsets.symmetric(vertical: 12),
      side: const BorderSide(color: Color.fromARGB(255, 77, 77, 77)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    onPressed: () {
      // Panggil fungsi dari file login_google.dart yang dipisah tadi
      LoginGoogleService.prosesLoginGoogle(context, showMessage);
    },
    icon: Image.asset(
      'assets/images/google.jpg',
      height: 24,
    ),
    label: const Text(
      "Masuk dengan Google",
      style: TextStyle(color: Color.fromARGB(255, 48, 45, 45), fontSize: 16, fontWeight: FontWeight.bold),
    ),
  ),
),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}