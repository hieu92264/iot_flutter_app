import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';

const String baseUrl = 'http://10.0.2.2:8000/api';
// const String baseUrl = 'http://127.0.0.1:8000/api';
class AuthController {
  // Mã hóa mật khẩu bằng SHA-256
  String encryptPassword(String password) {
    var bytes = utf8.encode(password);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }
  // Đăng nhập
  Future<String> doLogin(
      String email, String password, BuildContext context) async {
    String url = '$baseUrl/login'; // Đặt URL đăng nhập
    print(url);
    try {
      print("start");
      var response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password, // Gửi mật khẩu đã mã hóa
        }),
      );
      if (response.statusCode == 200) {
        return "success";
      } else {
        return 'Login failed. Please try again.';
      }
    } catch (error) {
      return 'Error: $error';
    }
  }

  // Đăng ký
  Future<String> doRegister(String username, String email, String password, BuildContext context) async {
    String url = '$baseUrl/register'; // Đặt URL đăng ký
    print(username);
    print(email);
    print(password);

    String encryptedPassword = encryptPassword(password);
    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': username,
          'email': email,
          'password': password, // Gửi mật khẩu đã mã hóa
        }),
      );
      print("end");
      print(response.body);
      if (response.statusCode == 201) {
        return "success";
      } else {
        return 'Registration failed. Please try again.';
      }
    } catch (error) {
      return 'Error: $error';
    }
  }
}
