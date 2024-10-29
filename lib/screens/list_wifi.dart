// import 'dart:ui';
// import 'package:flutter/material.dart';

// class WiFiListScreen extends StatefulWidget {
//   @override
//   _WiFiListScreenState createState() => _WiFiListScreenState();
// }

// class _WiFiListScreenState extends State<WiFiListScreen> {
//   // List giả lập Wi-Fi Access Point của ESP8266 và các Wi-Fi thông thường
//   List<String> espWifiList = [
//     'ESP_001',
//     'ESP_002',
//     'ESP_003'
//   ]; // Wi-Fi ESP phát ra
//   List<String> homeWifiList = [
//     'Home_WiFi_1',
//     'Home_WiFi_2',
//     'Home_WiFi_3'
//   ]; // Wi-Fi gia đình

//   String? selectedSSID;
//   final TextEditingController _passwordController = TextEditingController();
//   bool isEspSelected =
//       false; // Biến để biết người dùng đang chọn Wi-Fi ESP hay Wi-Fi gia đình

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         height: double.infinity,
//         width: double.infinity,
//         decoration: const BoxDecoration(
//           image: DecorationImage(
//               image: AssetImage('assets/images/background.jpeg'),
//               fit: BoxFit.fill),
//         ),
//         alignment: Alignment.center,
//         child: Container(
//           height: 600,
//           width: double.infinity,
//           margin: const EdgeInsets.symmetric(horizontal: 20),
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.white),
//             borderRadius: BorderRadius.circular(15),
//             color: Colors.black.withOpacity(0.2),
//           ),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(20),
//             child: BackdropFilter(
//               filter: ImageFilter.blur(sigmaY: 10, sigmaX: 10),
//               child: Padding(
//                 padding: const EdgeInsets.all(20),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Center(
//                       child: Text(
//                         isEspSelected
//                             ? "Select Home Wi-Fi"
//                             : "Select ESP Wi-Fi",
//                         style: const TextStyle(
//                           fontSize: 28,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     // Hiển thị danh sách Wi-Fi (ESP hoặc Home Wi-Fi tùy theo isEspSelected)
//                     Expanded(
//                       child: ListView.builder(
//                         itemCount: isEspSelected
//                             ? homeWifiList.length
//                             : espWifiList.length,
//                         itemBuilder: (context, index) {
//                           String wifiName = isEspSelected
//                               ? homeWifiList[index]
//                               : espWifiList[index];

//                           return Container(
//                             margin: const EdgeInsets.symmetric(vertical: 8),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10),
//                               color: Colors.white.withOpacity(0.1),
//                             ),
//                             child: ListTile(
//                               title: Text(
//                                 wifiName,
//                                 style: const TextStyle(color: Colors.white),
//                               ),
//                               trailing: ElevatedButton(
//                                 onPressed: () {
//                                   setState(() {
//                                     selectedSSID = wifiName;
//                                   });
//                                   if (isEspSelected) {
//                                     // Nếu đã chọn Wi-Fi gia đình, yêu cầu nhập mật khẩu
//                                     _showPasswordDialog(context);
//                                   } else {
//                                     // Nếu đang chọn Wi-Fi ESP, chuyển sang chọn Wi-Fi gia đình
//                                     setState(() {
//                                       isEspSelected = true;
//                                     });
//                                   }
//                                 },
//                                 style: ElevatedButton.styleFrom(
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                                 ),
//                                 child: Text(isEspSelected ? "Connect" : "Next"),
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   // Dialog nhập mật khẩu khi chọn Wi-Fi gia đình
//   void _showPasswordDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20),
//           ),
//           title: Text(
//             "Enter Password for $selectedSSID",
//             style: const TextStyle(fontSize: 18),
//           ),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(
//                 controller: _passwordController,
//                 decoration: const InputDecoration(
//                   hintText: "Password",
//                   border: OutlineInputBorder(),
//                 ),
//                 obscureText: true,
//               ),
//               const SizedBox(height: 10),
//               const Text(
//                 "Make sure the password is correct.",
//                 style: TextStyle(color: Colors.grey, fontSize: 12),
//               ),
//             ],
//           ),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 // Gửi SSID và mật khẩu đến ESP8266 qua HTTP POST hoặc WebSocket
//                 String password = _passwordController.text;
//                 print("Connecting to $selectedSSID with password $password");
//                 _sendWifiCredentialsToESP(selectedSSID!, password);
//               },
//               child: const Text(
//                 "Connect",
//                 style: TextStyle(color: Colors.blue),
//               ),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: const Text(
//                 "Cancel",
//                 style: TextStyle(color: Colors.red),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   // Gửi thông tin Wi-Fi đến ESP8266
//   void _sendWifiCredentialsToESP(String ssid, String password) async {
//     // Bạn có thể gửi yêu cầu HTTP POST tới ESP để ESP kết nối với Wi-Fi gia đình
//     // Giả sử ESP8266 ở IP 192.168.4.1 (khi trong chế độ AP)
//     String espIpAddress = '192.168.4.1';
//     String url = 'http://$espIpAddress/connect';
//     print(ssid);
//     print(password);
//     Navigator.pushReplacementNamed(context, '/home');
//     // Tạo yêu cầu HTTP để gửi SSID và mật khẩu tới ESP8266
//     // try {
//     //   var response = await http.post(
//     //     Uri.parse(url),
//     //     body: {
//     //       'ssid': ssid,
//     //       'password': password,
//     //     },
//     //   );

//     //   if (response.statusCode == 200) {
//     //     // ESP8266 đã nhận và kết nối thành công
//     //     print("Connected to Wi-Fi successfully!");
//     //     // Điều hướng về màn hình chính hoặc tiếp tục các bước khác
//     //   } else {
//     //     // Thông báo lỗi
//     //     print("Failed to connect to Wi-Fi.");
//     //   }
//     // } catch (e) {
//     //   print("Error: $e");
//     // }
//   }
// }

// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:wifi_scan/wifi_scan.dart';

// class WiFiListScreen extends StatefulWidget {
//   @override
//   _WiFiListScreenState createState() => _WiFiListScreenState();
// }

// Future<void> requestPermissions() async {
//   var status = await Permission.location.status;
//   if (!status.isGranted) {
//     await Permission.location.request();
//   }
//   var backgroundStatus = await Permission.locationAlways.status;
//   if (!backgroundStatus.isGranted) {
//     await Permission.locationAlways.request();
//   }
// }

// class _WiFiListScreenState extends State<WiFiListScreen> {
//   List<WiFiAccessPoint> wifiList = [];
//   String? selectedSSID;
//   final TextEditingController _passwordController = TextEditingController();
//   bool isEspSelected = false;

//   @override
//   void initState() {
//     super.initState();
//     requestPermissions();
//     _loadWifiList();
//   }

//   // Hàm lấy danh sách Wi-Fi và kiểm tra quyền quét
//   Future<void> _loadWifiList() async {
//     // Kiểm tra xem có quyền quét Wi-Fi hay không
//     final canStartScan =
//         await WiFiScan.instance.canStartScan(askPermissions: true);

//     if (canStartScan == CanStartScan.yes) {
//       // Nếu được phép, bắt đầu quét Wi-Fi
//       await WiFiScan.instance.startScan();

//       WiFiScan.instance.onScannedResultsAvailable
//           .listen((List<WiFiAccessPoint> results) {
//         setState(() {
//           wifiList = results;
//         });
//       });
//     } else {
//       print("Permission to scan Wi-Fi is denied or restricted.");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         height: double.infinity,
//         width: double.infinity,
//         decoration: const BoxDecoration(
//           image: DecorationImage(
//               image: AssetImage('assets/images/background.jpeg'),
//               fit: BoxFit.fill),
//         ),
//         alignment: Alignment.center,
//         child: Container(
//           height: 600,
//           width: double.infinity,
//           margin: const EdgeInsets.symmetric(horizontal: 20),
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.white),
//             borderRadius: BorderRadius.circular(15),
//             color: Colors.black.withOpacity(0.2),
//           ),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(20),
//             child: BackdropFilter(
//               filter: ImageFilter.blur(sigmaY: 10, sigmaX: 10),
//               child: Padding(
//                 padding: const EdgeInsets.all(20),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Center(
//                       child: Text(
//                         isEspSelected
//                             ? "Select Home Wi-Fi"
//                             : "Select ESP Wi-Fi",
//                         style: const TextStyle(
//                           fontSize: 28,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     Expanded(
//                       child: ListView.builder(
//                         itemCount: wifiList.length,
//                         itemBuilder: (context, index) {
//                           String wifiName = wifiList[index].ssid;

//                           return Container(
//                             margin: const EdgeInsets.symmetric(vertical: 8),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10),
//                               color: Colors.white.withOpacity(0.1),
//                             ),
//                             child: ListTile(
//                               title: Text(
//                                 wifiName,
//                                 style: const TextStyle(color: Colors.white),
//                               ),
//                               trailing: ElevatedButton(
//                                 onPressed: () {
//                                   setState(() {
//                                     selectedSSID = wifiName;
//                                   });
//                                   if (isEspSelected) {
//                                     _showPasswordDialog(context);
//                                   } else {
//                                     setState(() {
//                                       isEspSelected = true;
//                                     });
//                                   }
//                                 },
//                                 style: ElevatedButton.styleFrom(
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                                 ),
//                                 child: Text(isEspSelected ? "Connect" : "Next"),
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   void _showPasswordDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20),
//           ),
//           title: Text(
//             "Enter Password for $selectedSSID",
//             style: const TextStyle(fontSize: 18),
//           ),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(
//                 controller: _passwordController,
//                 decoration: const InputDecoration(
//                   hintText: "Password",
//                   border: OutlineInputBorder(),
//                 ),
//                 obscureText: true,
//               ),
//               const SizedBox(height: 10),
//               const Text(
//                 "Make sure the password is correct.",
//                 style: TextStyle(color: Colors.grey, fontSize: 12),
//               ),
//             ],
//           ),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 String password = _passwordController.text;
//                 _sendWifiCredentialsToESP(selectedSSID!, password);
//               },
//               child: const Text(
//                 "Connect",
//                 style: TextStyle(color: Colors.blue),
//               ),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: const Text(
//                 "Cancel",
//                 style: TextStyle(color: Colors.red),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _sendWifiCredentialsToESP(String ssid, String password) async {
//     String espIpAddress = '192.168.4.1';
//     String url = 'http://$espIpAddress/connect';
//     print(ssid);
//     print(password);
//     Navigator.pushReplacementNamed(context, '/home');
//   }
// }

import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:wifi_scan/wifi_scan.dart';
import 'package:geolocator/geolocator.dart';

class WiFiListScreen extends StatefulWidget {
  @override
  _WiFiListScreenState createState() => _WiFiListScreenState();
}

class _WiFiListScreenState extends State<WiFiListScreen> {
  List<WiFiAccessPoint> accessPoints = [];
  StreamSubscription<List<WiFiAccessPoint>>? subscription;
  bool shouldCheckCan = true;
  bool isEspSelected = false;
  String? selectedSSID;
  final TextEditingController _passwordController = TextEditingController();

  bool get isStreaming => subscription != null;

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
  }

  Future<void> _requestLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        kShowSnackBar(
            context, "Ứng dụng cần quyền truy cập vị trí để quét Wi-Fi.");
        return;
      }
    }
    // Kiểm tra và yêu cầu người dùng bật dịch vụ vị trí
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
    }
  }

  Future<void> _startScan(BuildContext context) async {
    await _checkAndRequestLocationServices(context);
    if (shouldCheckCan) {
      final can = await WiFiScan.instance.canStartScan();
      if (can != CanStartScan.yes) {
        if (context.mounted)
          kShowSnackBar(context, "Không thể bắt đầu quét: $can");
        return;
      }
    }

    final result = await WiFiScan.instance.startScan();
    if (context.mounted) kShowSnackBar(context, "Đã bắt đầu quét: $result");
    setState(() => accessPoints = []);
  }

  Future<void> _checkAndRequestLocationServices(BuildContext context) async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      kShowSnackBar(context, "Vui lòng bật dịch vụ định vị để quét Wi-Fi.");
      await Geolocator.openLocationSettings();
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        kShowSnackBar(context, "Yêu cầu quyền truy cập vị trí để quét Wi-Fi.");
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      kShowSnackBar(context,
          "Quyền truy cập vị trí đã bị từ chối vĩnh viễn. Vui lòng bật lại trong cài đặt.");
      return;
    }
  }

  Future<bool> _canGetScannedResults(BuildContext context) async {
    if (shouldCheckCan) {
      final can = await WiFiScan.instance.canGetScannedResults();
      if (can != CanGetScannedResults.yes) {
        if (context.mounted) {
          kShowSnackBar(context, "Không thể lấy kết quả quét: $can");
        }
        accessPoints = [];
        return false;
      }
    }
    return true;
  }

  Future<void> _getScannedResults(BuildContext context) async {
    if (await _canGetScannedResults(context)) {
      final results = await WiFiScan.instance.getScannedResults();
      setState(() => accessPoints = results);
    }
  }

  Future<void> _startListeningToScanResults(BuildContext context) async {
    if (await _canGetScannedResults(context)) {
      subscription = WiFiScan.instance.onScannedResultsAvailable
          .listen((result) => setState(() => accessPoints = result));
    }
  }

  void _stopListeningToScanResults() {
    subscription?.cancel();
    setState(() => subscription = null);
  }

  @override
  void dispose() {
    super.dispose();
    _stopListeningToScanResults();
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
            fit: BoxFit.fill,
          ),
        ),
        alignment: Alignment.center,
        child: Container(
          height: 600,
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
              filter: ImageFilter.blur(sigmaY: 10, sigmaX: 10),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        isEspSelected
                            ? "Select Home Wi-Fi"
                            : "Select ESP Wi-Fi",
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Wrap(
                      spacing: 8.0,
                      alignment: WrapAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          icon: const Icon(Icons.perm_scan_wifi),
                          label: const Text('SCAN'),
                          onPressed: () async => _startScan(context),
                        ),
                        ElevatedButton.icon(
                          icon: const Icon(Icons.refresh),
                          label: const Text('GET'),
                          onPressed: () async => _getScannedResults(context),
                        ),
                        _buildToggle(
                          label: "STREAM",
                          value: isStreaming,
                          onChanged: (shouldStream) async => shouldStream
                              ? await _startListeningToScanResults(context)
                              : _stopListeningToScanResults(),
                        ),
                      ],
                    ),
                    const Divider(),
                    Flexible(
                      child: Center(
                        child: accessPoints.isEmpty
                            ? const Text("NO SCANNED RESULTS")
                            : ListView.builder(
                                itemCount: accessPoints.length,
                                itemBuilder: (context, index) {
                                  WiFiAccessPoint wifi = accessPoints[index];
                                  return ListTile(
                                    title: Text(
                                      wifi.ssid.isNotEmpty
                                          ? wifi.ssid
                                          : "**EMPTY**",
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    subtitle: Text(wifi.capabilities),
                                    trailing: ElevatedButton(
                                      onPressed: () {
                                        setState(
                                            () => selectedSSID = wifi.ssid);
                                        if (isEspSelected) {
                                          _showPasswordDialog(context);
                                        } else {
                                          setState(() => isEspSelected = true);
                                        }
                                      },
                                      child: Text(
                                          isEspSelected ? "Connect" : "Next"),
                                    ),
                                  );
                                },
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
    );
  }

  Widget _buildToggle({
    required String label,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: TextStyle(color: Colors.white)),
        Switch(
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }

  void _showPasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text("Enter Password for $selectedSSID"),
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
                String password = _passwordController.text;
                _sendWifiCredentialsToESP(selectedSSID!, password);
              },
              child:
                  const Text("Connect", style: TextStyle(color: Colors.blue)),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancel", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  void _sendWifiCredentialsToESP(String ssid, String password) {
    // Connect to ESP device logic
  }
}

void kShowSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));
}
