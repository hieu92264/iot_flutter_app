import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:iot_flutter_app/controllers/AuthController.dart';
import 'package:iot_flutter_app/screens/register.dart';
import 'package:iot_flutter_app/utils/text_utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final Authcontroller _authcontroller = Authcontroller();
  String loginStatus = '';
  bool rememberMe = false; // Biến để theo dõi trạng thái của checkbox
  bool isLoading = false; // Biến để quản lý trạng thái loading

  // Hàm để kiểm tra đầu vào
  String? validateInput() {
    if (_usernameController.text.isEmpty) {
      return "User name is required";
    }
    if (_passwordController.text.isEmpty) {
      return "Password is required";
    }
    return null; // Trả về null nếu hợp lệ
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
          height: 400,
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
                    const Spacer(),
                    Center(
                      child: TextUtil(
                        text: "Login",
                        weight: true,
                        size: 30,
                      ),
                    ),
                    const Spacer(),
                    TextUtil(text: "User name"),
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
                          border:
                              Border(bottom: BorderSide(color: Colors.white))),
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          suffixIcon: Icon(
                            Icons.lock,
                            color: Colors.white,
                          ),
                          fillColor: Colors.white,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const Spacer(),
                    // Row(
                    //   children: [
                    //     Checkbox(
                    //       value: rememberMe,
                    //       onChanged: (value) {
                    //         setState(() {
                    //           rememberMe = value!;
                    //         });
                    //       },
                    //       activeColor: Colors.white,
                    //       checkColor: Colors.black,
                    //     ),
                    //     const SizedBox(
                    //       width: 10,
                    //     ),
                    //     Expanded(
                    //       child: TextUtil(
                    //         text: "Remember Me , FORGET PASSWORD",
                    //         size: 12,
                    //         weight: true,
                    //       ),
                    //     )
                    //   ],
                    // ),
                    Row(
                      children: [
                        Checkbox(
                          value: rememberMe,
                          onChanged: (value) {
                            setState(() {
                              rememberMe = value!;
                            });
                          },
                          activeColor: Colors.white,
                          checkColor: Colors.black,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment
                                .spaceBetween, // Căn chỉnh hai phần tử
                            children: [
                              TextUtil(
                                text: "Remember Me, ",
                                size: 12,
                                weight: true,
                              ),
                              GestureDetector(
                                onTap: () {
                                  // Điều hướng tới màn hình quên mật khẩu
                                  Navigator.pushNamed(
                                      context, '/forgot_password');
                                },
                                child: TextUtil(
                                  text: "FORGET PASSWORD",
                                  size: 10,
                                  weight: true,
                                  // color: Colors
                                  //     .blue, // Thay đổi màu sắc cho dễ thấy
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const Spacer(),
                    if (isLoading) // Hiển thị loading nếu đang đăng nhập
                      Center(child: CircularProgressIndicator())
                    else
                      GestureDetector(
                        onTap: () async {
                          String? validationMessage = validateInput();
                          if (validationMessage != null) {
                            setState(() {
                              loginStatus =
                                  validationMessage; // Hiển thị thông báo lỗi
                            });
                            return; // Dừng hàm nếu đầu vào không hợp lệ
                          }

                          setState(() {
                            isLoading = true; // Bắt đầu loading
                            loginStatus = ''; // Xóa thông báo trước đó
                          });

                          // Giả lập quá trình đăng nhập với độ trễ
                          await Future.delayed(const Duration(
                              seconds: 2)); // Giả lập 2 giây loading

                          setState(() {
                            isLoading = false; // Kết thúc loading
                            loginStatus =
                                'Login successful'; // Hoặc xử lý thông báo khác
                          });
                          // String username = _usernameController.text;
                          // String password = _passwordController.text;

                          Navigator.pushReplacementNamed(context, '/home');

                          // String result = await _authcontroller.doLogin(
                          //     username, password, context);

                          // setState(() {
                          //   // loginStatus =
                          //   //     result; // Cập nhật thông báo sau khi đăng nhập
                          //   isLoading = false; // Kết thúc loading
                          // });
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
                            text: "Log In",
                            color: Colors.black,
                          ),
                        ),
                      ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          child: TextUtil(
                            text: "Don't have an account ?   ",
                            size: 12,
                            weight: true,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/register');
                          },
                          child: TextUtil(
                            text: "REGISTER",
                            size: 12,
                            weight: true,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    if (loginStatus.isNotEmpty)
                      Center(
                        child: Text(
                          loginStatus,
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
