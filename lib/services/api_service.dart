import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<Map<String, String>?> login(String username, String password) async {
    // final url = Uri.parse('$baseUrl/login');
    final url = Uri.parse('http://0.0.0.0:8080/login');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return {
        'accessToken': data['accessToken'],
        'refreshToken': data['refreshToken'],
      };
    } else {
      return null;
    }
  }

  Future<bool> createUser(String username, String password) async {
    final url = Uri.parse('$baseUrl/user');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    return response.statusCode == 201;
  }
}