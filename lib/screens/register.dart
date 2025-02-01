import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:iot_flutter_app/controllers/AuthController.dart';
import 'package:iot_flutter_app/utils/text_utils.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameController =
      TextEditingController(); // Thêm biến cho User Name
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController =
      TextEditingController(); // Thêm biến cho Repeat Password
  final AuthController _authcontroller = AuthController();
  String registerStatus = '';
  // Thêm các biến trạng thái để theo dõi xem mật khẩu và mật khẩu lặp lại có được hiển thị hay không
  bool _isPasswordVisible = false;
  bool _isRepeatPasswordVisible = false;

  // Hàm kiểm tra đầu vào
  String? validateInput() {
    if (_usernameController.text.isEmpty) {
      return "User name is required";
    }
    if (_emailController.text.isEmpty) {
      return "Email is required";
    }
    if (_passwordController.text.isEmpty) {
      return "Password is required";
    }
    if (_repeatPasswordController.text.isEmpty) {
      return "Repeat Password is required";
    }
    if (_passwordController.text != _repeatPasswordController.text) {
      return "Passwords do not match"; // Kiểm tra xem mật khẩu có khớp không
    }
    return null; // Trả về null nếu tất cả hợp lệ
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
          height: 450, // Tăng chiều cao để đủ chứa các trường mới
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
                    // Nút Back nằm t rong Container
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () {
                            Navigator.pop(context); // Quay lại trang LoginScreen
                          },
                        ),
                      ],
                    ),
                    Center(
                      child: TextUtil(
                        text: "Register",
                        weight: true,
                        size: 30,
                      ),
                    ),
                    const Spacer(),
                    TextUtil(text: "User Name"), // Thêm tiêu đề cho User Name
                    Container(
                      height: 35,
                      decoration: const BoxDecoration(
                          border:
                          Border(bottom: BorderSide(color: Colors.white))),
                      child: TextFormField(
                        controller: _usernameController,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          suffixIcon: Icon(
                            Icons.person, // Biểu tượng cho User Name
                            color: Colors.white,
                          ),
                          fillColor: Colors.white,
                          border: InputBorder.none,
                        ),
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
                    TextUtil(text: "Password"),
                    Container(
                      height: 35,
                      decoration: const BoxDecoration(
                          border: Border(bottom: BorderSide(color: Colors.white))),
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: !_isPasswordVisible, // Ẩn mật khẩu khi _isPasswordVisible là false
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                          fillColor: Colors.white,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const Spacer(),
                    TextUtil(text: "Repeat Password"), // Thêm tiêu đề cho Repeat Password
                    Container(
                      height: 35,
                      decoration: const BoxDecoration(
                          border: Border(bottom: BorderSide(color: Colors.white))),
                      child: TextFormField(
                        controller: _repeatPasswordController,
                        obscureText: !_isRepeatPasswordVisible, // Ẩn mật khẩu khi _isRepeatPasswordVisible là false
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isRepeatPasswordVisible ? Icons.visibility : Icons.visibility_off,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                _isRepeatPasswordVisible = !_isRepeatPasswordVisible;
                              });
                            },
                          ),
                          fillColor: Colors.white,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () async {
                        String? validationMessage = validateInput();
                        if (validationMessage != null) {
                          setState(() {
                            registerStatus = validationMessage;
                          });
                          return;
                        }

                        String email = _emailController.text;
                        String password = _passwordController.text;
                        String username = _usernameController.text;
                        // Thêm logic để đăng ký tài khoản ở đây
                        String result = await _authcontroller.doRegister(username, email, password, context);
                        setState(() {
                          registerStatus = result;
                        });
                      },
                      child: Container(
                        height: 40,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        alignment: Alignment.center,
                        child: TextUtil(
                          text: "Register",
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const Spacer(),
                    if (registerStatus.isNotEmpty)
                      Center(
                        child: Text(
                          registerStatus,
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
