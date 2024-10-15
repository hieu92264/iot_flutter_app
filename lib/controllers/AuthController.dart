import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';

class Authcontroller {
  String encryptPassword(String password) {
    var bytes = utf8.encode(password);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<String> doLogin(
      String username, String password, BuildContext context) async {
    String url = '';
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
        return 'Login failed. Please try again.';
      }
    } catch (error) {
      return 'Error: $error';
    }
  }

  Future<String> doRegister(
      String username, String password, BuildContext context) async {
    String url = '';
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
        return 'Login failed. Please try again.';
      }
    } catch (error) {
      return 'Error: $error';
    }
  }
}
