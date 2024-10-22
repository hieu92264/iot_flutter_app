import 'dart:ui';
import 'package:flutter/material.dart';

class UserNguoiDung extends StatefulWidget {
  const UserNguoiDung({super.key});

  @override
  State<UserNguoiDung> createState() => _UserNguoiDungState();
}

class _UserNguoiDungState extends State<UserNguoiDung> {
  String email = 'nguyenvana@gmail.com';
  String phoneNumber = '+84 123 456 789';
  String address = 'Hà Nội, Việt Nam';
  String userName = 'Nguyễn Văn A';
  String userRole = 'Khách hàng';

  final TextEditingController _verificationCodeController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool isChangePasswordVisible = false; // Trạng thái hiển thị container đổi mật khẩu
  bool isCodeSent = false; // Trạng thái gửi mã xác nhận
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  // Hàm giả lập gửi mã xác nhận qua email
  void _sendVerificationCode() {
    setState(() {
      isCodeSent = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Mã xác nhận đã được gửi đến email $email')),
    );
  }

  // Hàm xử lý nút "Đổi mật khẩu"
  void _toggleChangePassword() {
    setState(() {
      isChangePasswordVisible = !isChangePasswordVisible;
      isCodeSent = false; // Reset trạng thái khi đóng/mở container
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 450, // Điều chỉnh chiều cao cho vừa nội dung
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
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Padding(
                      padding: const EdgeInsets.all(25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'THÔNG TIN TÀI KHOẢN',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Column(
                            children: [
                              Text(
                                userName,
                                style: TextStyle(fontSize: 20, color: Colors.white),
                              ),
                              const SizedBox(height: 10),
                              CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.blue.shade100,
                                child: Icon(Icons.person, size: 40, color: Colors.blue),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                userRole,
                                style: TextStyle(fontSize: 16, color: Colors.white70),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Icon(Icons.email, color: Colors.white70),
                              const SizedBox(width: 10),
                              Text(
                                email,
                                style: TextStyle(color: Colors.white, fontSize: 16),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(Icons.phone, color: Colors.white70),
                              const SizedBox(width: 10),
                              Text(
                                phoneNumber,
                                style: TextStyle(color: Colors.white, fontSize: 16),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(Icons.location_on, color: Colors.white70),
                              const SizedBox(width: 10),
                              Text(
                                address,
                                style: TextStyle(color: Colors.white, fontSize: 16),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: _toggleChangePassword,
                            child: Text(isChangePasswordVisible
                                ? 'Hủy đổi mật khẩu'
                                : 'Đổi mật khẩu'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              if (isChangePasswordVisible)
                Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.black.withOpacity(0.1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: isCodeSent ? null : _sendVerificationCode,
                            child: Text(isCodeSent ? 'Đã gửi' : 'Gửi mã'),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              controller: _verificationCodeController,
                              decoration: InputDecoration(
                                labelText: 'Nhập mã xác nhận',
                                prefixIcon: Icon(Icons.verified_user, color: Colors.white),
                                labelStyle: TextStyle(color: Colors.white),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      // New Password
                      TextField(
                        controller: _newPasswordController,
                        obscureText: _obscureNewPassword,
                        decoration: InputDecoration(
                          labelText: 'Nhập mật khẩu mới',
                          prefixIcon: Icon(Icons.lock, color: Colors.white),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureNewPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureNewPassword = !_obscureNewPassword;
                              });
                            },
                          ),
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 10),
                      // Confirm Password
                      TextField(
                        controller: _confirmPasswordController,
                        obscureText: _obscureConfirmPassword,
                        decoration: InputDecoration(
                          labelText: 'Xác nhận mật khẩu mới',
                          prefixIcon: Icon(Icons.lock, color: Colors.white),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureConfirmPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureConfirmPassword = !_obscureConfirmPassword;
                              });
                            },
                          ),
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 20),
                      // Confirm Button
                      ElevatedButton(
                        onPressed: () {
                          if (_newPasswordController.text == _confirmPasswordController.text) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Mật khẩu đã được đổi thành công!'),
                              ),
                            );
                            setState(() {
                              isChangePasswordVisible = false;
                              isCodeSent = false; // Reset state after success
                            });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Mật khẩu không khớp!')),
                            );
                          }
                        },
                        child: const Text('Xác nhận'),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
