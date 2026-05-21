import 'package:flutter/material.dart';
import 'user_data.dart'; // Import simulasi database di atas
import 'halamanlogin.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingKey = GlobalKey<FormState>();
  
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();

  // Fungsi untuk memunculkan pesan snackbar di bawah layar
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
      backgroundColor: const Color(0xFFEFEFEF),
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.only(right: 50.0),
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: _formKey, // Pasang key form di sini
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Daftar',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2D2D2D),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Input: Number
                  // Input: Number dengan validasi angka dan panjang karakter
_buildTextField(
  controller: phoneController,
  hintText: 'Nomor',
  // Mengatur agar keyboard yang muncul hanya angka (opsional namun direkomendasikan)
  keyboardType: TextInputType.number, 
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Nomor tidak boleh kosong';
    }
    
    // Validasi 1: Memastikan input HANYA berisi angka (tidak boleh ada huruf/simbol)
    final numRegExp = RegExp(r'^[0-9]+$');
    if (!numRegExp.hasMatch(value)) {
      return 'Harus berisi nomor';
    }
    
    // Validasi 2: Memastikan panjang nomor harus tepat 10 digit
    if (value.length != 10) {
      return 'Nomor harus 10 digit'; // Jika ingin minimal 10 digit, ganti menjadi: value.length < 10
    }
    
    return null;
  },
),
                  const SizedBox(height: 16),

                  // Input: Email dengan validasi '@'
                  _buildTextField(
                    controller: emailController,
                    hintText: 'Email',
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Email tidak boleh kosong';
                      if (!value.contains('@')) return 'Email harus ada @';
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Input: Password dengan validasi minimal 6 huruf/karakter
                  _buildTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    isObscure: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Password tidak boleh kosong';
                      if (value.length < 6) return 'Password harus minimal 6 huruf';
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Input: Re-password
                  _buildTextField(
                    controller: rePasswordController,
                    hintText: 'Konfirmasi password',
                    isObscure: true,
                    validator: (value) {
                      if (value != passwordController.text) return 'Password tidak cocok';
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),

                  // Tombol DAFTAR (Biru Muda)
                  SizedBox(
                    width: 180,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Simpan data ke database lokal sementara
                          UserData.registeredEmail = emailController.text.trim();
                          UserData.registeredPassword = passwordController.text;
                          UserData.registeredPhone = phoneController.text;

                          showMessage("Kamu berhasil daftar!", Colors.green);

                          // Setelah berhasil daftar, langsung balik ke halaman login
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginPage()),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF63B3A6),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'DAFTAR',
                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Teks Log In
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Sudah punya akun? ', style: TextStyle(color: Color(0xFF2D2D2D), fontSize: 14)),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginPage()),
                          );
                        },
                        child: const Text(
                          'Log in',
                          style: TextStyle(color: Color(0xFF5A9E94), fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
  required TextEditingController controller,
  required String hintText,
  bool isObscure = false,
  TextInputType keyboardType = TextInputType.text, // <-- Tambahkan baris ini
  String? Function(String?)? validator,
}) {
  return TextFormField(
    controller: controller,
    obscureText: isObscure,
    keyboardType: keyboardType, // <-- Pasang di sini
    validator: validator,
    decoration: InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(color: Color(0xFF7E7E7E), fontSize: 14),
      filled: true,
      fillColor: const Color(0xFFE5E5E5),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      errorStyle: const TextStyle(height: 0.8),
    ),
  );
}
  
}
