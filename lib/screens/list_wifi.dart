import 'dart:ui';
import 'package:flutter/material.dart';

class WiFiListScreen extends StatefulWidget {
  @override
  _WiFiListScreenState createState() => _WiFiListScreenState();
}

class _WiFiListScreenState extends State<WiFiListScreen> {
  List<String> wifiList = [
    'Gara NamKhanh',
    'Ouransoft Techco',
    'CỬA BIỂN',
    'BaoHiem AIA',
    'More Wi-Fi 1',
    'More Wi-Fi 2',
  ];

  String? selectedSSID;
  final TextEditingController _passwordController = TextEditingController();

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
          height: 600, // Tăng chiều cao để tận dụng không gian
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(15),
            color: Colors.black.withOpacity(0.2),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaY: 10, sigmaX: 10), // Tăng độ mờ
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        "Select Wi-Fi",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Tăng chiều cao để hiện thêm nhiều Wi-Fi
                    Expanded(
                      child: ListView.builder(
                        itemCount: wifiList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white.withOpacity(0.1),
                            ),
                            child: ListTile(
                              title: Text(
                                wifiList[index],
                                style: const TextStyle(color: Colors.white),
                              ),
                              trailing: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    selectedSSID = wifiList[index];
                                  });
                                  _showPasswordDialog(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Text("Connect"),
                              ),
                            ),
                          );
                        },
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

  void _showPasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            "Enter Password for $selectedSSID",
            style: const TextStyle(fontSize: 18),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  hintText: "Password",
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 10),
              const Text(
                "Make sure the password is correct.",
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Gửi SSID và mật khẩu đến ESP8266 ở đây
                String password = _passwordController.text;
                print("Connecting to $selectedSSID with password $password");
                // Bạn có thể thêm logic kết nối ở đây
              },
              child: const Text(
                "Connect",
                style: TextStyle(color: Colors.blue),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                "Cancel",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
