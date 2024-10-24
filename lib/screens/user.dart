import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:iot_flutter_app/components/base_screen.dart';
import 'package:iot_flutter_app/controllers/AuthController.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _verificationCodeController =
      TextEditingController();
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isOldPasswordVisible = false;
  bool _isNewPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: "User",
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.jpeg'),
              fit: BoxFit.fill,
            ),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white), // Thêm viền trắng
                borderRadius: BorderRadius.circular(15), // Thêm bo góc
                color: Colors.black.withOpacity(0.1), // Màu nền trong suốt
              ),
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(15), // Áp dụng bo góc cho hiệu ứng mờ
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5), // Hiệu ứng mờ
                  child: Padding(
                    padding: const EdgeInsets.all(25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "USER",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        const SizedBox(height: 30),
                        const Text(
                          "Change Password",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        const SizedBox(height: 20),
                        Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: _emailController,
                                    style: const TextStyle(color: Colors.white),
                                    decoration: const InputDecoration(
                                      labelText: 'Email',
                                      labelStyle:
                                          TextStyle(color: Colors.white),
                                      suffixIcon:
                                          Icon(Icons.mail, color: Colors.white),
                                      border: UnderlineInputBorder(),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                ElevatedButton(
                                  onPressed: _sendVerificationCode,
                                  child: const Text('Send Code'),
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              controller: _verificationCodeController,
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                labelText: 'Verification Code',
                                labelStyle: TextStyle(color: Colors.white),
                                suffixIcon:
                                    Icon(Icons.code, color: Colors.white),
                                border: UnderlineInputBorder(),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              controller: _oldPasswordController,
                              obscureText: !_isOldPasswordVisible,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                labelText: 'Old Password',
                                labelStyle:
                                    const TextStyle(color: Colors.white),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isOldPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isOldPasswordVisible =
                                          !_isOldPasswordVisible;
                                    });
                                  },
                                ),
                                border: const UnderlineInputBorder(),
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              controller: _newPasswordController,
                              obscureText: !_isNewPasswordVisible,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                labelText: 'New Password',
                                labelStyle:
                                    const TextStyle(color: Colors.white),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isNewPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isNewPasswordVisible =
                                          !_isNewPasswordVisible;
                                    });
                                  },
                                ),
                                border: const UnderlineInputBorder(),
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              controller: _confirmPasswordController,
                              obscureText: !_isConfirmPasswordVisible,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                labelText: 'Confirm Password',
                                labelStyle:
                                    const TextStyle(color: Colors.white),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isConfirmPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isConfirmPasswordVisible =
                                          !_isConfirmPasswordVisible;
                                    });
                                  },
                                ),
                                border: const UnderlineInputBorder(),
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: _changePassword, // Thay đổi mật khẩu
                          child: const Text('Change Password'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 80, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // OutlinedButton(
                        //   onPressed: () {
                        //     // Logic to log out
                        //   },
                        //   child: const Text('Log Out'),
                        //   style: OutlinedButton.styleFrom(
                        //     padding: const EdgeInsets.symmetric(
                        //         horizontal: 60, vertical: 15),
                        //     shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(30),
                        //     ),
                        //   ),
                        // ),
                        ElevatedButton(
                          onPressed: () =>
                              _doLogout(context), // Thay đổi mật khẩu
                          child: const Text('Log out'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 80, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Send verification code
  void _sendVerificationCode() {
    String email = _emailController.text.trim();
    if (email.isNotEmpty) {
      // Logic to send verification code to email
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Verification code sent to $email')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid email')),
      );
    }
  }

  // Change password
  void _changePassword() {
    // Logic to change the password
    String newPassword = _newPasswordController.text.trim();
    String confirmPassword = _confirmPasswordController.text.trim();

    if (newPassword == confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password changed successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
    }
  }
}

void _doLogout(BuildContext context) async {
  final AuthController authController =
      AuthController(); // Khởi tạo AuthController
  String response =
      await authController.doLogout(context); // Gọi phương thức doLogout
  if (response == "success") {
    Navigator.pushReplacementNamed(
        context, '/'); // Chuyển hướng về trang đăng nhập
  } else {
    // Xử lý thông báo lỗi nếu cần
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(response)), // Hiển thị thông báo
    );
  }
}
