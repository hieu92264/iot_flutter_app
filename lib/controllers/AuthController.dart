import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// const String baseUrl = 'http://10.0.2.2:8000/api';
const String baseUrl = 'http://192.168.1.47:8000/api';

class AuthController {
  // Mã hóa mật khẩu bằng SHA-256
  String encryptPassword(String password) {
    var bytes = utf8.encode(password);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  // Đăng nhập
  Future<String> doLogin(String email, String password, BuildContext context,
      {bool remember = false}) async {
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
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (remember) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('email', email);
          await prefs.setString('token', data['token']);
          print("Stored email: ${prefs.getString('email')}");
          print("Stored token: ${prefs.getString('token')}");
        }
        return "success";
      } else {
        return 'Login failed. Please try again.';
      }
    } catch (error) {
      return 'Error: $error';
    }
  }

  // Đăng ký
  Future<String> doRegister(String username, String email, String password,
      BuildContext context) async {
    String url = '$baseUrl/register'; // Đặt URL đăng ký
    // String encryptedPassword = encryptPassword(password);
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
      if (response.statusCode == 201) {
        return "success";
      } else {
        return 'Registration failed. Please try again.';
      }
    } catch (error) {
      return 'Error: $error';
    }
  }

  // Đăng xuất
  Future<String> doLogout(BuildContext context) async {
    String url = '$baseUrl/logout'; // Đặt URL đăng xuất
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token =
          prefs.getString('token'); // Lấy token từ SharedPreferences

      if (token == null) {
        return 'success';
      }

      var response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Thêm token vào header
        },
      );

      if (response.statusCode == 200) {
        // Xóa thông tin từ SharedPreferences
        await prefs.remove('email');
        await prefs.remove('token');
        return "success";
      } else {
        return 'Logout failed. Please try again.';
      }
    } catch (error) {
      return 'Error: $error';
    }
  }

  // Quên mật khẩu
  Future<String> doForgotPassword(String email, BuildContext context) async {
    String url = '$baseUrl/forgot-password'; // Đặt URL quên mật khẩu
    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
        }),
      );

      if (response.statusCode == 200) {
        return 'New password sent to your email.';
      } else {
        return 'Failed to send reset email. Please try again.';
      }
    } catch (error) {
      return 'Error: $error';
    }
  }
}
