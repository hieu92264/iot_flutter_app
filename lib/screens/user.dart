// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:iot_flutter_app/components/base_screen.dart';
// import 'package:iot_flutter_app/controllers/AuthController.dart';

// class UserProfile extends StatefulWidget {
//   const UserProfile({super.key});

//   @override
//   State<UserProfile> createState() => _UserProfileState();
// }

// class _UserProfileState extends State<UserProfile> {
//   String email = 'nguyenvana@gmail.com';
//   String phoneNumber = '+84 123 456 789';
//   String address = 'Hà Nội, Việt Nam';
//   String userName = 'Nguyễn Văn A';
//   String userRole = 'Khách hàng';

//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _verificationCodeController = TextEditingController();
//   final TextEditingController _oldPasswordController = TextEditingController();
//   final TextEditingController _newPasswordController = TextEditingController();
//   final TextEditingController _confirmPasswordController = TextEditingController();

//   bool _isOldPasswordVisible = false;
//   bool _isNewPasswordVisible = false;
//   bool _isConfirmPasswordVisible = false;
//   bool isChangePasswordVisible = false; // Toggle for showing password change form
//   bool isCodeSent = false; // Toggle for code sent status

//   // Function to simulate sending verification code
//   void _sendVerificationCode() {
//     setState(() {
//       isCodeSent = true;
//     });
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Verification code sent to $email')),
//     );
//   }

//   // Function to toggle password change form visibility
//   void _toggleChangePassword() {
//     setState(() {
//       isChangePasswordVisible = !isChangePasswordVisible;
//       isCodeSent = false; // Reset the code sent state
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BaseScreen(
//       title: "",
//       child: Scaffold(
//         body: Container(
//           height: double.infinity,
//           width: double.infinity,
//           decoration: const BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage('assets/images/background.jpeg'),
//               fit: BoxFit.fill,
//             ),
//           ),
//           alignment: Alignment.center,
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Container(
//                   height: 450, // Adjust the height for content
//                   width: double.infinity,
//                   margin: const EdgeInsets.symmetric(horizontal: 30),
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.white),
//                     borderRadius: BorderRadius.circular(15),
//                     color: Colors.black.withOpacity(0.1),
//                   ),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(20),
//                     child: BackdropFilter(
//                       filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
//                       child: Padding(
//                         padding: const EdgeInsets.all(25),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Text(
//                               'THÔNG TIN TÀI KHOẢN',
//                               style: TextStyle(
//                                 fontSize: 30,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                               ),
//                             ),
//                             const SizedBox(height: 20),
//                             Column(
//                               children: [
//                                 Text(
//                                   userName,
//                                   style: TextStyle(fontSize: 20, color: Colors.white),
//                                 ),
//                                 const SizedBox(height: 10),
//                                 CircleAvatar(
//                                   radius: 40,
//                                   backgroundColor: Colors.blue.shade100,
//                                   child: Icon(Icons.person, size: 40, color: Colors.blue),
//                                 ),
//                                 const SizedBox(height: 10),
//                                 Text(
//                                   userRole,
//                                   style: TextStyle(fontSize: 16, color: Colors.white70),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(height: 20),
//                             Row(
//                               children: [
//                                 Icon(Icons.email, color: Colors.white70),
//                                 const SizedBox(width: 10),
//                                 Text(
//                                   email,
//                                   style: TextStyle(color: Colors.white, fontSize: 16),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(height: 10),
//                             Row(
//                               children: [
//                                 Icon(Icons.phone, color: Colors.white70),
//                                 const SizedBox(width: 10),
//                                 Text(
//                                   phoneNumber,
//                                   style: TextStyle(color: Colors.white, fontSize: 16),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(height: 10),
//                             Row(
//                               children: [
//                                 Icon(Icons.location_on, color: Colors.white70),
//                                 const SizedBox(width: 10),
//                                 Text(
//                                   address,
//                                   style: TextStyle(color: Colors.white, fontSize: 16),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(height: 20),
//                             ElevatedButton(
//                               onPressed: _toggleChangePassword,
//                               child: Text(isChangePasswordVisible ? 'Hủy đổi mật khẩu' : 'Đổi mật khẩu'),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 if (isChangePasswordVisible)
//                   Container(
//                     padding: const EdgeInsets.all(20),
//                     margin: const EdgeInsets.symmetric(horizontal: 30),
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.white),
//                       borderRadius: BorderRadius.circular(15),
//                       color: Colors.black.withOpacity(0.1),
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         Row(
//                           children: [
//                             Expanded(
//                               child: TextFormField(
//                                 controller: _verificationCodeController,
//                                 style: const TextStyle(color: Colors.white),
//                                 decoration: InputDecoration(
//                                   labelText: 'Nhập mã xác nhận',
//                                   prefixIcon: Icon(Icons.verified_user, color: Colors.white),
//                                   labelStyle: TextStyle(color: Colors.white),
//                                   enabledBorder: UnderlineInputBorder(
//                                     borderSide: BorderSide(color: Colors.white),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(width: 10),
//                             ElevatedButton(
//                               onPressed: isCodeSent ? null : _sendVerificationCode,
//                               child: Text(isCodeSent ? 'Đã gửi' : 'Gửi mã'),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 10),
//                         TextFormField(
//                           controller: _oldPasswordController,
//                           obscureText: !_isOldPasswordVisible,
//                           style: const TextStyle(color: Colors.white),
//                           decoration: InputDecoration(
//                             labelText: 'Mật khẩu cũ',
//                             labelStyle: const TextStyle(color: Colors.white),
//                             prefixIcon: Icon(Icons.lock, color: Colors.white),
//                             suffixIcon: IconButton(
//                               icon: Icon(
//                                 _isOldPasswordVisible ? Icons.visibility : Icons.visibility_off,
//                                 color: Colors.white,
//                               ),
//                               onPressed: () {
//                                 setState(() {
//                                   _isOldPasswordVisible = !_isOldPasswordVisible;
//                                 });
//                               },
//                             ),
//                             enabledBorder: const UnderlineInputBorder(
//                               borderSide: BorderSide(color: Colors.white),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 10),
//                         TextFormField(
//                           controller: _newPasswordController,
//                           obscureText: !_isNewPasswordVisible,
//                           style: const TextStyle(color: Colors.white),
//                           decoration: InputDecoration(
//                             labelText: 'Mật khẩu mới',
//                             labelStyle: const TextStyle(color: Colors.white),
//                             prefixIcon: Icon(Icons.lock, color: Colors.white),
//                             suffixIcon: IconButton(
//                               icon: Icon(
//                                 _isNewPasswordVisible ? Icons.visibility : Icons.visibility_off,
//                                 color: Colors.white,
//                               ),
//                               onPressed: () {
//                                 setState(() {
//                                   _isNewPasswordVisible = !_isNewPasswordVisible;
//                                 });
//                               },
//                             ),
//                             enabledBorder: const UnderlineInputBorder(
//                               borderSide: BorderSide(color: Colors.white),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 10),
//                         TextFormField(
//                           controller: _confirmPasswordController,
//                           obscureText: !_isConfirmPasswordVisible,
//                           style: const TextStyle(color: Colors.white),
//                           decoration: InputDecoration(
//                             labelText: 'Xác nhận mật khẩu',
//                             labelStyle: const TextStyle(color: Colors.white),
//                             prefixIcon: Icon(Icons.lock, color: Colors.white),
//                             suffixIcon: IconButton(
//                               icon: Icon(
//                                 _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
//                                 color: Colors.white,
//                               ),
//                               onPressed: () {
//                                 setState(() {
//                                   _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
//                                 });
//                               },
//                             ),
//                             enabledBorder: const UnderlineInputBorder(
//                               borderSide: BorderSide(color: Colors.white),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 20),
//                         ElevatedButton(
//                           onPressed: () {
//                             if (_newPasswordController.text == _confirmPasswordController.text) {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 const SnackBar(content: Text('Mật khẩu đã được đổi thành công!')),
//                               );
//                               setState(() {
//                                 isChangePasswordVisible = false;
//                                 isCodeSent = false; // Reset state after success
//                               });
//                             } else {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 const SnackBar(content: Text('Mật khẩu không khớp!')),
//                               );
//                             }
//                           },
//                           child: const Text('Xác nhận'),
//                         ),
//                       ],
//                     ),
//                   ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   // Function to log out
//   void _doLogout(BuildContext context) async {
//     final AuthController authController = AuthController();
//     String response = await authController.doLogout(context);
//     if (response == "success") {
//       Navigator.pushReplacementNamed(context, '/');
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(response)),
//       );
//     }
//   }
// }

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
  String email = 'nguyenvana@gmail.com';
  String phoneNumber = '+84 123 456 789';
  String address = 'Hà Nội, Việt Nam';
  String userName = 'Nguyễn Văn A';
  String userRole = 'Khách hàng';

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
  bool isChangePasswordVisible =
      false; // Toggle for showing password change form
  bool isCodeSent = false; // Toggle for code sent status

  // Function to simulate sending verification code
  void _sendVerificationCode() {
    setState(() {
      isCodeSent = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Verification code sent to $email')),
    );
  }

  // Function to toggle password change form visibility
  void _toggleChangePassword() {
    setState(() {
      isChangePasswordVisible = !isChangePasswordVisible;
      isCodeSent = false; // Reset the code sent state
    });
  }

  @override
  Widget build(BuildContext context) {
    // Use MediaQuery to get the size of the screen
    final screenSize = MediaQuery.of(context).size;

    return BaseScreen(
      title: "",
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: screenSize.height *
                      0.6, // Adjust height to 60% of screen height
                  width: screenSize.width *
                      0.9, // Adjust width to 90% of screen width
                  margin: const EdgeInsets.symmetric(horizontal: 15),
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
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                                const SizedBox(height: 10),
                                CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Colors.blue.shade100,
                                  child: Icon(Icons.person,
                                      size: 40, color: Colors.blue),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  userRole,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white70),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                Icon(Icons.email, color: Colors.white70),
                                const SizedBox(width: 10),
                                Flexible(
                                  child: Text(
                                    email,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(Icons.phone, color: Colors.white70),
                                const SizedBox(width: 10),
                                Flexible(
                                  child: Text(
                                    phoneNumber,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(Icons.location_on, color: Colors.white70),
                                const SizedBox(width: 10),
                                Flexible(
                                  child: Text(
                                    address,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                    overflow: TextOverflow.ellipsis,
                                  ),
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
                    margin: const EdgeInsets.symmetric(horizontal: 15),
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
                            Expanded(
                              child: TextFormField(
                                controller: _verificationCodeController,
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  labelText: 'Nhập mã xác nhận',
                                  prefixIcon: Icon(Icons.verified_user,
                                      color: Colors.white),
                                  labelStyle: TextStyle(color: Colors.white),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton(
                              onPressed:
                                  isCodeSent ? null : _sendVerificationCode,
                              child: Text(isCodeSent ? 'Đã gửi' : 'Gửi mã'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _oldPasswordController,
                          obscureText: !_isOldPasswordVisible,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'Mật khẩu cũ',
                            labelStyle: const TextStyle(color: Colors.white),
                            prefixIcon: Icon(Icons.lock, color: Colors.white),
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
                            labelText: 'Mật khẩu mới',
                            labelStyle: const TextStyle(color: Colors.white),
                            prefixIcon: Icon(Icons.lock, color: Colors.white),
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
                            labelText: 'Xác nhận mật khẩu',
                            labelStyle: const TextStyle(color: Colors.white),
                            prefixIcon: Icon(Icons.lock, color: Colors.white),
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
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            if (_newPasswordController.text ==
                                _confirmPasswordController.text) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Mật khẩu đã được đổi thành công!')),
                              );
                              setState(() {
                                isChangePasswordVisible = false;
                                isCodeSent = false; // Reset state after success
                              });
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Mật khẩu không khớp!')),
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
      ),
    );
  }

  // Function to log out
  void _doLogout(BuildContext context) async {
    final AuthController authController = AuthController();
    String response = await authController.doLogout(context);
    if (response == "success") {
      Navigator.pushReplacementNamed(context, '/');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response)),
      );
    }
  }
}
