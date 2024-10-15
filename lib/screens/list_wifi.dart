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
          height: 500,
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
                      child: Text(
                        "Select Wi-Fi",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Expanded(
                      child: ListView.builder(
                        itemCount: wifiList.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              wifiList[index],
                              style: TextStyle(color: Colors.white),
                            ),
                            trailing: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  selectedSSID = wifiList[index];
                                });
                                _showPasswordDialog(context);
                              },
                              child: Text("Connect"),
                            ),
                          );
                        },
                      ),
                    ),
                    const Spacer(),
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
          title: Text("Enter Password for $selectedSSID"),
          content: TextField(
            controller: _passwordController,
            decoration: InputDecoration(hintText: "Password"),
            obscureText: true,
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
              child: Text("Connect"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }
}
