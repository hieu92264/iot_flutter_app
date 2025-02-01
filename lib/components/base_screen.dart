// import 'package:flutter/material.dart';
// import 'header_bar.dart'; // Import your header bar
// import 'footer_bar.dart'; // Import your footer bar

// class BaseScreen extends StatelessWidget {
//   final Widget child;

//   final String title;

//   // BaseScreen({required this.child});

//   BaseScreen({required this.title, required this.child});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               Color(0xFF50C9C3), // Light gradient color
//               Color(0xFF96DEDA), // Dark gradient color
//             ],
//           ),
//         ),
//         child: Column(
//           children: [
//             HeaderBar(
//               title: title,
//               isBackButtonVisible: false,
//             ), // Custom header widget
//             Expanded(child: child), // Place the content of the screen
//             FooterBar(), // Custom footer widget
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'dart:ui'; // For blur effect
// import 'header_bar.dart'; // Import your header bar
// import 'footer_bar.dart'; // Import your footer bar

// class BaseScreen extends StatelessWidget {
//   final Widget child;
//   final String title;

//   BaseScreen({required this.title, required this.child});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         height: double.infinity,
//         width: double.infinity,
//         decoration: const BoxDecoration(
//           image: DecorationImage(
//             image:
//                 AssetImage('assets/images/background.jpeg'), // Background image
//             fit: BoxFit.fill,
//           ),
//         ),
//         child: Column(
//           children: [
//             HeaderBar(
//               title: title,
//               isBackButtonVisible: false,
//             ), // Custom header widget
//             Expanded(
//               child: Container(
//                 margin: const EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20),
//                   // Removed the dark overlay by removing the color property here
//                 ),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(20),
//                   child: BackdropFilter(
//                     filter:
//                         ImageFilter.blur(sigmaX: 5, sigmaY: 5), // Blur effect
//                     child: Column(
//                       children: [
//                         Expanded(child: child), // Your main content here
//                         FooterBar(), // Custom footer widget
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'dart:ui'; // For blur effect
import 'header_bar.dart'; // Import your header bar
import 'footer_bar.dart'; // Import your footer bar

class BaseScreen extends StatefulWidget {
  final Widget child;
  final String title;

  BaseScreen({required this.title, required this.child});

  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int _currentIndex = 0; // Track the current index

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image:
                AssetImage('assets/images/background.jpeg'), // Background image
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: [
            HeaderBar(
              title: widget.title,
              isBackButtonVisible: false,
            ), // Custom header widget
            Expanded(child: widget.child), // Main content
            FooterBar(
              currentIndex: _currentIndex,
              onTap: (int index) {
                setState(() {
                  _currentIndex = index; // Update the selected index
                });
              },
            ), // Custom footer widget
          ],
        ),
      ),
    );
  }
}
