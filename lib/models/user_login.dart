// Contoh logika kasarnya saat tombol LOGIN ditekan menggunakan REST API
import 'package:http/http.dart' as http;
import 'dart:convert'; // Untuk mengubah data ke JSON

Future<void> loginUser(String email, String password) async {
  final url = Uri.parse('https://api.domainkamu.com/login');
  
  final response = await http.post(
    url,
    body: jsonEncode({
      'email': email,
      'password': password,
    }),
    headers: {'Content-Type': 'application/json'},
  );

  if (response.statusCode == 200) {
    // Jika sukses, baca JSON respon dari server lalu pindah ke HomePage
    var data = jsonDecode(response.body);
    print("Token Login: ${data['token']}");
  } else {
    // Tampilkan snackbar eror dari server
  }
}