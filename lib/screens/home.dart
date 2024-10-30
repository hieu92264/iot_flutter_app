// import 'dart:async';
// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:iot_flutter_app/components/base_screen.dart'; // Để định dạng ngày và giờ

// class Home extends StatefulWidget {
//   const Home({super.key});

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   String _ngayHienTai = '';
//   String _gioHienTai = '';
//   bool isAuto = true; // Biến để theo dõi trạng thái tự động hoặc thủ công
//   Timer? _timer; // Thêm biến timer

//   @override
//   void initState() {
//     super.initState();
//     _capNhatNgayGio(); // Gọi hàm để cập nhật ngày và giờ
//   }

//   // Hàm để cập nhật ngày và giờ hiện tại mỗi giây
//   void _capNhatNgayGio() {
//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       final hienTai = DateTime.now();
//       final dinhDangNgay =
//           DateFormat('dd/MM/yyyy').format(hienTai); // Định dạng ngày
//       final dinhDangGio =
//           DateFormat('HH:mm:ss').format(hienTai); // Định dạng giờ

//       if (mounted) {
//         // Kiểm tra xem widget có còn trong cây không
//         setState(() {
//           _ngayHienTai = dinhDangNgay; // Cập nhật ngày
//           _gioHienTai = dinhDangGio; // Cập nhật giờ
//         });
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _timer?.cancel(); // Hủy timer khi widget bị hủy
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BaseScreen(
//       title: "Home",
//       child: Scaffold(
//         body: Container(
//           height: double.infinity,
//           width: double.infinity,
//           decoration: const BoxDecoration(
//             image: DecorationImage(
//                 image: AssetImage('assets/images/background.jpeg'),
//                 fit: BoxFit.fill),
//           ),
//           alignment: Alignment.center,
//           child: Container(
//             // Tự động điều chỉnh chiều cao dựa trên nội dung
//             constraints: BoxConstraints(
//               maxHeight: isAuto ? 600 : 700, // Chiều cao tối đa
//             ),
//             width: double.infinity,
//             margin: const EdgeInsets.symmetric(horizontal: 30),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(15),
//               color: Colors.black.withOpacity(0.1), // Màu nền
//             ),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(20),
//               child: BackdropFilter(
//                 filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
//                 child: Padding(
//                   padding: const EdgeInsets.all(25),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Biểu đồ ánh sáng
//                       const Text('Biểu đồ ánh sáng',
//                           style: TextStyle(color: Colors.white)),
//                       Container(
//                         height: 60,
//                         decoration: BoxDecoration(
//                           border: Border.all(color: Colors.white),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                       const SizedBox(height: 20),
//                       // Biểu đồ mưa
//                       const Text('Biểu đồ mưa',
//                           style: TextStyle(color: Colors.white)),
//                       Container(
//                         height: 60,
//                         decoration: BoxDecoration(
//                           border: Border.all(color: Colors.white),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                       const SizedBox(height: 20),
//                       // Biểu đồ nhiệt độ và độ ẩm
//                       const Text('Biểu đồ nhiệt độ - độ ẩm',
//                           style: TextStyle(color: Colors.white)),
//                       Container(
//                         height: 100,
//                         decoration: BoxDecoration(
//                           border: Border.all(color: Colors.white),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                       const SizedBox(height: 20),
//                       // Trạng thái rèm và mưa
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text('Trạng thái rèm:',
//                               style: TextStyle(color: Colors.white)),
//                           Container(
//                             height: 20,
//                             width: 50,
//                             decoration: BoxDecoration(
//                               border: Border.all(color: Colors.white),
//                               borderRadius: BorderRadius.circular(5),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 10),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text('Trạng thái mưa:',
//                               style: TextStyle(color: Colors.white)),
//                           Container(
//                             height: 20,
//                             width: 50,
//                             decoration: BoxDecoration(
//                               border: Border.all(color: Colors.white),
//                               borderRadius: BorderRadius.circular(5),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const Spacer(),
//                       // Ngày và giờ
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(_ngayHienTai,
//                               style: const TextStyle(color: Colors.white)),
//                           Text(_gioHienTai,
//                               style: const TextStyle(color: Colors.white)),
//                         ],
//                       ),
//                       const SizedBox(height: 20),
//                       // Nút kéo với chuyển động
//                       Center(
//                         child: GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               isAuto =
//                                   !isAuto; // Đổi trạng thái khi nhấn vào nút
//                             });
//                           },
//                           child: AnimatedContainer(
//                             duration: const Duration(
//                                 milliseconds: 300), // Hiệu ứng chuyển đổi
//                             height: 80,
//                             width: 300, // Kích thước nút lớn hơn
//                             decoration: BoxDecoration(
//                               border: Border.all(
//                                   color: Colors.grey,
//                                   width: 2), // Đường viền xám cho nút lớn
//                               borderRadius: BorderRadius.circular(
//                                   40), // Hình dạng bầu dục
//                             ),
//                             child: Stack(
//                               children: [
//                                 // Vòng bầu dục bên trong để di chuyển
//                                 AnimatedAlign(
//                                   duration: const Duration(milliseconds: 300),
//                                   alignment: isAuto
//                                       ? Alignment.centerLeft
//                                       : Alignment.centerRight,
//                                   child: Container(
//                                     height: 70,
//                                     width: 120, // Kích thước bầu dục ngang
//                                     margin: const EdgeInsets.all(5),
//                                     decoration: BoxDecoration(
//                                       color: Colors.white, // Màu vòng bầu dục
//                                       border: Border.all(
//                                           color: Colors.grey,
//                                           width:
//                                               2), // Đường viền xám cho vòng bầu dục
//                                       borderRadius: BorderRadius.circular(
//                                           35), // Hình dạng bầu dục
//                                     ),
//                                     child: Center(
//                                       child: Text(
//                                         isAuto ? 'Tự động' : 'Thủ công',
//                                         style: const TextStyle(
//                                           color: Colors
//                                               .black, // Màu chữ bên trong nút
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                       if (!isAuto)
//                         const SizedBox(
//                             height:
//                                 20), // Khoảng cách giữa nút và container bên dưới
//                       if (!isAuto) // Chỉ hiển thị nếu không phải tự động
//                         Container(
//                           width: double.infinity,
//                           height: 80, // Chiều cao của container
//                           decoration: BoxDecoration(
//                             border: Border.all(
//                                 color: Colors.white,
//                                 width: 2), // Đường viền trắng cho container
//                           ),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               const Icon(Icons.arrow_left,
//                                   color: Colors.blue,
//                                   size: 50), // Kích thước mũi tên trái
//                               Container(
//                                 width: 60, // Kích thước hình
//                                 height: 60,
//                                 decoration: BoxDecoration(
//                                   shape: BoxShape.rectangle,
//                                   border: Border.all(color: Colors.blue),
//                                 ),
//                               ),
//                               Container(
//                                 width: 60, // Kích thước hình
//                                 height: 60,
//                                 decoration: BoxDecoration(
//                                   shape: BoxShape.rectangle,
//                                   border: Border.all(color: Colors.blue),
//                                 ),
//                               ),
//                               Container(
//                                 width: 60, // Kích thước hình
//                                 height: 60,
//                                 decoration: BoxDecoration(
//                                   shape: BoxShape.rectangle,
//                                   border: Border.all(color: Colors.blue),
//                                 ),
//                               ),
//                               const Icon(Icons.arrow_right,
//                                   color: Colors.blue,
//                                   size: 50), // Kích thước mũi tên phải
//                             ],
//                           ),
//                         ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'dart:async';
// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:iot_flutter_app/components/base_screen.dart'; // Định dạng ngày và giờ

// class Home extends StatefulWidget {
//   const Home({super.key});

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   String currentDate = '';
//   String currentTime = '';
//   bool isAuto = true; // Theo dõi chế độ tự động/thủ công
//   Timer? _timer;
//   String? currentTemperature =
//       '24°C'; // Giá trị tạm thời cho thời tiết hiện tại
//   String? currentHumidity = '60%';
//   String? currentCondition = 'Ít mây';
//   List<Map<String, String>> hourlyForecast = [
//     {'hour': '10 AM', 'temp': '22°C', 'condition': 'Trời quang'},
//     {'hour': '11 AM', 'temp': '24°C', 'condition': 'Ít mây'},
//     {'hour': '12 PM', 'temp': '26°C', 'condition': 'Mưa'},
//     {'hour': '1 PM', 'temp': '27°C', 'condition': 'Nhiều mây'},
//   ]; // Dữ liệu dự báo hàng giờ

//   @override
//   void initState() {
//     super.initState();
//     _updateDateTime();
//   }

//   void _updateDateTime() {
//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       final now = DateTime.now();
//       final formattedDate = DateFormat('dd/MM/yyyy').format(now);
//       final formattedTime = DateFormat('HH:mm:ss').format(now);

//       if (mounted) {
//         setState(() {
//           currentDate = formattedDate;
//           currentTime = formattedTime;
//         });
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     super.dispose();
//   }

//   Widget buildWeatherIcon(String condition) {
//     // Map điều kiện thời tiết với icon phù hợp
//     IconData icon;
//     switch (condition) {
//       case 'Trời quang':
//         icon = Icons.wb_sunny;
//         break;
//       case 'Ít mây':
//         icon = Icons.cloud;
//         break;
//       case 'Mưa':
//         icon = Icons.beach_access; // Ô cho trời mưa
//         break;
//       case 'Nhiều mây':
//         icon = Icons.cloud_queue;
//         break;
//       default:
//         icon = Icons.help_outline;
//     }
//     return Icon(icon, color: Colors.white, size: 50);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BaseScreen(
//       title: "Trang chủ",
//       child: Scaffold(
//         body: Container(
//           height: double.infinity,
//           width: double.infinity,
//           decoration: const BoxDecoration(
//             image: DecorationImage(
//                 image: AssetImage('assets/images/background.jpeg'),
//                 fit: BoxFit.fill),
//           ),
//           alignment: Alignment.center,
//           child: Container(
//             constraints: BoxConstraints(maxHeight: isAuto ? 600 : 700),
//             width: double.infinity,
//             margin: const EdgeInsets.symmetric(horizontal: 30),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(15),
//               color: Colors.black.withOpacity(0.1),
//             ),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(20),
//               child: BackdropFilter(
//                 filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
//                 child: Padding(
//                   padding: const EdgeInsets.all(25),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       // Hiển thị thời tiết hiện tại (icon ở giữa, nhiệt độ bên trái, độ ẩm bên phải)
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text('Nhiệt độ:',
//                                   style: TextStyle(color: Colors.white)),
//                               Text(currentTemperature ?? '',
//                                   style: TextStyle(
//                                       color: Colors.white, fontSize: 24)),
//                             ],
//                           ),
//                           buildWeatherIcon(currentCondition ?? 'Trời quang'),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text('Độ ẩm:',
//                                   style: TextStyle(color: Colors.white)),
//                               Text(currentHumidity ?? '',
//                                   style: TextStyle(
//                                       color: Colors.white, fontSize: 24)),
//                             ],
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 20),

//                       // Dự báo thời tiết hàng giờ
//                       Text('Dự báo hàng giờ',
//                           style: TextStyle(color: Colors.white, fontSize: 20)),
//                       const SizedBox(height: 10),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: hourlyForecast.map((forecast) {
//                           return Column(
//                             children: [
//                               Text(forecast['hour'] ?? '',
//                                   style: TextStyle(color: Colors.white)),
//                               buildWeatherIcon(
//                                   forecast['condition'] ?? 'Trời quang'),
//                               Text(forecast['temp'] ?? '',
//                                   style: TextStyle(color: Colors.white)),
//                             ],
//                           );
//                         }).toList(),
//                       ),
//                       const Spacer(),

//                       // Trạng thái rèm và mưa
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text('Trạng thái rèm:',
//                               style: TextStyle(color: Colors.white)),
//                           Container(
//                             height: 20,
//                             width: 50,
//                             decoration: BoxDecoration(
//                               border: Border.all(color: Colors.white),
//                               borderRadius: BorderRadius.circular(5),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 10),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text('Trạng thái mưa:',
//                               style: TextStyle(color: Colors.white)),
//                           Container(
//                             height: 20,
//                             width: 50,
//                             decoration: BoxDecoration(
//                               border: Border.all(color: Colors.white),
//                               borderRadius: BorderRadius.circular(5),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 20),

//                       // Ngày và giờ
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(currentDate,
//                               style: TextStyle(color: Colors.white)),
//                           Text(currentTime,
//                               style: TextStyle(color: Colors.white)),
//                         ],
//                       ),
//                       const SizedBox(height: 20),

//                       // Nút chuyển đổi với animation
//                       Center(
//                         child: GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               isAuto = !isAuto;
//                             });
//                           },
//                           child: AnimatedContainer(
//                             duration: const Duration(milliseconds: 300),
//                             height: 80,
//                             width: 300,
//                             decoration: BoxDecoration(
//                               border: Border.all(color: Colors.grey, width: 2),
//                               borderRadius: BorderRadius.circular(40),
//                             ),
//                             child: Stack(
//                               children: [
//                                 AnimatedAlign(
//                                   duration: const Duration(milliseconds: 300),
//                                   alignment: isAuto
//                                       ? Alignment.centerLeft
//                                       : Alignment.centerRight,
//                                   child: Container(
//                                     height: 70,
//                                     width: 120,
//                                     margin: const EdgeInsets.all(5),
//                                     decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       border: Border.all(
//                                           color: Colors.grey, width: 2),
//                                       borderRadius: BorderRadius.circular(35),
//                                     ),
//                                     child: Center(
//                                       child: Text(
//                                         isAuto ? 'Tự động' : 'Thủ công',
//                                         style: const TextStyle(
//                                           color: Colors.black,
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),

//                       if (!isAuto) const SizedBox(height: 20),
//                       if (!isAuto)
//                         Container(
//                           width: double.infinity,
//                           height: 80,
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.white, width: 2),
//                           ),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               const Icon(Icons.arrow_left,
//                                   color: Colors.blue, size: 50),
//                               Container(
//                                   width: 60,
//                                   height: 60,
//                                   decoration: BoxDecoration(
//                                       border: Border.all(color: Colors.blue))),
//                               Container(
//                                   width: 60,
//                                   height: 60,
//                                   decoration: BoxDecoration(
//                                       border: Border.all(color: Colors.blue))),
//                               Container(
//                                   width: 60,
//                                   height: 60,
//                                   decoration: BoxDecoration(
//                                       border: Border.all(color: Colors.blue))),
//                               const Icon(Icons.arrow_right,
//                                   color: Colors.blue, size: 50),
//                             ],
//                           ),
//                         ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

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
//   List<Map<String, String>> hourlyForecast = [
//     {'hour': '10 AM', 'temp': '22°C', 'condition': 'Trời quang'},
//     {'hour': '11 AM', 'temp': '24°C', 'condition': 'Ít mây'},
//     {'hour': '12 PM', 'temp': '26°C', 'condition': 'Mưa'},
//     {'hour': '1 PM', 'temp': '27°C', 'condition': 'Nhiều mây'},
//     // Thêm các dự báo trong 24 giờ
//   ]; // Dữ liệu dự báo hàng giờ
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
        icon = Icons.cloud; // Biểu tượng cho ít mây
        break;
      case 'Mưa':
        icon = Icons.beach_access; // Biểu tượng cho mưa
        break;
      case 'Nhiều mây':
        icon = Icons.cloud_queue; // Biểu tượng cho nhiều mây
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
                          width: double.infinity,
                          height: 80,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Icon(Icons.arrow_left,
                                  color: Colors.blue, size: 50),
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.blue)),
                              ),
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.blue)),
                              ),
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.blue)),
                              ),
                              const Icon(Icons.arrow_right,
                                  color: Colors.blue, size: 50),
                            ],
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
    );
  }
}
