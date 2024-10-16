// import 'dart:convert';
// import 'package:http/http.dart' as http;

// import 'package:crypto/crypto.dart';
// import 'package:flutter/material.dart';

// const String baseUrl = 'http://127.0.0.1:8000/api';

// class Authcontroller {
//   String encryptPassword(String password) {
//     var bytes = utf8.encode(password);
//     var digest = sha256.convert(bytes);
//     return digest.toString();
//   }

//   Future<String> doLogin(
//       String username, String password, BuildContext context) async {
//     String url = '{$baseUrl}/login';
//     String encryptedPassword = encryptPassword(password);
//     try {
//       var response = await http.post(
//         Uri.parse(url),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({
//           'username': username,
//           'password': encryptedPassword, // Gửi mật khẩu đã mã hóa
//         }),
//       );

//       if (response.statusCode == 200) {
//         return "success";
//       } else {
//         return 'Login failed. Please try again.';
//       }
//     } catch (error) {
//       return 'Error: $error';
//     }
//   }

//   Future<String> doRegister(
//       String username, String password, BuildContext context) async {
//     String url = '';
//     String encryptedPassword = encryptPassword(password);
//     try {
//       var response = await http.post(
//         Uri.parse(url),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({
//           'username': username,
//           'password': encryptedPassword, // Gửi mật khẩu đã mã hóa
//         }),
//       );

//       if (response.statusCode == 200) {
//         return "success";
//       } else {
//         return 'Login failed. Please try again.';
//       }
//     } catch (error) {
//       return 'Error: $error';
//     }
//   }
// }

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';

const String baseUrl = 'http://127.0.0.1:8000/api';

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
    String url = 'http://10.0.2.2:8000/api/login'; // Đặt URL đăng nhập
    // String url = 'http://192.168.0.100:8000/api/login'; // Đặt URL đăng nhập
    // String encryptedPassword = encryptPassword(password);

    print('Email: $email');
    print('Password: $password');

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

      print("end");

      print(response.statusCode);

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
  Future<String> doRegister(
      String username, String password, BuildContext context) async {
    String url = 'http://10.0.2.2/api/register'; // Đặt URL đăng ký
    String encryptedPassword = encryptPassword(password);

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'password': encryptedPassword, // Gửi mật khẩu đã mã hóa
        }),
      );

      if (response.statusCode == 200) {
        return "success";
      } else {
        return 'Registration failed. Please try again.';
      }
    } catch (error) {
      return 'Error: $error';
    }
  }
}
