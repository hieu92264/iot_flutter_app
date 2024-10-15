import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:iot_flutter_app/utils/text_utils.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  String message = '';

  void sendPasswordResetEmail() {
    // Thêm logic gửi email đặt lại mật khẩu ở đây
    String email = _emailController.text;
    if (email.isEmpty) {
      setState(() {
        message = "Please enter your email";
      });
      return;
    }
    // Giả sử gửi thành công
    setState(() {
      message = "A password reset email has been sent to $email";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background.jpeg'),
              fit: BoxFit.fill),
        ),
        alignment: Alignment.center,
        child: Container(
          height: 300,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(15),
            color: Colors.black.withOpacity(0.1),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Nút Back nằm trong Container
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () {
                            Navigator.pop(context); // Quay lại trang trước
                          },
                        ),
                      ],
                    ),
                    const Spacer(),
                    Center(
                      child: TextUtil(
                        text: "Forgot Password",
                        weight: true,
                        size: 30,
                      ),
                    ),
                    const Spacer(),
                    TextUtil(text: "Email"),
                    Container(
                      height: 35,
                      decoration: const BoxDecoration(
                          border:
                          Border(bottom: BorderSide(color: Colors.white))),
                      child: TextFormField(
                        controller: _emailController,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          suffixIcon: Icon(
                            Icons.mail,
                            color: Colors.white,
                          ),
                          fillColor: Colors.white,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: sendPasswordResetEmail,
                      child: Container(
                        height: 40,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        alignment: Alignment.center,
                        child: TextUtil(
                          text: "Send Reset Email",
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const Spacer(),
                    if (message.isNotEmpty)
                      Center(
                        child: Text(
                          message,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
