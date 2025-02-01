// import 'package:flutter/material.dart';

// class FooterBar extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       backgroundColor: Colors.transparent,
//       items: [
//         BottomNavigationBarItem(
//           icon: Icon(Icons.home, color: Colors.white),
//           label: 'Home',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.account_balance_wallet, color: Colors.white),
//           label: 'Wallet',
//         ),
//       ],
//     );
//   }
// }

// import 'package:flutter/material.dart';

// class FooterBar extends StatefulWidget {
//   final int currentIndex;
//   final Function(int) onTap;

//   FooterBar({required this.currentIndex, required this.onTap});

//   @override
//   _FooterBarState createState() => _FooterBarState();
// }

// class _FooterBarState extends State<FooterBar> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.transparent, // Không có màu nền
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.4), // Màu bóng nhẹ
//             spreadRadius: 5,
//             blurRadius: 10, // Độ mờ của bóng
//             offset: Offset(0, -5), // Bóng đổ lên trên
//           ),
//         ],
//       ),
//       padding: const EdgeInsets.only(bottom: 10),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               _buildNavItem(Icons.home, 'Home', 0),
//               _buildNavItem(Icons.notifications, 'Notifycation', 1),
//               _buildNavItem(Icons.person, 'user', 2)
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildNavItem(IconData icon, String label, int index) {
//     return GestureDetector(
//       onTap: () {
//         widget.onTap(index);
//         Navigator.pushNamed(
//           context,
//         );
//       },
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(
//             icon,
//             color: widget.currentIndex == index ? Colors.white : Colors.grey,
//           ),
//           Text(
//             label,
//             style: TextStyle(
//               color: widget.currentIndex == index ? Colors.white : Colors.grey,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class FooterBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  FooterBar({required this.currentIndex, required this.onTap});

  @override
  _FooterBarState createState() => _FooterBarState();
}

class _FooterBarState extends State<FooterBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent, // Không có màu nền
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4), // Màu bóng nhẹ
            spreadRadius: 5,
            blurRadius: 10, // Độ mờ của bóng
            offset: const Offset(0, -5), // Bóng đổ lên trên
          ),
        ],
      ),
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home, 'Home', 0, context, '/home'),
              // _buildNavItem(Icons.notifications, 'Notification', 1, context,
              //     '/notifications'),
              _buildNavItem(Icons.person, 'User', 2, context, '/user'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index,
      BuildContext context, String route) {
    return GestureDetector(
      onTap: () {
        widget.onTap(index); // Update index in parent
        Navigator.pushReplacementNamed(
            context, route); // Điều hướng tới màn hình tương ứng
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: widget.currentIndex == index ? Colors.white : Colors.grey,
          ),
          Text(
            label,
            style: TextStyle(
              color: widget.currentIndex == index ? Colors.white : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
