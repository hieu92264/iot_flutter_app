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
                                      // onPressed: () {
                                      //   setState(
                                      //       () => selectedSSID = wifi.ssid);
                                      //   if (isEspSelected) {
                                      //     _showPasswordDialog(context);
                                      //   } else {
                                      //     setState(() => isEspSelected = true);
                                      //   }
                                      // },
                                      // child: Text(
                                      //     isEspSelected ? "Connect" : "Next"),
                                      onPressed: () {
                                        setState(
                                            () => selectedSSID = wifi.ssid);
                                        isEspSelected = !isEspSelected;
                                        _showPasswordDialog(
                                            context); // Luôn yêu cầu nhập mật khẩu
                                      },
                                      child: const Text("Connect"),
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
