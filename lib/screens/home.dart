import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:iot_flutter_app/components/base_screen.dart'; // Định dạng ngày và giờ

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String currentDate = '';
  String currentTime = '';
  bool isAuto = true; // Theo dõi chế độ tự động/thủ công
  Timer? _timer;
  String? currentTemperature =
      '24°C'; // Giá trị tạm thời cho thời tiết hiện tại
  String? currentHumidity = '60%';
  String? currentCondition = 'Ít mây';
  // List<Map<String, String>> hourlyForecast = [
  //   {'hour': '10 AM', 'temp': '22°C', 'condition': 'Trời quang'},
  //   {'hour': '11 AM', 'temp': '24°C', 'condition': 'Ít mây'},
  //   {'hour': '12 PM', 'temp': '26°C', 'condition': 'Mưa'},
  //   {'hour': '1 PM', 'temp': '27°C', 'condition': 'Nhiều mây'},
  //   // Thêm các dự báo trong 24 giờ
  // ]; // Dữ liệu dự báo hàng giờ

  List<Color> boxColors = [Colors.white, Colors.white, Colors.white];
  int clickCount = 0;

  List<Map<String, String>> hourlyForecast = [
    {'hour': '10 AM', 'temp': '22°C', 'condition': 'Trời quang'},
    {'hour': '11 AM', 'temp': '24°C', 'condition': 'Ít mây'},
    {'hour': '12 PM', 'temp': '26°C', 'condition': 'Mưa'},
    {'hour': '1 PM', 'temp': '27°C', 'condition': 'Nhiều mây'},
    {'hour': '2 PM', 'temp': '28°C', 'condition': 'Nắng'},
    {'hour': '3 PM', 'temp': '29°C', 'condition': 'Ít mây'},
    {'hour': '4 PM', 'temp': '28°C', 'condition': 'Nhiều mây'},
    {'hour': '5 PM', 'temp': '27°C', 'condition': 'Trời quang'},
    {'hour': '6 PM', 'temp': '25°C', 'condition': 'Ít mây'},
    {'hour': '7 PM', 'temp': '24°C', 'condition': 'Mưa'},
    {'hour': '8 PM', 'temp': '23°C', 'condition': 'Nhiều mây'},
    {'hour': '9 PM', 'temp': '22°C', 'condition': 'Trời quang'},
    {'hour': '10 PM', 'temp': '21°C', 'condition': 'Ít mây'},
    {'hour': '11 PM', 'temp': '20°C', 'condition': 'Nhiều mây'},
    {'hour': '12 AM', 'temp': '19°C', 'condition': 'Nắng'},
    {'hour': '1 AM', 'temp': '18°C', 'condition': 'Ít mây'},
    {'hour': '2 AM', 'temp': '17°C', 'condition': 'Trời quang'},
    {'hour': '3 AM', 'temp': '17°C', 'condition': 'Mưa'},
    {'hour': '4 AM', 'temp': '16°C', 'condition': 'Nhiều mây'},
    {'hour': '5 AM', 'temp': '16°C', 'condition': 'Trời quang'},
    {'hour': '6 AM', 'temp': '17°C', 'condition': 'Ít mây'},
    {'hour': '7 AM', 'temp': '19°C', 'condition': 'Nắng'},
    {'hour': '8 AM', 'temp': '21°C', 'condition': 'Trời quang'},
    {'hour': '9 AM', 'temp': '23°C', 'condition': 'Ít mây'},
  ]; // Dữ liệu dự báo hàng giờ trong 24 giờ

  @override
  void initState() {
    super.initState();
    _updateDateTime();
  }

  void _changeToBlack() async {
    if (clickCount < 3) {
      await Future.delayed(const Duration(milliseconds: 200), () {
        setState(() {
          boxColors[clickCount] = Colors.black; // Đổi màu ô hiện tại sang đen
        });
      });
      clickCount++; // Tăng clickCount
    }
  }

  void _changeToWhite() async {
    if (clickCount > 0) {
      clickCount--; // Giảm clickCount để chuyển màu ô trước đó
      await Future.delayed(const Duration(milliseconds: 200), () {
        setState(() {
          boxColors[clickCount] = Colors.white; // Đổi màu ô hiện tại về trắng
        });
      });
    }
  }

  Widget _buildHexagon(Color color, int index) {
    return ClipPath(
      clipper: HexagonClipper(),
      child: Container(
        color: color,
        height: 70,
        width: 70,
        alignment: Alignment.center,
        child: Center(
          child: Icon(
            color == Colors.white
                ? (index == 0
                        ? Icons.wb_sunny // Ô trắng thứ nhất
                        : index == 1
                            ? Icons.wb_sunny // Ô trắng thứ hai
                            : Icons.wb_sunny // Ô trắng thứ ba
                    )
                : index == 0
                    ? Icons.cloud_queue // Ô đen thứ nhất
                    : index == 1
                        ? Icons.cloud // Ô đen thứ hai
                        : index == 2
                            ? Icons.beach_access // Ô đen thứ ba
                            : Icons
                                .help_outline, // Biểu tượng mặc định cho các ô khác
            color: color == Colors.white
                ? Colors.black
                : Colors.white, // Đổi màu biểu tượng
            size: 35, // Kích thước icon
          ),
        ),
      ),
    );
  }

  void _updateDateTime() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final now = DateTime.now();
      final formattedDate = DateFormat('dd/MM/yyyy').format(now);
      final formattedTime = DateFormat('HH:mm:ss').format(now);

      if (mounted) {
        setState(() {
          currentDate = formattedDate;
          currentTime = formattedTime;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Widget buildWeatherIcon(String condition) {
    // Map điều kiện thời tiết với icon phù hợp
    IconData icon;
    switch (condition) {
      case 'Trời quang':
        icon = Icons.wb_sunny; // Biểu tượng cho trời quang
        break;
      case 'Ít mây':
        icon = Icons.cloud_queue; // Biểu tượng cho ít mây
        break;
      case 'Mưa':
        icon = Icons.beach_access; // Biểu tượng cho mưa
        break;
      case 'Nhiều mây':
        icon = Icons.cloud; // Biểu tượng cho nhiều mây
        break;
      case 'Nắng':
        icon = Icons.wb_sunny; // Biểu tượng cho nắng
        break;
      case 'Sương mù':
        icon = Icons.wb_cloudy; // Biểu tượng cho sương mù
        break;
      case 'Bão':
        icon = Icons.thunderstorm; // Biểu tượng cho bão
        break;
      case 'Tuyết':
        icon = Icons.ac_unit; // Biểu tượng cho tuyết
        break;
      default:
        icon = Icons.help_outline; // Biểu tượng cho điều kiện không xác định
    }
    return Icon(icon, color: Colors.white, size: 50); // Tăng kích thước icon
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: "Trang chủ",
      child: Scaffold(
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
            constraints: BoxConstraints(maxHeight: isAuto ? 600 : 700),
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 30),
            decoration: BoxDecoration(
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Hiển thị thời tiết hiện tại (icon ở giữa, nhiệt độ bên trái, độ ẩm bên phải)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Nhiệt độ:',
                                  style: TextStyle(color: Colors.white)),
                              Text(currentTemperature ?? '',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 24)),
                            ],
                          ),
                          Column(
                            children: [
                              buildWeatherIcon(
                                  currentCondition ?? 'Trời quang'),
                              Text(currentCondition ?? '',
                                  style: TextStyle(
                                      color: Colors
                                          .white)), // Điều kiện thời tiết dưới icon
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Độ ẩm:',
                                  style: TextStyle(color: Colors.white)),
                              Text(currentHumidity ?? '',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 24)),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Dự báo thời tiết hàng giờ
                      Text('Dự báo hàng giờ',
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                      const SizedBox(height: 10),
                      SingleChildScrollView(
                        // Cuộn ngang cho dự báo thời tiết
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: hourlyForecast.map((forecast) {
                            return Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                children: [
                                  Text(forecast['hour'] ?? '',
                                      style: TextStyle(color: Colors.white)),
                                  buildWeatherIcon(
                                      forecast['condition'] ?? 'Trời quang'),
                                  Text(forecast['temp'] ?? '',
                                      style: TextStyle(color: Colors.white)),
                                  Text(forecast['condition'] ?? '',
                                      style: TextStyle(
                                          color: Colors
                                              .white)), // Điều kiện thời tiết dưới icon
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      const Spacer(),

                      // Trạng thái rèm và mưa
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Trạng thái rèm:',
                              style: TextStyle(color: Colors.white)),
                          Container(
                            height: 20,
                            width: 50,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Trạng thái mưa:',
                              style: TextStyle(color: Colors.white)),
                          Container(
                            height: 20,
                            width: 50,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Ngày và giờ
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(currentDate,
                              style: TextStyle(color: Colors.white)),
                          Text(currentTime,
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Nút chuyển đổi với animation
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isAuto = !isAuto;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            height: 80,
                            width: 300,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 2),
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: Stack(
                              children: [
                                AnimatedAlign(
                                  duration: const Duration(milliseconds: 300),
                                  alignment: isAuto
                                      ? Alignment.centerLeft
                                      : Alignment.centerRight,
                                  child: Container(
                                    height: 70,
                                    width: 120,
                                    margin: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.grey, width: 2),
                                      borderRadius: BorderRadius.circular(35),
                                    ),
                                    child: Center(
                                      child: Text(
                                        isAuto ? 'Tự động' : 'Thủ công',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      if (!isAuto) const SizedBox(height: 20),
                      if (!isAuto)
                        Container(
                          width: 460,
                          height: 100,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            // Thêm màu nền nếu cần
                            borderRadius:
                                BorderRadius.circular(20), // Bo tròn các góc
                            border: Border.all(color: Colors.grey, width: 0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: _changeToWhite, // Mũi tên trái
                                child: Icon(
                                  Icons.arrow_left,
                                  color: Colors.white,
                                  size: 80,
                                ),
                              ),
                              // Các ô lục giác
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children:
                                    List.generate(boxColors.length, (index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal:
                                            10), // Khoảng cách giữa các ô
                                    child:
                                        _buildHexagon(boxColors[index], index),
                                  );
                                }),
                              ),
                              GestureDetector(
                                onTap: _changeToBlack, // Mũi tên phải
                                child: Icon(
                                  Icons.arrow_right,
                                  color: Colors.white,
                                  size: 80,
                                ),
                              ),
                            ],
                          ),
                        )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HexagonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double width = size.width;
    double height = size.height;

    path.moveTo(width / 2, 0);
    path.lineTo(width, height * 0.25);
    path.lineTo(width, height * 0.75);
    path.lineTo(width / 2, height);
    path.lineTo(0, height * 0.75);
    path.lineTo(0, height * 0.25);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
