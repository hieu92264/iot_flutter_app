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

//   @override
//   void initState() {
//     super.initState();
//     _capNhatNgayGio(); // Gọi hàm để cập nhật ngày và giờ
//   }

//   // Hàm để cập nhật ngày và giờ hiện tại mỗi giây
//   void _capNhatNgayGio() {
//     Timer.periodic(const Duration(seconds: 1), (timer) {
//       final hienTai = DateTime.now();
//       final dinhDangNgay =
//           DateFormat('dd/MM/yyyy').format(hienTai); // Định dạng ngày
//       final dinhDangGio =
//           DateFormat('HH:mm:ss').format(hienTai); // Định dạng giờ

//       setState(() {
//         _ngayHienTai = dinhDangNgay; // Cập nhật ngày
//         _gioHienTai = dinhDangGio; // Cập nhật giờ
//       });
//     });
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

import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:iot_flutter_app/components/base_screen.dart'; // Để định dạng ngày và giờ

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _ngayHienTai = '';
  String _gioHienTai = '';
  bool isAuto = true; // Biến để theo dõi trạng thái tự động hoặc thủ công
  Timer? _timer; // Thêm biến timer

  @override
  void initState() {
    super.initState();
    _capNhatNgayGio(); // Gọi hàm để cập nhật ngày và giờ
  }

  // Hàm để cập nhật ngày và giờ hiện tại mỗi giây
  void _capNhatNgayGio() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final hienTai = DateTime.now();
      final dinhDangNgay =
          DateFormat('dd/MM/yyyy').format(hienTai); // Định dạng ngày
      final dinhDangGio =
          DateFormat('HH:mm:ss').format(hienTai); // Định dạng giờ

      if (mounted) {
        // Kiểm tra xem widget có còn trong cây không
        setState(() {
          _ngayHienTai = dinhDangNgay; // Cập nhật ngày
          _gioHienTai = dinhDangGio; // Cập nhật giờ
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Hủy timer khi widget bị hủy
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: "Home",
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
            // Tự động điều chỉnh chiều cao dựa trên nội dung
            constraints: BoxConstraints(
              maxHeight: isAuto ? 600 : 700, // Chiều cao tối đa
            ),
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.black.withOpacity(0.1), // Màu nền
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
                      // Biểu đồ ánh sáng
                      const Text('Biểu đồ ánh sáng',
                          style: TextStyle(color: Colors.white)),
                      Container(
                        height: 60,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Biểu đồ mưa
                      const Text('Biểu đồ mưa',
                          style: TextStyle(color: Colors.white)),
                      Container(
                        height: 60,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Biểu đồ nhiệt độ và độ ẩm
                      const Text('Biểu đồ nhiệt độ - độ ẩm',
                          style: TextStyle(color: Colors.white)),
                      Container(
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      const SizedBox(height: 20),
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
                      const Spacer(),
                      // Ngày và giờ
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(_ngayHienTai,
                              style: const TextStyle(color: Colors.white)),
                          Text(_gioHienTai,
                              style: const TextStyle(color: Colors.white)),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // Nút kéo với chuyển động
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isAuto =
                                  !isAuto; // Đổi trạng thái khi nhấn vào nút
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(
                                milliseconds: 300), // Hiệu ứng chuyển đổi
                            height: 80,
                            width: 300, // Kích thước nút lớn hơn
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey,
                                  width: 2), // Đường viền xám cho nút lớn
                              borderRadius: BorderRadius.circular(
                                  40), // Hình dạng bầu dục
                            ),
                            child: Stack(
                              children: [
                                // Vòng bầu dục bên trong để di chuyển
                                AnimatedAlign(
                                  duration: const Duration(milliseconds: 300),
                                  alignment: isAuto
                                      ? Alignment.centerLeft
                                      : Alignment.centerRight,
                                  child: Container(
                                    height: 70,
                                    width: 120, // Kích thước bầu dục ngang
                                    margin: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: Colors.white, // Màu vòng bầu dục
                                      border: Border.all(
                                          color: Colors.grey,
                                          width:
                                              2), // Đường viền xám cho vòng bầu dục
                                      borderRadius: BorderRadius.circular(
                                          35), // Hình dạng bầu dục
                                    ),
                                    child: Center(
                                      child: Text(
                                        isAuto ? 'Tự động' : 'Thủ công',
                                        style: const TextStyle(
                                          color: Colors
                                              .black, // Màu chữ bên trong nút
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
                      if (!isAuto)
                        const SizedBox(
                            height:
                                20), // Khoảng cách giữa nút và container bên dưới
                      if (!isAuto) // Chỉ hiển thị nếu không phải tự động
                        Container(
                          width: double.infinity,
                          height: 80, // Chiều cao của container
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.white,
                                width: 2), // Đường viền trắng cho container
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Icon(Icons.arrow_left,
                                  color: Colors.blue,
                                  size: 50), // Kích thước mũi tên trái
                              Container(
                                width: 60, // Kích thước hình
                                height: 60,
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  border: Border.all(color: Colors.blue),
                                ),
                              ),
                              Container(
                                width: 60, // Kích thước hình
                                height: 60,
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  border: Border.all(color: Colors.blue),
                                ),
                              ),
                              Container(
                                width: 60, // Kích thước hình
                                height: 60,
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  border: Border.all(color: Colors.blue),
                                ),
                              ),
                              const Icon(Icons.arrow_right,
                                  color: Colors.blue,
                                  size: 50), // Kích thước mũi tên phải
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
