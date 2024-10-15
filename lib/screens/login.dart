// import 'package:flutter/material.dart';
// import 'package:iot_flutter_app/controllers/AuthController.dart';

// class Login extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(children: <Widget>[
//         Positioned.fill(
//             // child: Image.asset(
//             //   'assets/images/logo_vmu.png',
//             //   fit: BoxFit.cover,
//             // ),
//             ),
//         Content(),
//       ]),
//     );
//   }
// }

// class Content extends StatefulWidget {
//   @override
//   _ContentState createState() => _ContentState();
// }

// class _ContentState extends State<Content> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   bool _isLoading = false;

//   Future<void> _login() async {
//     final Authcontroller _authController = Authcontroller();

//     if (!_formKey.currentState!.validate()) {
//       return;
//     }
//     setState(() {
//       _isLoading = true;
//     });
//     String username = _usernameController.text;
//     String password = _passwordController.text;
//     String result = await _authController.doLogin(username, password, context);
//     setState(() {
//       _isLoading = false;
//     });
//     if (result == "success") {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text('Login successful!')));
//       // Navigate to another screen if needed
//     } else {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text(result)));
//     }
//   }

//   @override
//   Widget build(Object context) {
//     return Center(
//       child: LayoutBuilder(
//         builder: (context, constraints) {
//           double width = constraints.maxWidth * 0.8;
//           double widthLogo = constraints.maxWidth * 0.4;

//           return Container(
//             width: width,
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Image.asset(
//                     'assets/images/logo_vmu.png',
//                     width: widthLogo,
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   const Text(
//                     'Welcome',
//                     style: TextStyle(
//                       fontWeight: FontWeight.w600,
//                       color: Color(0xFF06a3da),
//                       fontSize: 30,
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   TextFormField(
//                     controller: _usernameController,
//                     decoration: const InputDecoration(
//                       labelText: "Tên đăng nhập",
//                       border: UnderlineInputBorder(),
//                       prefixIcon: Icon(Icons.person),
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Vui lòng nhập tên đăng nhập';
//                       }
//                       return null;
//                     },
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   TextFormField(
//                     controller: _passwordController,
//                     obscureText: true,
//                     decoration: const InputDecoration(
//                       labelText: "Mật khẩu",
//                       border: UnderlineInputBorder(),
//                       prefixIcon: Icon(Icons.lock),
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Vui lòng nhập mật khẩu';
//                       }
//                       return null;
//                     },
//                   ),
//                   const SizedBox(
//                     height: 30,
//                   ),
//                   _isLoading
//                       ? CircularProgressIndicator()
//                       : ElevatedButton(
//                           onPressed: _login,
//                           child: const Text("Đăng nhập"),
//                           style: ElevatedButton.styleFrom(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 20, vertical: 10),
//                             textStyle: const TextStyle(
//                               fontSize: 15,
//                             ),
//                           ),
//                         ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:iot_flutter_app/controllers/AuthController.dart';
import 'package:iot_flutter_app/utils/app_colors.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.backgroundStart, // Màu bắt đầu gradient
                  AppColors.backgroundEnd, // Màu kết thúc gradient
                ],
              ),
            ),
          ),
          Content(),
        ],
      ),
    );
  }
}

class Content extends StatefulWidget {
  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  Future<void> _login() async {
    final Authcontroller _authController = Authcontroller();

    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() {
      _isLoading = true;
    });
    String username = _usernameController.text;
    String password = _passwordController.text;
    String result = await _authController.doLogin(username, password, context);
    setState(() {
      _isLoading = false;
    });
    if (result == "success") {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Login successful!')));
      // Navigate to another screen if needed
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(result)));
    }
  }

  @override
  Widget build(Object context) {
    return Center(
      child: LayoutBuilder(
        builder: (context, constraints) {
          double width = constraints.maxWidth * 0.8;
          double widthLogo = constraints.maxWidth * 0.4;

          return Container(
            width: width,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/images/logo_vmu.png',
                    width: widthLogo,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Welcome',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColors
                          .textWhite, // Đổi màu văn bản thành màu trắng
                      fontSize: 30,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      labelText: "Tên đăng nhập",
                      border: UnderlineInputBorder(),
                      prefixIcon: Icon(Icons.person,
                          color: AppColors.textWhite), // Đổi màu icon
                      labelStyle: TextStyle(
                          color: AppColors.textWhite), // Đổi màu label
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.textWhite),
                      ),
                    ),
                    style: const TextStyle(
                        color: AppColors.textWhite), // Đổi màu văn bản
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập tên đăng nhập';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "Mật khẩu",
                      border: UnderlineInputBorder(),
                      prefixIcon: Icon(Icons.lock,
                          color: AppColors.textWhite), // Đổi màu icon
                      labelStyle: TextStyle(
                          color: AppColors.textWhite), // Đổi màu label
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.textWhite),
                      ),
                    ),
                    style: const TextStyle(
                        color: AppColors.textWhite), // Đổi màu văn bản
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập mật khẩu';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  _isLoading
                      ? CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(AppColors
                              .textWhite), // Đổi màu Progress Indicator
                        )
                      : ElevatedButton(
                          onPressed: _login,
                          child: const Text("Đăng nhập"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.buttonBuy, // Màu nền nút
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            textStyle: const TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
