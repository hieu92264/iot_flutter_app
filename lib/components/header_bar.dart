// import 'package:flutter/material.dart';

// class HeaderBar extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Total Balance (USD)',
//             style: TextStyle(color: Colors.white, fontSize: 18),
//           ),
//           Text(
//             '\$42,296.21',
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 32,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           Text(
//             '+8.82% (+\$70)',
//             style: TextStyle(color: Colors.greenAccent, fontSize: 16),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class HeaderBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isBackButtonVisible;

  HeaderBar({required this.title, required this.isBackButtonVisible});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: isBackButtonVisible
          ? IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pop(); // Quay lại màn hình trước
              },
            )
          : null,
      title: Center(
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.settings, color: Colors.white),
          onPressed: () {
            // Xử lý hành động cài đặt ở đây
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
